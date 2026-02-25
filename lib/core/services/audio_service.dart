import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioServiceProvider = Provider((ref) => AudioService());

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playSound(String assetPath) async {
    try {
      await _player.play(AssetSource(assetPath));
    } catch (e) {
      print("Erro ao tocar som: $e");
    }
  }

  Future<void> playSuccess() async {
    await playSound('audio/effects/success.mp3');
  }

  Future<void> playError() async {
    await playSound('audio/effects/error.mp3');
  }
}
