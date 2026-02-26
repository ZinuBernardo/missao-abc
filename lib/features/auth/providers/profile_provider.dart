import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, UserProfile?>((ref) {
  return ProfileNotifier();
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

final availableProfilesProvider = Provider<List<UserProfile>>((ref) {
  return [
    UserProfile(id: '1', name: 'Davi', avatarAsset: 'assets/images/avatars/boy.png', totalStars: 150),
    UserProfile(id: '2', name: 'Alice', avatarAsset: 'assets/images/avatars/girl.png', totalStars: 45),
  ];
});
