import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:missao_abc/features/auth/screens/profile_selection_screen.dart';

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

class MissaoABCApp extends StatelessWidget {
  const MissaoABCApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      home: const ProfileSelectionScreen(),
    );
  }
}
