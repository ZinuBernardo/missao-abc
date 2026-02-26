import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../providers/auth_provider.dart';

class LandingScreen extends ConsumerWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6C5CE7), Color(0xFFa29bfe)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 60),
              _buildLogo(),
              const Spacer(),
              Lottie.network(
                'https://assets5.lottiefiles.com/packages/lf20_m6cuL6.json', // Astronaut
                height: 320,
              ),
              const Spacer(),
              _buildActionButtons(context, ref),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return const Column(
      children: [
        Text(
          "Missão ABC",
          style: TextStyle(
            fontSize: 54,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
            shadows: [Shadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],
          ),
        ),
        SizedBox(height: 5),
        Text(
          "A aventura da alfabetização",
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6C5CE7).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD700), // Gold
                foregroundColor: const Color(0xFF6C5CE7),
                minimumSize: const Size(double.infinity, 65),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 0,
              ),
              onPressed: () => ref.read(authNotifierProvider.notifier).signInAnonymously(),
              child: const Text(
                "DECOLAR!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 25),
          GestureDetector(
            onTap: () {},
            child: const Text(
              "Área Reservada aos Pais",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
