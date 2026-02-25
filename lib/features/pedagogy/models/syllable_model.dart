class SyllableModel {
  final String text;
  final String soundAsset;

  SyllableModel({required this.text, required this.soundAsset});
}

class WordModel {
  final String fullWord;
  final List<String> mandatorySyllables;
  final String imageAsset;
  final String soundAsset;

  WordModel({
    required this.fullWord,
    required this.mandatorySyllables,
    required this.imageAsset,
    required this.soundAsset,
  });
}
