import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/story_model.dart';
import '../repositories/story_repository.dart';

final storyRepositoryProvider = Provider((ref) => StoryRepository());

class PhaseFourScreen extends ConsumerStatefulWidget {
  final String storyId;
  const PhaseFourScreen({super.key, required this.storyId});

  @override
  ConsumerState<PhaseFourScreen> createState() => _PhaseFourScreenState();
}

class _PhaseFourScreenState extends ConsumerState<PhaseFourScreen> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final story = ref.read(storyRepositoryProvider).getStoryById(widget.storyId);
    final currentPage = story.pages[_currentPageIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            itemCount: story.pages.length,
            itemBuilder: (context, index) {
              return _buildPage(story.pages[index]);
            },
          ),
          _buildTopNav(context, story),
          _buildBottomNav(story),
        ],
      ),
    );
  }

  Widget _buildTopNav(BuildContext context, StoryModel story) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.close, color: Colors.black54, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
            Text(
              story.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(width: 48), // Spacer
          ],
        ),
      ),
    );
  }

  Widget _buildPage(StoryPage page) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(20, 100, 20, 20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(Icons.auto_stories, size: 120, color: Colors.blueAccent), // Placeholder Image
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSentence(page.text, page.highlightWords),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {}, // Play audio
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(color: Color(0xFF6C5CE7), shape: BoxScheme.circle),
                    child: const Icon(Icons.volume_up, color: Colors.white, size: 40),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSentence(String text, List<String> highlights) {
    final words = text.split(' ');
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      children: words.map((word) {
        final isHighlighted = highlights.any((h) => word.toLowerCase().contains(h.toLowerCase()));
        return Text(
          word,
          style: TextStyle(
            fontSize: 32,
            fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w400,
            color: isHighlighted ? const Color(0xFF6C5CE7) : Colors.black87,
            letterSpacing: 1.2,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomNav(StoryModel story) {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (_currentPageIndex > 0)
            _buildNavButton(Icons.arrow_back, () {
              _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            }),
          Text(
            "${_currentPageIndex + 1} / ${story.pages.length}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          if (_currentPageIndex < story.pages.length - 1)
            _buildNavButton(Icons.arrow_forward, () {
              _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            })
          else
            _buildNavButton(Icons.check, () => Navigator.pop(context), color: Colors.green),
        ],
      ),
    );
  }

  Widget _buildNavButton(IconData icon, VoidCallback onTap, {Color color = const Color(0xFF6C5CE7)}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }
}
