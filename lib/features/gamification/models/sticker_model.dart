class StickerModel {
  final String id;
  final String name;
  final String imageAsset;
  final bool isUnlocked;

  StickerModel({
    required this.id,
    required this.name,
    required this.imageAsset,
    this.isUnlocked = false,
  });
}
