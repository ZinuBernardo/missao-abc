import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/letter_model.dart';
import '../repositories/pedagogy_repository.dart';

final pedagogyRepositoryProvider = Provider((ref) => PedagogyRepository());

final gameSessionProvider = StateProvider<GameSession>((ref) {
  return ref.read(pedagogyRepositoryProvider).generateSession();
});

class PhaseOneScreen extends ConsumerWidget {
  const PhaseOneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(gameSessionProvider);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF64B5F6), Color(0xFF1976D2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, ref),
              const Spacer(),
              _buildInstruction(session.target.char),
              const SizedBox(height: 40),
              _buildOptions(context, ref, session),
              const Spacer(),
              _buildProgressBar(),
            ],
          ),
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstruction(String targetChar) {
    return Column(
      children: [
        const Text(
          "Toque na letra",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.volume_up,
            size: 60,
            color: Color(0xFF1976D2),
          ),
        ),
      ],
    );
  }

  Widget _buildOptions(BuildContext context, WidgetRef ref, GameSession session) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: session.options.map((letter) {
        return GestureDetector(
          onTap: () => _handleSelection(context, ref, letter, session.target),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: Text(
                letter.char,
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _handleSelection(BuildContext context, WidgetRef ref, LetterModel selected, LetterModel target) {
    if (selected.char == target.char) {
      // Sucesso! Sincronizar estrelas com Firebase
      ref.read(profileProvider.notifier).updateStars(10);
      ref.read(profileProvider.notifier).updateProgress('letters', 0.04); // +4% por letra
      _showSuccessDialog(context, ref);
    } else {
      // Erro (Vibração leve ou som de erro)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tente novamente!"),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void _showSuccessDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Center(
          child: Text(
            "Parabéns! 🌟",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 80),
            SizedBox(height: 16),
            Text("Você acertou a letra!"),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                Navigator.pop(context);
                ref.read(gameSessionProvider.notifier).state = 
                    ref.read(pedagogyRepositoryProvider).generateSession();
              },
              child: const Text("PRÓXIMA", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Progresso", style: TextStyle(color: Colors.white70)),
              Text("3/10", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.3,
              minHeight: 12,
              backgroundColor: Colors.white24,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFD700)),
            ),
          ),
        ],
      ),
    );
  }
}
