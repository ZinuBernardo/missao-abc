class LetterModel {
  final String char;
  final String soundAsset;
  final String imageAsset;

  LetterModel({
    required this.char,
    required this.soundAsset,
    required this.imageAsset,
  });
}

class GameSession {
  final List<LetterModel> options;
  final LetterModel target;

  GameSession({
    required this.options,
    required this.target,
  });
}
