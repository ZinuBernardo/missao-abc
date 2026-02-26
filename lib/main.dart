import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:missao_abc/features/auth/screens/profile_selection_screen.dart';
import 'package:missao_abc/features/auth/screens/landing_screen.dart';
import 'package:missao_abc/features/auth/providers/auth_provider.dart';
import 'package:missao_abc/features/intro/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MissaoABCApp(),
    ),
  );
}

class MissaoABCApp extends ConsumerWidget {
  const MissaoABCApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: 'Missão ABC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C5CE7),
          primary: const Color(0xFF6C5CE7),
          secondary: const Color(0xFFFFD700),
        ),
        useMaterial3: true,
      ),
      home: _InitialFlow(authState: authState),
    );
  }
}

class _InitialFlow extends StatefulWidget {
  final AsyncValue authState;
  const _InitialFlow({required this.authState});

  @override
  State<_InitialFlow> createState() => _InitialFlowState();
}

class _InitialFlowState extends State<_InitialFlow> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) setState(() => _showSplash = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) return const SplashScreen();
    
    return widget.authState.when(
      data: (user) => user == null ? const LandingScreen() : const ProfileSelectionScreen(),
      loading: () => const SplashScreen(),
      error: (err, stack) => Scaffold(body: Center(child: Text("Erro: $err"))),
    );
  }
}
