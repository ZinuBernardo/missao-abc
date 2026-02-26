import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../auth/providers/profile_provider.dart';
import '../models/sticker_model.dart';

final allStickersProvider = Provider<List<StickerModel>>((ref) {
  return [
    StickerModel(id: '1', name: 'Leão Amigável', imageAsset: 'assets/images/stickers/lion.png'),
    StickerModel(id: '2', name: 'Zebra Rápida', imageAsset: 'assets/images/stickers/zebra.png'),
    StickerModel(id: '3', name: 'Elefante Feliz', imageAsset: 'assets/images/stickers/elephant.png'),
    StickerModel(id: '4', name: 'Girafa Alta', imageAsset: 'assets/images/stickers/giraffe.png'),
    StickerModel(id: '5', name: 'Macaco Curioso', imageAsset: 'assets/images/stickers/monkey.png'),
    StickerModel(id: '6', name: 'Jacaré Dorminhoco', imageAsset: 'assets/images/stickers/alligator.png'),
  ];
});

final unlockedStickersProvider = StreamProvider<List<String>>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  final profile = ref.watch(profileProvider);
  if (user == null || profile == null) return Stream.value([]);

  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('profiles')
      .doc(profile.id)
      .snapshots()
      .map((snapshot) {
    final data = snapshot.data();
    return List<String>.from(data?['unlockedStickers'] ?? []);
  });
});


class StickerAlbumScreen extends ConsumerWidget {
  const StickerAlbumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allStickers = ref.watch(allStickersProvider);
    final unlockedIds = ref.watch(unlockedStickersProvider).value ?? [];
    final profile = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Álbum de Adesivos', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFFD700),
        foregroundColor: Colors.black87,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Chip(
              backgroundColor: Colors.white,
              avatar: const Icon(Icons.star, color: Colors.orange, size: 18),
              label: Text(
                '${profile?.totalStars ?? 0}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFD700), Color(0xFFFFA000)],
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.8,
          ),
          itemCount: allStickers.length,
          itemBuilder: (context, index) {
            final sticker = allStickers[index];
            final isUnlocked = unlockedIds.contains(sticker.id);
            return _buildStickerItem(context, ref, sticker, isUnlocked);
          },
        ),
      ),
    );
  }

  Widget _buildStickerItem(BuildContext context, WidgetRef ref, StickerModel sticker, bool isUnlocked) {
    const int stickerCost = 50;
    final profile = ref.watch(profileProvider);

    return GestureDetector(
      onTap: isUnlocked 
        ? null 
        : () => _showBuyDialog(context, ref, sticker, stickerCost, profile?.totalStars ?? 0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Opacity(
                      opacity: isUnlocked ? 1.0 : 0.2,
                      child: Icon(
                        isUnlocked ? Icons.pets : Icons.lock,
                        size: 40,
                        color: isUnlocked ? Colors.orange : Colors.grey,
                      ),
                    ),
                  ),
                  if (isUnlocked)
                    const Positioned(
                      top: 5,
                      right: 5,
                      child: Icon(Icons.stars, color: Colors.blue, size: 20),
                    )
                  else
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.star, color: Colors.white, size: 10),
                            Text("50", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isUnlocked ? sticker.name : 'Bloqueado',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _showBuyDialog(BuildContext context, WidgetRef ref, StickerModel sticker, int cost, int userStars) {
    final bool canAfford = userStars >= cost;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(canAfford ? "Desbloquear Figurinha?" : "Estrelas Insuficientes"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.pets, size: 60, color: Colors.orange),
            const SizedBox(height: 15),
            Text(
              canAfford 
                ? "Deseja usar $cost estrelas para ganhar a figurinha ${sticker.name}?"
                : "Você precisa de $cost estrelas, mas tem apenas $userStars. Continue jogando para ganhar mais!",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCELAR")),
          if (canAfford)
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700)),
              onPressed: () {
                ref.read(profileProvider.notifier).unlockSticker(sticker.id, cost);
                Navigator.pop(context);
              },
              child: const Text("COMPRAR", style: TextStyle(color: Colors.black)),
            ),
        ],
      ),
    );
  }
}
