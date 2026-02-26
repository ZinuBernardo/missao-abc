import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          Container(
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
            _buildWorldNode(
              context,
              bottom: 50,
              right: 50,
              title: "Mundo 5: Escrita",
              icon: Icons.edit,
              color: Colors.redAccent,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const TracingScreen(char: 'A'))),
              isUnlocked: true,
            ),
          ],
        ),
      ),
      _buildProgressHeader(level, stars, progress),
    ],
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
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
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
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
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
