import '../models/syllable_model.dart';

class SyllableRepository {
  final List<WordModel> _words = [
    WordModel(
      fullWord: "BOLO",
      mandatorySyllables: ["BO", "LO"],
      imageAsset: "assets/images/words/cake.png",
      soundAsset: "audio/words/bolo.mp3",
    ),
    WordModel(
      fullWord: "BOLA",
      mandatorySyllables: ["BO", "LA"],
      imageAsset: "assets/images/words/ball.png",
      soundAsset: "audio/words/bola.mp3",
    ),
    WordModel(
      fullWord: "GATO",
      mandatorySyllables: ["GA", "TO"],
      imageAsset: "assets/images/words/cat.png",
      soundAsset: "audio/words/gato.mp3",
    ),
    WordModel(
      fullWord: "SAPO",
      mandatorySyllables: ["SA", "PO"],
      imageAsset: "assets/images/words/frog.png",
      soundAsset: "audio/words/sapo.mp3",
    ),
    WordModel(
      fullWord: "MESA",
      mandatorySyllables: ["ME", "SA"],
      imageAsset: "assets/images/words/table.png",
      soundAsset: "audio/words/mesa.mp3",
    ),
  ];

  WordModel getNextWord() {
    return (_words..shuffle()).first;
  }
}
