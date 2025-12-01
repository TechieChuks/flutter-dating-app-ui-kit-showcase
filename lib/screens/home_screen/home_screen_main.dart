import 'package:datingapp/screens/home_screen/favourites_screen.dart';
import 'package:datingapp/screens/home_screen/messages_screen.dart';
import 'package:datingapp/screens/home_screen/model/user_card_model.dart';
import 'package:datingapp/screens/home_screen/profile_screen.dart';

import 'package:flutter/material.dart';

import '../../widgets/swipe_card.dart';
import 'card_stack_controller.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CardStackController controller;
  int _selectedIndex = 0;

  // sample network images (use your own URLs)
  final List<UserCardModel> _initialCards = [
    UserCardModel(
      id: '1',
      name: 'Jessica Parker',
      age: 23,
      job: 'Professional model',
      imageUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=1200&q=80',
    ),
    UserCardModel(
      id: '2',
      name: 'Bred Jackson',
      age: 25,
      job: 'Photograph',
      imageUrl:
          'https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?auto=format&fit=crop&w=1200&q=80',
    ),
    UserCardModel(
      id: '3',
      name: 'Camila Snow',
      age: 23,
      job: 'Marketer',
      imageUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=1200&q=80',
    ),
    UserCardModel(
      id: '4',
      name: 'Daniel Moore',
      age: 28,
      job: 'Designer',
      imageUrl:
          'https://images.unsplash.com/photo-1546868871-7041f2a55e8b?auto=format&fit=crop&w=1200&q=80',
    ),
  ];

  @override
  void initState() {
    super.initState();
    controller = CardStackController(
      context: context,
      cards: List<UserCardModel>.from(_initialCards),
    );
    controller.addListener(() {
      // rebuild when stack changes
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildStack() {
    final stack = controller.stack;
    if (stack.isEmpty) {
      return Center(
        child: Text('No more cards', style: AppTextStyles.heading(20)),
      );
    }

    // display up to 4 stacked; top is last in list? We used add to end so top is index 0
    // We'll render in reverse so bottom card is first painted.
    final List<Widget> cardWidgets = [];
    final displayCount = stack.length < 4 ? stack.length : 4;

    for (int i = displayCount - 1; i >= 0; i--) {
      final model = stack[i];
      final isTop = i == 0;
      cardWidgets.add(
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: SwipeCard(
              card: model,
              isTop: isTop,
              onSwiped: (id, dir) {
                controller.onSwiped(id, dir);
              },
              onCancelTapped: (id) {
                controller.onCancelTapped(id);
              },
            ),
          ),
        ),
      );
    }

    // If more than displayCount, make sure the next ones are behind (simple tile)
    return Stack(children: cardWidgets);
  }

  // bottom nav
  void _onTapNav(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 12),
              Center(
                child: Column(
                  children: [
                    Text('Discover', style: AppTextStyles.title(28)),
                    const SizedBox(height: 4),
                    const Text(
                      'Chicago, Il',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(child: Center(child: buildStack())),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _circleIcon(
                      Icons.clear,
                      color: Colors.orange,
                      onTap: () {
                        // programmatically trigger left move of top card: perform move to bottom
                        if (controller.stack.isNotEmpty) {
                          final id = controller.stack.first.id;
                          controller.onSwiped(id, SwipeDirection.left);
                        }
                      },
                    ),
                    _bigHeart(),
                    _circleIcon(Icons.star, color: Colors.purple, onTap: () {}),
                  ],
                ),
              ),
            ],
          ),
        );
      case 1:
        return const FavoritesScreen();
      case 2:
        return const MessagesScreen();
      case 3:
        return const ProfileDetailScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _circleIcon(
    IconData icon, {
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 86,
        height: 86,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 14)],
        ),
        child: Center(child: Icon(icon, size: 34, color: color)),
      ),
    );
  }

  Widget _bigHeart() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 24),
        ],
      ),
      child: const Center(
        child: Icon(Icons.favorite, color: Colors.white, size: 48),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTapNav,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
