import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, UserProfile?>((ref) {
  return ProfileNotifier();
});

final availableProfilesProvider = StreamProvider<List<UserProfile>>((ref) {
  return FirebaseFirestore.instance.collection('profiles').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return UserProfile(
        id: doc.id,
        name: data['name'] ?? 'Novo Herói',
        avatarAsset: data['avatarAsset'] ?? 'assets/images/avatars/boy.png',
        totalStars: data['totalStars'] ?? 0,
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
        progress: state!.progress,
      );

      // Sincronizar com Firestore
      try {
        await FirebaseFirestore.instance
            .collection('profiles')
            .doc(state!.id)
            .update({'totalStars': newTotal});
      } catch (e) {
        print("Erro ao sincronizar estrelas: $e");
      }
    }
  }
}

// Removido o provider estático para usar o StreamProvider acima
