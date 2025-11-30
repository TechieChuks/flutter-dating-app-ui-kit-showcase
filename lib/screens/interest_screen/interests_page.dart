import 'package:datingapp/widgets/interest_chip.dart';
import 'package:flutter/material.dart';

import '../../widgets/primary_button.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_colors.dart';

class InterestsPage extends StatefulWidget {
  const InterestsPage({Key? key}) : super(key: key);

  @override
  State<InterestsPage> createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  // sample data - replace icons or use your own icon set
  final List<_Interest> _allInterests = [
    _Interest('Photography', Icons.camera_alt),
    _Interest('Shopping', Icons.shopping_bag),
    _Interest('Karaoke', Icons.mic),
    _Interest('Yoga', Icons.self_improvement),
    _Interest('Cooking', Icons.set_meal),
    _Interest('Tennis', Icons.sports_tennis),
    _Interest('Run', Icons.directions_run),
    _Interest('Swimming', Icons.pool),
    _Interest('Art', Icons.palette),
    _Interest('Traveling', Icons.travel_explore),
    _Interest('Extreme', Icons.whatshot),
    _Interest('Music', Icons.music_note),
    _Interest('Drink', Icons.wine_bar),
    _Interest('Video games', Icons.videogame_asset),
  ];

  // store labels of selected items
  final Set<String> _selected = {};

  void _toggle(String label) {
    setState(() {
      if (_selected.contains(label))
        _selected.remove(label);
      else
        _selected.add(label);
    });
  }

  void _onContinue() {
    final selectedList = _selected.toList();
    debugPrint('Selected interests: $selectedList');
    Navigator.pushNamed(context, '/friends'); // replace with your route
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = (w / 390).clamp(0.85, 1.15);

    // chip sizes
    final chipHeight = (64.0 * scale).clamp(48.0, 80.0);
    final chipRadius = (18.0 * scale).clamp(12.0, 24.0);
    const double horizontalPadding = 28.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: back + skip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.maybePop(context),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: 52 * scale,
                          height: 52 * scale,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigator.pushReplacementNamed(
                          //   context,
                          //   '/home',
                          // ); // skip action
                        },
                        child: Text(
                          'Skip',
                          style: AppTextStyles.footerLink(16),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Title
                  Text(
                    'Your interests',
                    style: AppTextStyles.heading(34 * scale),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Select a few of your interests and let everyone know what you’re passionate about.",
                    style: AppTextStyles.description.copyWith(
                      fontSize: (14 * scale),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Grid of chips - 2 columns
                  LayoutBuilder(
                    builder: (c, box) {
                      final crossAxisCount = 2;
                      final spacing = 14.0 * scale;
                      // child aspect to make pill-like width
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _allInterests.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: spacing,
                          crossAxisSpacing: spacing,
                          childAspectRatio: 3.2, // wide pill; tweak if needed
                        ),
                        itemBuilder: (context, index) {
                          final item = _allInterests[index];
                          final selected = _selected.contains(item.label);
                          return InterestChip(
                            label: item.label,
                            icon: item.icon,
                            selected: selected,
                            height: chipHeight,
                            borderRadius: chipRadius,
                            onTap: () => _toggle(item.label),
                          );
                        },
                      );
                    },
                  ),

                  SizedBox(height: 40),

                  // Continue button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: PrimaryButton(
                      label: 'Continue',
                      onPressed: _selected.isNotEmpty ? _onContinue : null,
                      variant: PrimaryButtonVariant.filled,
                      loading: false,
                      height: 56 * scale,
                      borderRadius: 22,
                      labelSize: 20 * scale,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Interest {
  final String label;
  final IconData icon;
  _Interest(this.label, this.icon);
}
