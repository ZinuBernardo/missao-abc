import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:missao_abc/features/pedagogy/screens/world_map_screen.dart';
import 'package:missao_abc/features/gamification/screens/sticker_album_screen.dart';
import 'package:missao_abc/features/parents_dashboard/screens/parent_dashboard_screen.dart';
import '../services/audio_service.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  ConsumerState<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const WorldMapScreen(),
    const StickerAlbumScreen(),
    const ParentDashboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            ref.read(audioServiceProvider).playPop();
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_filled),
              label: 'Jogar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.collections_bookmark),
              label: 'Álbum',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.family_restroom),
              label: 'Pais',
            ),
          ],
          selectedItemColor: const Color(0xFF6C5CE7),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
