import 'package:flutter/material.dart';
import '../models/social_tip.dart';
import '../widgets/social_tip_card.dart';

class SocialTipsScreen extends StatefulWidget {
  const SocialTipsScreen({super.key});

  @override
  State<SocialTipsScreen> createState() => _SocialTipsScreenState();
}

class _SocialTipsScreenState extends State<SocialTipsScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Communication',
    'Body Language',
    'Confidence',
    'Empathy',
  ];

  final List<SocialTip> _allTips = [
    SocialTip(
      id: '1',
      title: 'Active Listening',
      description:
          'Show genuine interest by maintaining eye contact and asking follow-up questions. People appreciate when you truly listen to what they say.',
      category: 'Communication',
      icon: Icons.hearing,
    ),
    SocialTip(
      id: '2',
      title: 'Smile More',
      description:
          'A genuine smile makes you more approachable and creates positive energy. It\'s one of the simplest ways to make others feel comfortable.',
      category: 'Body Language',
      icon: Icons.sentiment_satisfied_alt,
    ),
    SocialTip(
      id: '3',
      title: 'Remember Names',
      description:
          'Make an effort to remember and use people\'s names. It shows respect and makes conversations more personal and meaningful.',
      category: 'Communication',
      icon: Icons.person_outline,
    ),
    SocialTip(
      id: '4',
      title: 'Open Body Language',
      description:
          'Keep your arms uncrossed, face people when talking, and lean in slightly. This makes you appear more open and engaged.',
      category: 'Body Language',
      icon: Icons.accessibility_new,
    ),
    SocialTip(
      id: '5',
      title: 'Practice Empathy',
      description:
          'Try to understand others\' perspectives and feelings. Showing empathy builds deeper connections and trust.',
      category: 'Empathy',
      icon: Icons.favorite_outline,
    ),
    SocialTip(
      id: '6',
      title: 'Be Authentic',
      description:
          'Don\'t try to be someone you\'re not. Authenticity is attractive and helps you connect with like-minded people.',
      category: 'Confidence',
      icon: Icons.verified_outlined,
    ),
    SocialTip(
      id: '7',
      title: 'Ask Open-Ended Questions',
      description:
          'Instead of yes/no questions, ask questions that encourage detailed responses. This keeps conversations flowing naturally.',
      category: 'Communication',
      icon: Icons.question_answer,
    ),
    SocialTip(
      id: '8',
      title: 'Mirror Subtly',
      description:
          'Subtly matching someone\'s energy and body language can create rapport and make them feel more comfortable with you.',
      category: 'Body Language',
      icon: Icons.people_outline,
    ),
    SocialTip(
      id: '9',
      title: 'Give Genuine Compliments',
      description:
          'Notice and appreciate specific things about people. Genuine compliments boost confidence and strengthen relationships.',
      category: 'Empathy',
      icon: Icons.thumb_up_outlined,
    ),
    SocialTip(
      id: '10',
      title: 'Practice Self-Compassion',
      description:
          'Be kind to yourself when social situations don\'t go perfectly. Everyone makes mistakes, and that\'s okay.',
      category: 'Confidence',
      icon: Icons.self_improvement,
    ),
  ];

  List<SocialTip> get _filteredTips {
    if (_selectedCategory == 'All') {
      return _allTips;
    }
    return _allTips
        .where((tip) => tip.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Tips'),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(
            child: _filteredTips.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          size: 64,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No tips in this category',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredTips.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: SocialTipCard(tip: _filteredTips[index]),
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