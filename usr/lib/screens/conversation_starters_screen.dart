import 'package:flutter/material.dart';
import '../models/conversation_starter.dart';
import '../widgets/conversation_starter_card.dart';

class ConversationStartersScreen extends StatefulWidget {
  const ConversationStartersScreen({super.key});

  @override
  State<ConversationStartersScreen> createState() =>
      _ConversationStartersScreenState();
}

class _ConversationStartersScreenState
    extends State<ConversationStartersScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Icebreaker',
    'Fun',
    'Deep',
    'Work',
    'Travel',
    'Hobbies'
  ];

  final List<ConversationStarter> _allStarters = [
    ConversationStarter(
      id: '1',
      category: 'Icebreaker',
      question: 'If you could have dinner with any person, living or dead, who would it be?',
      difficulty: 'Easy',
    ),
    ConversationStarter(
      id: '2',
      category: 'Fun',
      question: 'What\'s the most interesting place you\'ve ever visited?',
      difficulty: 'Easy',
    ),
    ConversationStarter(
      id: '3',
      category: 'Deep',
      question: 'What achievement are you most proud of?',
      difficulty: 'Medium',
    ),
    ConversationStarter(
      id: '4',
      category: 'Work',
      question: 'What\'s the most valuable lesson you\'ve learned in your career?',
      difficulty: 'Medium',
    ),
    ConversationStarter(
      id: '5',
      category: 'Travel',
      question: 'If you could live anywhere in the world for a year, where would it be?',
      difficulty: 'Easy',
    ),
    ConversationStarter(
      id: '6',
      category: 'Hobbies',
      question: 'What\'s a hobby you\'ve always wanted to try but haven\'t yet?',
      difficulty: 'Easy',
    ),
    ConversationStarter(
      id: '7',
      category: 'Deep',
      question: 'What does success mean to you personally?',
      difficulty: 'Hard',
    ),
    ConversationStarter(
      id: '8',
      category: 'Fun',
      question: 'If you could have any superpower, what would it be and why?',
      difficulty: 'Easy',
    ),
    ConversationStarter(
      id: '9',
      category: 'Icebreaker',
      question: 'What\'s something that always makes you laugh?',
      difficulty: 'Easy',
    ),
    ConversationStarter(
      id: '10',
      category: 'Work',
      question: 'What motivates you to do your best work?',
      difficulty: 'Medium',
    ),
  ];

  List<ConversationStarter> get _filteredStarters {
    if (_selectedCategory == 'All') {
      return _allStarters;
    }
    return _allStarters
        .where((starter) => starter.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversation Starters'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            tooltip: 'Random',
            onPressed: () {
              final random = (_allStarters..shuffle()).first;
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Random Starter'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Chip(
                        label: Text(random.category),
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ),
                      const SizedBox(height: 12),
                      Text(random.question),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Starter saved to favorites!')),
                        );
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(
            child: _filteredStarters.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No starters in this category',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredStarters.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ConversationStarterCard(
                          starter: _filteredStarters[index],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),
          );
        },
      ),
    );
  }
}