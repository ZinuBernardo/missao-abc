import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:lottie/lottie.dart';

class PremiumSuccessDialog extends StatefulWidget {
  final String title;
  final String message;
  final int stars;
  final VoidCallback onNext;

  const PremiumSuccessDialog({
    super.key,
    required this.title,
    required this.message,
    required this.stars,
    required this.onNext,
  });

  @override
  State<PremiumSuccessDialog> createState() => _PremiumSuccessDialogState();
}

class _PremiumSuccessDialogState extends State<PremiumSuccessDialog> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 3));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2D3436)),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 30),
                      const SizedBox(width: 10),
                      Text(
                        "+${widget.stars} Estrelas!",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C5CE7),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onNext();
                  },
                  child: const Text("CONTINUAR", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Positioned(
            top: -60,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: Lottie.network(
                'https://assets1.lottiefiles.com/packages/lf20_tou99bm8.json', // Party
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controller,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
            ),
          ),
        ],
      ),
    );
  }
}

void showPremiumSuccess(BuildContext context, {
  required String title,
  required String message,
  required int stars,
  required VoidCallback onNext,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => PremiumSuccessDialog(
      title: title,
      message: message,
      stars: stars,
      onNext: onNext,
    ),
  );
}
