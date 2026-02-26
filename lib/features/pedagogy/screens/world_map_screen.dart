import 'package:flutter/material.dart';
import 'package:missao_abc/features/pedagogy/screens/phase_one_screen.dart';
import 'package:missao_abc/features/pedagogy/screens/phase_two_screen.dart';
import 'package:missao_abc/features/pedagogy/screens/phase_three_screen.dart';
import 'package:missao_abc/features/pedagogy/screens/phase_four_screen.dart';

class WorldMapScreen extends StatelessWidget {
  const WorldMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://img.freepik.com/free-vector/cartoon-game-map-island-concept_52683-45543.jpg'), // Placeholder de mapa
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            _buildWorldNode(
              context,
              top: 200,
              left: 50,
              title: "Mundo 1: Letras",
              icon: Icons.abc,
              color: Colors.orange,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const PhaseOneScreen())),
              isUnlocked: true,
            ),
            _buildWorldNode(
              context,
              top: 400,
              right: 60,
              title: "Mundo 2: Sílabas",
              icon: Icons.grid_view,
              color: Colors.purple,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const PhaseTwoScreen())),
              isUnlocked: true,
            ),
            _buildWorldNode(
              context,
              bottom: 150,
              left: 100,
              title: "Mundo 3: Palavras",
              icon: Icons.menu_book,
              color: Colors.blue,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const PhaseThreeScreen())),
              isUnlocked: true,
            ),
            _buildWorldNode(
              context,
              top: 50,
              right: 60,
              title: "Mundo 4: Histórias",
              icon: Icons.auto_stories,
              color: Colors.green,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const PhaseFourScreen(storyId: '1'))),
              isUnlocked: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorldNode(BuildContext context, {
    double? top, double? bottom, double? left, double? right,
    required String title, required IconData icon, required Color color,
    required VoidCallback onTap, required bool isUnlocked
  }) {
    return Positioned(
      top: top, bottom: bottom, left: left, right: right,
      child: Column(
        children: [
          GestureDetector(
            onTap: isUnlocked ? onTap : null,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: isUnlocked ? color : Colors.grey[400],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
              child: Icon(icon, color: Colors.white, size: 40),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
