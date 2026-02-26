import '../models/story_model.dart';

class StoryRepository {
  final List<StoryModel> _stories = [
    StoryModel(
      id: '1',
      title: 'O Gato e a Bola',
      coverImage: 'assets/images/stories/cat_ball_cover.png',
      pages: [
        StoryPage(
          text: 'O Gato vê a bola.',
          imageAsset: 'assets/images/stories/page1.png',
          audioAsset: 'audio/stories/story1_p1.mp3',
          highlightWords: ['Gato', 'bola'],
        ),
        StoryPage(
          text: 'A bola é azul.',
          imageAsset: 'assets/images/stories/page2.png',
          audioAsset: 'audio/stories/story1_p2.mp3',
          highlightWords: ['bola', 'azul'],
        ),
        StoryPage(
          text: 'O Gato pula na bola!',
          imageAsset: 'assets/images/stories/page3.png',
          audioAsset: 'audio/stories/story1_p3.mp3',
          highlightWords: ['Gato', 'pula'],
        ),
      ],
    ),
    StoryModel(
      id: '2',
      title: 'O Sol e a Lua',
      coverImage: 'assets/images/stories/sun_moon_cover.png',
      pages: [
        StoryPage(
          text: 'O Sol brilha de dia.',
          imageAsset: 'assets/images/stories/sun.png',
          audioAsset: 'audio/stories/sun.mp3',
          highlightWords: ['Sol', 'dia'],
        ),
        StoryPage(
          text: 'A Lua brilha de noite.',
          imageAsset: 'assets/images/stories/moon.png',
          audioAsset: 'audio/stories/moon.mp3',
          highlightWords: ['Lua', 'noite'],
        ),
      ],
    ),
  ];

  List<StoryModel> getAllStories() => _stories;
  StoryModel getStoryById(String id) => _stories.firstWhere((s) => s.id == id);
}
