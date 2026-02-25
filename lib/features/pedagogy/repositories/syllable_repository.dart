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
      fullWord: "DADO",
      mandatorySyllables: ["DA", "DO"],
      imageAsset: "assets/images/words/dice.png",
      soundAsset: "audio/words/dado.mp3",
    ),
    WordModel(
      fullWord: "CASA",
      mandatorySyllables: ["CA", "SA"],
      imageAsset: "assets/images/words/house.png",
      soundAsset: "audio/words/casa.mp3",
    ),
  ];

  WordModel getNextWord() {
    return (_words..shuffle()).first;
  }
}
