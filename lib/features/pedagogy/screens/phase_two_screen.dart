import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/syllable_model.dart';
import '../repositories/syllable_repository.dart';
import '../../../core/services/audio_service.dart';
import '../../auth/providers/profile_provider.dart';

final syllableRepositoryProvider = Provider((ref) => SyllableRepository());

final currentWordProvider = StateProvider<WordModel>((ref) {
  return ref.read(syllableRepositoryProvider).getNextWord();
});

class PhaseTwoScreen extends ConsumerStatefulWidget {
  const PhaseTwoScreen({super.key});

  @override
  ConsumerState<PhaseTwoScreen> createState() => _PhaseTwoScreenState();
}

class _PhaseTwoScreenState extends ConsumerState<PhaseTwoScreen> {
  final List<String?> _userSyllables = [];
  late WordModel _currentWord;

  @override
  void initState() {
    super.initState();
    _loadNextWord();
  }

  void _loadNextWord() {
    _currentWord = ref.read(syllableRepositoryProvider).getNextWord();
    _userSyllables.clear();
    for (var i = 0; i < _currentWord.mandatorySyllables.length; i++) {
      _userSyllables.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFA29BFE), Color(0xFF6C5CE7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildWordImage(_currentWord),
              const SizedBox(height: 30),
              _buildSyllableSlots(_currentWord),
              const Spacer(),
              _buildAvailableSyllables(_currentWord),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final profile = ref.watch(profileProvider);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 32),
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 24),
                const SizedBox(width: 8),
                Text(
                  '${profile?.totalStars ?? 0}',
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWordImage(WordModel word) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 15)],
      ),
      child: Column(
        children: [
          const Icon(Icons.cake, size: 100, color: Colors.pink), // Placeholder para imagem real
          const SizedBox(height: 10),
          IconButton(
            icon: const Icon(Icons.volume_up, color: Color(0xFF6C5CE7), size: 40),
            onPressed: () => ref.read(audioServiceProvider).playAsset(word.soundAsset),
          ),
        ],
      ),
    );
  }

  Widget _buildSyllableSlots(WordModel word) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(word.mandatorySyllables.length, (index) {
        return DragTarget<String>(
          onAccept: (receivedSyllable) {
            if (receivedSyllable == word.mandatorySyllables[index]) {
              setState(() {
                _userSyllables[index] = receivedSyllable;
              });
              ref.read(audioServiceProvider).playAsset('audio/syllables/${receivedSyllable.toLowerCase()}.mp3');
              _checkWin();
            } else {
              ref.read(audioServiceProvider).playWrong();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Tente outra sílaba!"), duration: Duration(seconds: 1)),
              );
            }
          },
          builder: (context, candidateData, rejectedData) {
            final isFilled = _userSyllables[index] != null;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: isFilled ? Colors.white : Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Center(
                child: Text(
                  _userSyllables[index] ?? "?",
                  style: TextStyle(
                    color: isFilled ? const Color(0xFF6C5CE7) : Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _checkWin() {
    if (!_userSyllables.contains(null)) {
      ref.read(audioServiceProvider).playCorrect();
      ref.read(profileProvider.notifier).updateStars(15);
      ref.read(profileProvider.notifier).updateProgress('syllables', 0.1); // +10% por palavra
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Center(child: Text("Muito bem! 🌟", style: TextStyle(fontWeight: FontWeight.bold))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 16),
            Text("Você montou a palavra ${_currentWord.fullWord}!"),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _loadNextWord();
                });
              },
              child: const Text("PRÓXIMA"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableSyllables(WordModel word) {
    final List<String> options = List.from(word.mandatorySyllables)..addAll(["MA", "PA", "TO"]);
    options.shuffle();

    return Wrap(
      spacing: 15,
      runSpacing: 15,
      alignment: WrapAlignment.center,
      children: options.map((s) {
        final isAlreadyUsed = _userSyllables.contains(s);
        if (isAlreadyUsed) return const SizedBox(width: 70, height: 70);

        return Draggable<String>(
          data: s,
          feedback: _buildSyllableChip(s, isDragging: true),
          childWhenDragging: Opacity(opacity: 0.3, child: _buildSyllableChip(s)),
          child: _buildSyllableChip(s),
        );
      }).toList(),
    );
  }

  Widget _buildSyllableChip(String text, {bool isDragging = false}) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: isDragging ? [BoxShadow(color: Colors.black45, blurRadius: 10)] : [],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF6C5CE7)),
        ),
      ),
    );
  }
}
