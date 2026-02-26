import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InteractiveHint extends StatelessWidget {
  final String text;
  final Alignment alignment;
  const InteractiveHint({super.key, required this.text, this.alignment = Alignment.center});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Container(color: Colors.black.withOpacity(0.3)),
          Align(
            alignment: alignment,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.network(
                  'https://assets9.lottiefiles.com/packages/lf20_96yv8pba.json', // Animated Hand
                  height: 120,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF6C5CE7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
