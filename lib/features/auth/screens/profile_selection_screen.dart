import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
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
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                itemCount: profiles.length + 1,
                itemBuilder: (context, index) {
                  if (index == profiles.length) return _buildAddProfile(context);
                  return _buildProfileCard(context, ref, profiles[index]);
                },
              ),
            ),
            const Spacer(),
            Lottie.network(
              'https://assets9.lottiefiles.com/packages/lf20_myejioos.json', // Animação de boas-vindas
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
                child: const Icon(Icons.person, size: 70, color: Color(0xFF6C5CE7)),
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

  Widget _buildAddProfile(BuildContext context) {
    return Column(
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
    );
  }
}
