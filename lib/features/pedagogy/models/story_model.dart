class StoryPage {
  final String text;
  final String imageAsset;
  final String audioAsset;
  final List<String> highlightWords;

  StoryPage({
    required this.text,
    required this.imageAsset,
    required this.audioAsset,
    this.highlightWords = const [],
  });
}

class StoryModel {
  final String id;
  final String title;
  final String coverImage;
  final List<StoryPage> pages;

  StoryModel({
    required this.id,
    required this.title,
    required this.coverImage,
    required this.pages,
  });
}
