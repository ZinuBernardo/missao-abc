import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../models/reading_model.dart';
import '../repositories/reading_repository.dart';

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
            _buildHeader(context),
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0369A1)),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: LinearProgressIndicator(
              value: 0.6,
              minHeight: 10,
              backgroundColor: Color(0xFFE0F2FE),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF38BDF8)),
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
                onPressed: () {},
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
          onTap: () => _handleChoice(context, ref, option, module.correctAnswer),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFBAE6FD), width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                option,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Color(0xFF0C4A6E),
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
      _showSuccess(context, ref);
    } else {
      _showError(context);
    }
  }

  void _showSuccess(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "EXCELENTE! 🎈",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 20),
            const Icon(Icons.star, size: 80, color: Colors.orangeAccent),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                Navigator.pop(context);
                ref.read(currentReadingModuleProvider.notifier).state = 
                    ref.read(readingRepositoryProvider).getRandomModule();
              },
              child: const Text("PRÓXIMO", style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
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
