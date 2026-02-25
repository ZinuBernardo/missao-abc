import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, UserProfile?>((ref) {
  return ProfileNotifier();
});

class ProfileNotifier extends StateNotifier<UserProfile?> {
  ProfileNotifier() : super(null);

  void selectProfile(UserProfile profile) {
    state = profile;
  }

  void updateStars(int stars) {
    if (state != null) {
      state = UserProfile(
        id: state!.id,
        name: state!.name,
        avatarAsset: state!.avatarAsset,
        totalStars: state!.totalStars + stars,
        progress: state!.progress,
      );
    }
  }
}

final availableProfilesProvider = Provider<List<UserProfile>>((ref) {
  return [
    UserProfile(id: '1', name: 'Davi', avatarAsset: 'assets/images/avatars/boy.png', totalStars: 150),
    UserProfile(id: '2', name: 'Alice', avatarAsset: 'assets/images/avatars/girl.png', totalStars: 45),
  ];
});
