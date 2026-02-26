class UserProfile {
  final String id;
  final String name;
  final String avatarAsset;
  final int totalStars;
  final int totalGames;
  final Map<String, double> progress; // 'letters': 0.5, etc.

  UserProfile({
    required this.id,
    required this.name,
    required this.avatarAsset,
    this.totalStars = 0,
    this.totalGames = 0,
    this.progress = const {},
  });
}
