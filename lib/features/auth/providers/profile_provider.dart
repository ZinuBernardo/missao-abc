import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_profile.dart';
import 'auth_provider.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, UserProfile?>((ref) {
  return ProfileNotifier();
});

final availableProfilesProvider = StreamProvider<List<UserProfile>>((ref) {
  final user = ref.watch(authProvider).value;
  if (user == null) return Stream.value([]);

  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('profiles')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return UserProfile(
        id: doc.id,
        name: data['name'] ?? 'Novo Herói',
        avatarAsset: data['avatarAsset'] ?? 'assets/images/avatars/boy.png',
        totalStars: data['totalStars'] ?? 0,
        totalGames: data['totalGames'] ?? 0,
        progress: Map<String, double>.from(data['progress'] ?? {}),
      );
    }).toList();
  });
});

class ProfileNotifier extends StateNotifier<UserProfile?> {
  ProfileNotifier() : super(null);

  void selectProfile(UserProfile profile) {
    state = profile;
  }

  Future<void> updateStars(int stars) async {
    if (state != null) {
      final newTotal = state!.totalStars + stars;
      state = UserProfile(
        id: state!.id,
        name: state!.name,
        avatarAsset: state!.avatarAsset,
        totalStars: newTotal,
        totalGames: state!.totalGames,
        progress: state!.progress,
      );

      // Sincronizar com Firestore
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('profiles')
              .doc(state!.id)
              .update({'totalStars': newTotal});
        }
      } catch (e) {
        print("Erro ao sincronizar estrelas: $e");
      }
    }
  }

  Future<void> createProfile(String name, String avatarAsset) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('profiles')
          .doc();
      
      final newProfile = {
        'name': name,
        'avatarAsset': avatarAsset,
        'totalStars': 0,
        'progress': {},
        'createdAt': FieldValue.serverTimestamp(),
      };
      await docRef.set(newProfile);
    } catch (e) {
      print("Erro ao criar perfil: $e");
    }
  }

  Future<void> unlockSticker(String stickerId, int cost) async {
    if (state != null && state!.totalStars >= cost) {
      final newTotal = state!.totalStars - cost;
      
      // Atualizar estado local
      state = UserProfile(
        id: state!.id,
        name: state!.name,
        avatarAsset: state!.avatarAsset,
        totalStars: newTotal,
        totalGames: state!.totalGames,
        progress: state!.progress,
      );

      // Sincronizar com Firestore
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final profileRef = FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('profiles')
              .doc(state!.id);

          await FirebaseFirestore.instance.runTransaction((transaction) async {
            transaction.update(profileRef, {
              'totalStars': newTotal,
              'unlockedStickers': FieldValue.arrayUnion([stickerId]),
            });
          });
        }
      } catch (e) {
        print("Erro ao desbloquear figurinha: $e");
      }
    }
  }

  Future<void> updateProgress(String category, double increment) async {
    if (state != null) {
      final currentProgress = state!.progress[category] ?? 0.0;
      final newProgress = (currentProgress + increment).clamp(0.0, 1.0);
      
      final updatedProgress = Map<String, double>.from(state!.progress);
      updatedProgress[category] = newProgress;

      state = UserProfile(
        id: state!.id,
        name: state!.name,
        avatarAsset: state!.avatarAsset,
        totalStars: state!.totalStars,
        totalGames: state!.totalGames + 1,
        progress: updatedProgress,
      );

      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('profiles')
              .doc(state!.id)
              .update({
                'progress.$category': newProgress,
                'totalGames': FieldValue.increment(1),
              });
        }
      } catch (e) {
        print("Erro ao atualizar progresso: $e");
      }
    }
  }
}

// Removido o provider estático para usar o StreamProvider acima
