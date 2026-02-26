import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/letter_model.dart';
import '../repositories/pedagogy_repository.dart';
import '../../../core/services/audio_service.dart';
import '../../../core/widgets/premium_success_dialog.dart';
import '../../../core/widgets/interactive_hint.dart';
import '../../auth/providers/profile_provider.dart';

final pedagogyRepositoryProvider = Provider((ref) => PedagogyRepository());

final gameSessionProvider = StateProvider<GameSession>((ref) {
  return ref.read(pedagogyRepositoryProvider).generateSession();
});

class PhaseOneScreen extends ConsumerStatefulWidget {
  const PhaseOneScreen({super.key});

  @override
  ConsumerState<PhaseOneScreen> createState() => _PhaseOneScreenState();
}

class _PhaseOneScreenState extends ConsumerState<PhaseOneScreen> {
  bool _showHint = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) setState(() => _showHint = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(gameSessionProvider);
    final profile = ref.watch(profileProvider);
    final bool isFirstTime = (profile?.progress['letters'] ?? 0) < 0.1;

    return Scaffold(
      body: Stack(
        children: [
          Container(
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
          if (isFirstTime && _showHint)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => setState(() => _showHint = false),
                child: const InteractiveHint(
                  text: "Toque na letra igual!",
                  alignment: Alignment.center,
                ),
              ),
            ),
        ],
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
              color: Colors.white24,
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

  Widget _buildInstruction(String targetChar) {
    return Column(
      children: [
        const Text(
          "Encontre a letra:",
          style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.volume_up, size: 60, color: Color(0xFF1976D2)),
            onPressed: () => ref.read(audioServiceProvider).playAsset('audio/letters/${targetChar.toLowerCase()}.mp3'),
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
          onTap: () {
            ref.read(audioServiceProvider).playPop();
            _handleSelection(context, ref, letter, session.target);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.grey[50]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6C5CE7).withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Text(
                letter.char,
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3436),
                  letterSpacing: -2,
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
      ref.read(audioServiceProvider).playCorrect();
      ref.read(profileProvider.notifier).updateStars(10);
      ref.read(profileProvider.notifier).updateProgress('letters', 0.04);
      _showSuccessDialog(context, ref);
    } else {
      ref.read(audioServiceProvider).playWrong();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tente novamente!"),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void _showSuccessDialog(BuildContext context, WidgetRef ref) {
    showPremiumSuccess(
      context,
      title: "Parabéns! 🌟",
      message: "Você encontrou a letra certa!",
      stars: 10,
      onNext: () {
        ref.read(gameSessionProvider.notifier).state = 
            ref.read(pedagogyRepositoryProvider).generateSession();
      },
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
