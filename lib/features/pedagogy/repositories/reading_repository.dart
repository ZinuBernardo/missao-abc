import '../models/reading_model.dart';

class ReadingRepository {
  final List<ReadingModule> _modules = [
    ReadingModule(
      word: "GATO",
      imageAsset: "assets/images/words/cat.png",
      audioAsset: "audio/words/gato.mp3",
      options: ["GATO", "PATO", "RATO"],
      correctAnswer: "GATO",
    ),
    ReadingModule(
      word: "BOLA",
      imageAsset: "assets/images/words/ball.png",
      audioAsset: "audio/words/bola.mp3",
      options: ["BALA", "BOLA", "BOLO"],
      correctAnswer: "BOLA",
    ),
    ReadingModule(
      word: "MAÇÃ",
      imageAsset: "assets/images/words/apple.png",
      audioAsset: "audio/words/maca.mp3",
      options: ["MAÇÃ", "MAPA", "MALA"],
      correctAnswer: "MAÇÃ",
    ),
  ];

  ReadingModule getRandomModule() {
    return (_modules..shuffle()).first;
  }
}
