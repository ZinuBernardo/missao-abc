import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/sticker_model.dart';

final stickersProvider = StateProvider<List<StickerModel>>((ref) {
  return [
    StickerModel(id: '1', name: 'Leão Amigável', imageAsset: 'assets/images/stickers/lion.png', isUnlocked: true),
    StickerModel(id: '2', name: 'Zebra Rápida', imageAsset: 'assets/images/stickers/zebra.png', isUnlocked: true),
    StickerModel(id: '3', name: 'Elefante Feliz', imageAsset: 'assets/images/stickers/elephant.png', isUnlocked: false),
    StickerModel(id: '4', name: 'Girafa Alta', imageAsset: 'assets/images/stickers/giraffe.png', isUnlocked: false),
    StickerModel(id: '5', name: 'Macaco Curioso', imageAsset: 'assets/images/stickers/monkey.png', isUnlocked: false),
    StickerModel(id: '6', name: 'Jacaré Dorminhoco', imageAsset: 'assets/images/stickers/alligator.png', isUnlocked: false),
  ];
});

class StickerAlbumScreen extends ConsumerWidget {
  const StickerAlbumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stickers = ref.watch(stickersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Álbum de Adesivos', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFFD700),
        foregroundColor: Colors.black87,
        elevation: 0,
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
          itemCount: stickers.length,
          itemBuilder: (context, index) {
            final sticker = stickers[index];
            return _buildStickerItem(sticker);
          },
        ),
      ),
    );
  }

  Widget _buildStickerItem(StickerModel sticker) {
    return Column(
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
                    opacity: sticker.isUnlocked ? 1.0 : 0.2,
                    child: Icon(
                      sticker.isUnlocked ? Icons.pets : Icons.lock,
                      size: 40,
                      color: sticker.isUnlocked ? Colors.orange : Colors.grey,
                    ),
                  ),
                ),
                if (sticker.isUnlocked)
                  const Positioned(
                    top: 5,
                    right: 5,
                    child: Icon(Icons.stars, color: Colors.blue, size: 20),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          sticker.isUnlocked ? sticker.name : 'Bloqueado',
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
    );
  }
}
