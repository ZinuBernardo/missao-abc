import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../models/user_profile.dart';
import '../providers/profile_provider.dart';

import '../../../core/navigation/main_navigation_screen.dart';

class ProfileSelectionScreen extends ConsumerWidget {
  const ProfileSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(availableProfilesProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              "Quem vai jogar agora?",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF2D3436)),
            ),
            const SizedBox(height: 10),
            const Text("Escolha seu perfil para continuar", style: TextStyle(color: Colors.grey)),
            const Spacer(),
            profiles.when(
              data: (profileList) => SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  itemCount: profileList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == profileList.length) return _buildAddProfile(context, ref);
                    return _buildProfileCard(context, ref, profileList[index]);
                  },
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text("Erro ao carregar perfis: $err")),
            ),
            const Spacer(),
            Lottie.network(
              'https://assets9.lottiefiles.com/packages/lf20_myejioos.json',
              height: 200,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, WidgetRef ref, UserProfile profile) {
    return GestureDetector(
      onTap: () {
        ref.read(profileProvider.notifier).selectProfile(profile);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF6C5CE7), width: 4),
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xFFF0EDFF),
                backgroundImage: profile.avatarAsset.startsWith('assets') 
                  ? AssetImage(profile.avatarAsset) 
                  : null as ImageProvider?,
                child: profile.avatarAsset.startsWith('assets') 
                  ? null 
                  : const Icon(Icons.person, size: 70, color: Color(0xFF6C5CE7)),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              profile.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text("${profile.totalStars} ⭐", style: const TextStyle(color: Colors.orange)),
          ],
        ),
      ),
    );
  }

  Widget _buildAddProfile(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _showAddProfileDialog(context, ref),
      child: Column(
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, size: 50, color: Colors.grey),
          ),
          const SizedBox(height: 15),
          const Text("Novo", style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }

  void _showAddProfileDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    String selectedAvatar = 'assets/images/avatars/boy.png';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text("Novo Aventureiro"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Nome da criança",
                  hintText: "Ex: Davi, Alice...",
                ),
              ),
              const SizedBox(height: 20),
              const Text("Escolha um avatar:", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _avatarOption(
                    'assets/images/avatars/boy.png',
                    selectedAvatar == 'assets/images/avatars/boy.png',
                    () => setDialogState(() => selectedAvatar = 'assets/images/avatars/boy.png'),
                  ),
                  _avatarOption(
                    'assets/images/avatars/girl.png',
                    selectedAvatar == 'assets/images/avatars/girl.png',
                    () => setDialogState(() => selectedAvatar = 'assets/images/avatars/girl.png'),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CANCELAR"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty) {
                  await ref.read(profileProvider.notifier).createProfile(
                    nameController.text,
                    selectedAvatar,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text("CRIAR"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _avatarOption(String asset, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFF6C5CE7) : Colors.transparent,
            width: 3,
          ),
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[200],
          backgroundImage: AssetImage(asset),
        ),
      ),
    );
  }
}
