class ReadingModule {
  final String word;
  final String imageAsset;
  final String audioAsset;
  final List<String> options; // Letras ou sílabas para completar, ou imagens para escolher
  final String correctAnswer;

  ReadingModule({
    required this.word,
    required this.imageAsset,
    required this.audioAsset,
    required this.options,
    required this.correctAnswer,
  });
}
