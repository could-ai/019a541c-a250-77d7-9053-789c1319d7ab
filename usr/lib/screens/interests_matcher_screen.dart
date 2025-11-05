import 'package:flutter/material.dart';
import '../models/interest.dart';

class InterestsMatcherScreen extends StatefulWidget {
  const InterestsMatcherScreen({super.key});

  @override
  State<InterestsMatcherScreen> createState() => _InterestsMatcherScreenState();
}

class _InterestsMatcherScreenState extends State<InterestsMatcherScreen> {
  final List<Interest> _availableInterests = [
    Interest(id: '1', name: 'Sports', icon: Icons.sports_soccer),
    Interest(id: '2', name: 'Music', icon: Icons.music_note),
    Interest(id: '3', name: 'Movies', icon: Icons.movie),
    Interest(id: '4', name: 'Travel', icon: Icons.flight),
    Interest(id: '5', name: 'Cooking', icon: Icons.restaurant),
    Interest(id: '6', name: 'Technology', icon: Icons.computer),
    Interest(id: '7', name: 'Art', icon: Icons.palette),
    Interest(id: '8', name: 'Reading', icon: Icons.book),
    Interest(id: '9', name: 'Fitness', icon: Icons.fitness_center),
    Interest(id: '10', name: 'Gaming', icon: Icons.videogame_asset),
    Interest(id: '11', name: 'Photography', icon: Icons.camera_alt),
    Interest(id: '12', name: 'Nature', icon: Icons.forest),
  ];

  final Set<String> _selectedInterests = {};
  List<String> _suggestedTopics = [];

  void _toggleInterest(String interestId) {
    setState(() {
      if (_selectedInterests.contains(interestId)) {
        _selectedInterests.remove(interestId);
      } else {
        _selectedInterests.add(interestId);
      }
      _generateSuggestedTopics();
    });
  }

  void _generateSuggestedTopics() {
    final selectedNames = _availableInterests
        .where((i) => _selectedInterests.contains(i.id))
        .map((i) => i.name)
        .toList();

    if (selectedNames.isEmpty) {
      _suggestedTopics = [];
      return;
    }

    final Map<String, List<String>> topicsByInterest = {
      'Sports': [
        'What\'s your favorite sport to watch or play?',
        'Do you have a favorite sports team?',
        'Have you ever been to a major sporting event?',
      ],
      'Music': [
        'What kind of music do you enjoy?',
        'Have you been to any concerts recently?',
        'Do you play any musical instruments?',
      ],
      'Movies': [
        'What\'s the best movie you\'ve seen recently?',
        'Do you have a favorite director or actor?',
        'What genre of movies do you prefer?',
      ],
      'Travel': [
        'What\'s your favorite place you\'ve traveled to?',
        'Where would you love to visit next?',
        'Do you prefer beach vacations or city exploration?',
      ],
      'Cooking': [
        'What\'s your signature dish?',
        'Do you prefer cooking or baking?',
        'Have you tried any new recipes lately?',
      ],
      'Technology': [
        'What\'s your favorite tech gadget?',
        'Are you excited about any upcoming technology?',
        'How do you stay updated with tech trends?',
      ],
      'Art': [
        'What\'s your favorite art style or period?',
        'Do you create art yourself?',
        'Have you visited any art museums recently?',
      ],
      'Reading': [
        'What\'s the last book you read?',
        'Do you have a favorite author or genre?',
        'Do you prefer physical books or e-readers?',
      ],
      'Fitness': [
        'What\'s your favorite way to stay active?',
        'Do you have any fitness goals?',
        'Do you prefer working out alone or with others?',
      ],
      'Gaming': [
        'What games are you playing right now?',
        'Do you prefer single-player or multiplayer games?',
        'What\'s your all-time favorite game?',
      ],
      'Photography': [
        'What do you like to photograph most?',
        'Do you prefer film or digital photography?',
        'What\'s the best photo you\'ve ever taken?',
      ],
      'Nature': [
        'Do you enjoy hiking or camping?',
        'What\'s your favorite outdoor activity?',
        'Have you seen any amazing natural landmarks?',
      ],
    };

    _suggestedTopics = [];
    for (final name in selectedNames) {
      if (topicsByInterest.containsKey(name)) {
        _suggestedTopics.addAll(topicsByInterest[name]!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interests Matcher'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Select your interests to get conversation topic suggestions',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Your Interests',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableInterests.map((interest) {
                  final isSelected = _selectedInterests.contains(interest.id);
                  return FilterChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(interest.icon, size: 16),
                        const SizedBox(width: 6),
                        Text(interest.name),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (_) => _toggleInterest(interest.id),
                  );
                }).toList(),
              ),
              if (_suggestedTopics.isNotEmpty) ...[
                const SizedBox(height: 32),
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Suggested Topics',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ..._suggestedTopics.map((topic) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Icon(
                          Icons.chat_bubble_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(topic),
                        trailing: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Topic copied to clipboard!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ),
                    )),
              ],
              if (_selectedInterests.isEmpty) ...[
                const SizedBox(height: 32),
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.touch_app,
                        size: 64,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Select interests above to see suggestions',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
