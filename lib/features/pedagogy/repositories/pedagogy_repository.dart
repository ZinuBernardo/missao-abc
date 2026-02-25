import 'dart:math';
import '../models/letter_model.dart';

class PedagogyRepository {
  final List<LetterModel> _letters = [
    LetterModel(char: 'A', soundAsset: 'audio/a.mp3', imageAsset: 'images/a.png'),
    LetterModel(char: 'B', soundAsset: 'audio/b.mp3', imageAsset: 'images/b.png'),
    LetterModel(char: 'C', soundAsset: 'audio/c.mp3', imageAsset: 'images/c.png'),
    LetterModel(char: 'D', soundAsset: 'audio/d.mp3', imageAsset: 'images/d.png'),
    LetterModel(char: 'E', soundAsset: 'audio/e.mp3', imageAsset: 'images/e.png'),
  ];

  GameSession generateSession() {
    final random = Random();
    final List<LetterModel> shuffled = List.from(_letters)..shuffle();
    final options = shuffled.take(3).toList();
    final target = options[random.nextInt(options.length)];

    return GameSession(options: options, target: target);
  }
}
