import 'package:flutter/material.dart';
import '../widgets/conversation_starter_card.dart';
import '../widgets/social_tip_card.dart';
import '../models/conversation_starter.dart';
import '../models/social_tip.dart';
import 'conversation_starters_screen.dart';
import 'social_tips_screen.dart';
import 'interests_matcher_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<ConversationStarter> _featuredStarters = [
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
  ];

  final List<SocialTip> _todaysTips = [
    SocialTip(
      id: '1',
      title: 'Active Listening',
      description: 'Show genuine interest by maintaining eye contact and asking follow-up questions.',
      category: 'Communication',
      icon: Icons.hearing,
    ),
    SocialTip(
      id: '2',
      title: 'Smile More',
      description: 'A genuine smile makes you more approachable and creates positive energy.',
      category: 'Body Language',
      icon: Icons.sentiment_satisfied_alt,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Socialise',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile coming soon!')),
              );
            },
          ),
        ],
      ),
      body: _selectedIndex == 0 ? _buildHomeTab() : _buildExploreTab(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(),
            const SizedBox(height: 24),
            _buildQuickActionsGrid(),
            const SizedBox(height: 24),
            _buildSectionHeader('Today\'s Tips', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SocialTipsScreen(),
                ),
              );
            }),
            const SizedBox(height: 12),
            ...(_todaysTips.map((tip) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: SocialTipCard(tip: tip),
                ))),
            const SizedBox(height: 24),
            _buildSectionHeader('Featured Starters', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConversationStartersScreen(),
                ),
              );
            }),
            const SizedBox(height: 12),
            ...(_featuredStarters.map((starter) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ConversationStarterCard(starter: starter),
                ))),
          ],
        ),
      ),
    );
  }

  Widget _buildExploreTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Explore Tools',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildExploreCard(
              'Conversation Starters',
              'Browse hundreds of questions to start conversations',
              Icons.chat_bubble_outline,
              Colors.blue,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConversationStartersScreen(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildExploreCard(
              'Social Tips',
              'Learn practical tips to improve your social skills',
              Icons.lightbulb_outline,
              Colors.orange,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SocialTipsScreen(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildExploreCard(
              'Interests Matcher',
              'Find conversation topics based on common interests',
              Icons.favorite_outline,
              Colors.pink,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InterestsMatcherScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.waving_hand,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Welcome Back!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Ready to make meaningful connections today?',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildQuickActionCard(
          'Random Starter',
          Icons.shuffle,
          Colors.purple,
          () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Random Starter'),
                content: Text(_featuredStarters[0].question),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Starter saved!')),
                      );
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            );
          },
        ),
        _buildQuickActionCard(
          'Daily Challenge',
          Icons.emoji_events,
          Colors.amber,
          () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Row(
                  children: [
                    Icon(Icons.emoji_events, color: Colors.amber[700]),
                    const SizedBox(width: 8),
                    const Text('Daily Challenge'),
                  ],
                ),
                content: const Text(
                  'Start a conversation with someone new today using one of your favorite conversation starters!',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Later'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Accept'),
                  ),
                ],
              ),
            );
          },
        ),
        _buildQuickActionCard(
          'Find Topics',
          Icons.search,
          Colors.green,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InterestsMatcherScreen(),
            ),
          ),
        ),
        _buildQuickActionCard(
          'My Progress',
          Icons.trending_up,
          Colors.blue,
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Progress tracking coming soon!')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: const Text('See All'),
        ),
      ],
    );
  }

  Widget _buildExploreCard(
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right,
                  color: Theme.of(context).colorScheme.outline),
            ],
          ),
        ),
      ),
    );
  }
}
