import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/syllable_model.dart';
import '../repositories/syllable_repository.dart';

final syllableRepositoryProvider = Provider((ref) => SyllableRepository());

final currentWordProvider = StateProvider<WordModel>((ref) {
  return ref.read(syllableRepositoryProvider).getNextWord();
});

class PhaseTwoScreen extends ConsumerWidget {
  const PhaseTwoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final word = ref.watch(currentWordProvider);

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
              _buildWordImage(word),
              const SizedBox(height: 30),
              _buildSyllableSlots(word),
              const Spacer(),
              _buildAvailableSyllables(context, ref, word),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            "Monte a Palavra",
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
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
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSyllableSlots(WordModel word) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: word.mandatorySyllables.map((s) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white, width: 2, style: BorderStyle.solid),
          ),
          child: const Center(child: Text("?", style: TextStyle(color: Colors.white, fontSize: 32))),
        );
      }).toList(),
    );
  }

  Widget _buildAvailableSyllables(BuildContext context, WidgetRef ref, WordModel word) {
    // Mistura as sílabas corretas com algumas aleatórias
    final List<String> allOptions = List.from(word.mandatorySyllables)..addAll(["MA", "PE", "TI"]);
    allOptions.shuffle();

    return Wrap(
      spacing: 15,
      children: allOptions.map((s) {
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
