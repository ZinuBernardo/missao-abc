import 'dart:math';
import '../models/letter_model.dart';

class PedagogyRepository {
  final List<LetterModel> _letters = [
    LetterModel(char: 'A', soundAsset: 'audio/a.mp3', imageAsset: 'images/a.png'),
    LetterModel(char: 'B', soundAsset: 'audio/b.mp3', imageAsset: 'images/b.png'),
    LetterModel(char: 'C', soundAsset: 'audio/c.mp3', imageAsset: 'images/c.png'),
    LetterModel(char: 'D', soundAsset: 'audio/d.mp3', imageAsset: 'images/d.png'),
    LetterModel(char: 'E', soundAsset: 'audio/e.mp3', imageAsset: 'images/e.png'),
    LetterModel(char: 'F', soundAsset: 'audio/f.mp3', imageAsset: 'images/f.png'),
    LetterModel(char: 'G', soundAsset: 'audio/g.mp3', imageAsset: 'images/g.png'),
    LetterModel(char: 'H', soundAsset: 'audio/h.mp3', imageAsset: 'images/h.png'),
    LetterModel(char: 'I', soundAsset: 'audio/i.mp3', imageAsset: 'images/i.png'),
    LetterModel(char: 'O', soundAsset: 'audio/o.mp3', imageAsset: 'images/o.png'),
    LetterModel(char: 'U', soundAsset: 'audio/u.mp3', imageAsset: 'images/u.png'),
    LetterModel(char: 'L', soundAsset: 'audio/l.mp3', imageAsset: 'images/l.png'),
    LetterModel(char: 'M', soundAsset: 'audio/m.mp3', imageAsset: 'images/m.png'),
    LetterModel(char: 'P', soundAsset: 'audio/p.mp3', imageAsset: 'images/p.png'),
    LetterModel(char: 'S', soundAsset: 'audio/s.mp3', imageAsset: 'images/s.png'),
    LetterModel(char: 'T', soundAsset: 'audio/t.mp3', imageAsset: 'images/t.png'),
  ];

  GameSession generateSession() {
    final random = Random();
    final List<LetterModel> shuffled = List.from(_letters)..shuffle();
    final options = shuffled.take(3).toList();
    final target = options[random.nextInt(options.length)];

    return GameSession(options: options, target: target);
  }
}
