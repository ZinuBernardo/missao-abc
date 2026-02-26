import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioServiceProvider = Provider((ref) => AudioService());

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playAsset(String assetPath) async {
    try {
      await _player.play(AssetSource(assetPath));
    } catch (e) {
      print("Erro ao tocar áudio: $e");
    }
  }

  Future<void> playCorrect() async {
    await playAsset('audio/effects/correct.mp3');
  }

  Future<void> playWrong() async {
    await playAsset('audio/effects/wrong.mp3');
  }
}
