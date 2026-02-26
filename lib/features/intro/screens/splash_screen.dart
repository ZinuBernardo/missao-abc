import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:missao_abc/features/auth/screens/landing_screen.dart';
import 'package:missao_abc/features/auth/screens/profile_selection_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:missao_abc/features/auth/providers/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 4));
    if (!mounted) return;
    
    // O destino será decidido pelo authState no main.dart, 
    // mas aqui limpamos o Splash da stack.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6C5CE7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              'https://assets4.lottiefiles.com/packages/lf20_jrqz8jnk.json', // Animated rocket/learning
              height: 250,
            ),
            const SizedBox(height: 20),
            const Text(
              "Missão ABC",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
