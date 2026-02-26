import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../models/reading_model.dart';
import '../repositories/reading_repository.dart';
import '../../../core/services/audio_service.dart';
import '../../../core/widgets/premium_success_dialog.dart';
import '../../auth/providers/profile_provider.dart';

final readingRepositoryProvider = Provider((ref) => ReadingRepository());

final currentReadingModuleProvider = StateProvider<ReadingModule>((ref) {
  return ref.read(readingRepositoryProvider).getRandomModule();
});

class PhaseThreeScreen extends ConsumerWidget {
  const PhaseThreeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final module = ref.watch(currentReadingModuleProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F9FF),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, ref),
            const SizedBox(height: 20),
            const Text(
              "O que está na imagem?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF075985)),
            ),
            const Spacer(),
            _buildMainImage(module),
            const Spacer(),
            _buildReadingOptions(context, ref, module),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0369A1)),
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF0369A1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.orangeAccent, size: 24),
                const SizedBox(width: 8),
                Text(
                  '${profile?.totalStars ?? 0}',
                  style: const TextStyle(
                    color: Color(0xFF0369A1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 48), // Equilíbrio
        ],
      ),
    );
  }

  Widget _buildMainImage(ReadingModule module) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.image, size: 100, color: Colors.blueGrey),
            Positioned(
              bottom: 20,
              child: IconButton(
                icon: const Icon(Icons.volume_up, size: 40, color: Color(0xFF0369A1)),
                onPressed: () => ref.read(audioServiceProvider).playAsset(module.audioAsset),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadingOptions(BuildContext context, WidgetRef ref, ReadingModule module) {
    return Column(
      children: module.options.map((option) {
        return GestureDetector(
          onTap: () {
            ref.read(audioServiceProvider).playPop();
            _handleChoice(context, ref, option, module.correctAnswer);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: const Color(0xFFE0F2FE), width: 2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0369A1).withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: Text(
                option,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0369A1),
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _handleChoice(BuildContext context, WidgetRef ref, String choice, String correct) {
    if (choice == correct) {
      ref.read(audioServiceProvider).playCorrect();
      ref.read(profileProvider.notifier).updateStars(20);
      ref.read(profileProvider.notifier).updateProgress('words', 0.15); // +15% por leitura
      _showSuccess(context, ref);
    } else {
      ref.read(audioServiceProvider).playWrong();
      _showError(context);
    }
  }

  void _showSuccess(BuildContext context, WidgetRef ref) {
    showPremiumSuccess(
      context,
      title: "EXCELENTE! 🎈",
      message: "Você é um mestre da leitura!",
      stars: 20,
      onNext: () {
        ref.read(currentReadingModuleProvider.notifier).state = 
            ref.read(readingRepositoryProvider).getRandomModule();
      },
    );
  }

  void _showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Tente ler novamente! Você consegue! 💪"),
        backgroundColor: Colors.orange[400],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
