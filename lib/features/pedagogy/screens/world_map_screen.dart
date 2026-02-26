import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:missao_abc/core/services/audio_service.dart';
import 'package:missao_abc/features/auth/providers/profile_provider.dart';
import 'package:missao_abc/features/pedagogy/screens/phase_one_screen.dart';
import 'package:missao_abc/features/pedagogy/screens/phase_two_screen.dart';
import 'package:missao_abc/features/pedagogy/screens/phase_three_screen.dart';
import 'package:missao_abc/features/pedagogy/screens/phase_four_screen.dart';
import 'package:missao_abc/features/pedagogy/screens/tracing_screen.dart';

class WorldMapScreen extends ConsumerWidget {
  const WorldMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final int stars = profile?.totalStars ?? 0;
    final int level = (stars / 100).floor() + 1;
    final double progress = (stars % 100) / 100;

    return Scaffold(
      body: Stack(
        children: [
          // Fundo com Gradiente Suave
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE0F7FA), Color(0xFFF1F8E9)],
              ),
            ),
          ),
          
          // Mapa com Rolagem Vertical
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 150),
              width: double.infinity,
              child: Column(
                children: [
                   _buildWorldNode(
                    context,
                    title: "Escrita de Letras",
                    subtitle: "Mundo 5",
                    icon: Icons.edit,
                    color: const Color(0xFFFF5252),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const TracingScreen(char: 'A'))),
                    isUnlocked: true,
                    alignment: Alignment.centerRight,
                  ),
                  _buildPathConnector(),
                  _buildWorldNode(
                    context,
                    title: "Hora da História",
                    subtitle: "Mundo 4",
                    icon: Icons.auto_stories,
                    color: const Color(0xFF4CAF50),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const PhaseFourScreen(storyId: '1'))),
                    isUnlocked: true,
                    alignment: Alignment.centerLeft,
                  ),
                  _buildPathConnector(),
                  _buildWorldNode(
                    context,
                    title: "Leitura Divertida",
                    subtitle: "Mundo 3",
                    icon: Icons.menu_book,
                    color: const Color(0xFF2196F3),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const PhaseThreeScreen())),
                    isUnlocked: true,
                    alignment: Alignment.centerRight,
                  ),
                  _buildPathConnector(),
                  _buildWorldNode(
                    context,
                    title: "Aventura das Sílabas",
                    subtitle: "Mundo 2",
                    icon: Icons.grid_view,
                    color: const Color(0xFF9C27B0),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const PhaseTwoScreen())),
                    isUnlocked: true,
                    alignment: Alignment.centerLeft,
                  ),
                  _buildPathConnector(),
                  _buildWorldNode(
                    context,
                    title: "Jardim das Letras",
                    subtitle: "Mundo 1",
                    icon: Icons.abc,
                    color: const Color(0xFFFF9800),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const PhaseOneScreen())),
                    isUnlocked: true,
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
          ),
          _buildProgressHeader(level, stars, progress),
        ],
      ),
    );
  }

  Widget _buildPathConnector() {
    return Container(
      height: 60,
      width: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildProgressHeader(int level, int stars, double progress) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.stars, color: Colors.orange, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        "Nível $level",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                  ),
                  child: Row(
                    children: [
                      Text(
                        "$stars",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.star, color: Colors.orange, size: 20),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 12,
                backgroundColor: Colors.white.withOpacity(0.5),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorldNode(BuildContext context, {
    required String title, required String subtitle, required IconData icon, 
    required Color color, required VoidCallback onTap, required bool isUnlocked,
    required Alignment alignment
  }) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            GestureDetector(
              onTap: isUnlocked ? () {
                ref.read(audioServiceProvider).playPop();
                onTap();
              } : null,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 6),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 45),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
              ),
              child: Column(
                children: [
                  Text(subtitle, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
                  Text(title, style: const TextStyle(color: Color(0xFF2D3436), fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
