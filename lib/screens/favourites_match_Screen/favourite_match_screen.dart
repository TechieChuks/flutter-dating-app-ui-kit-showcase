import 'package:datingapp/screens/favourites_match_Screen/fav_match_screen_model.dart';
import 'package:datingapp/screens/favourites_match_Screen/match_card.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class FavMatchesScreen extends StatelessWidget {
  const FavMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MatchUser> today = [
      MatchUser(
        "Leilani",
        19,
        "https://plus.unsplash.com/premium_photo-1688676796006-bbd1599bbfb6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Z2lybHN8ZW58MHx8MHx8fDA%3D",
      ),
      MatchUser(
        "Annabelle",
        20,
        "https://images.unsplash.com/photo-1503104834685-7205e8607eb9?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Z2lybHN8ZW58MHx8MHx8fDA%3D",
      ),
      MatchUser(
        "Reagan",
        24,
        "https://images.unsplash.com/photo-1516195851888-6f1a981a862e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Z2lybHN8ZW58MHx8MHx8fDA%3D",
      ),
      MatchUser(
        "Hadley",
        25,
        "https://images.unsplash.com/photo-1464863979621-258859e62245?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmxzfGVufDB8fDB8fHww",
      ),
    ];

    final List<MatchUser> yesterday = [
      MatchUser(
        "Sasha",
        22,
        "https://plus.unsplash.com/premium_photo-1669138512601-e3f00b684edc?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fGdpcmxzfGVufDB8fDB8fHww",
      ),
      MatchUser(
        "Nora",
        21,
        "https://images.unsplash.com/photo-1601288496920-b6154fe3626a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGdpcmxzfGVufDB8fDB8fHww",
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),

              /// Top title row  —————————————
              _header(context),

              const SizedBox(height: 18),

              /// Subtitle —————————————
              Text(
                "This is a list of people who have liked you and your matches.",
                style: AppTextStyles.subtitle.copyWith(fontSize: 22),
              ),

              const SizedBox(height: 26),

              /// TODAY SECTION —————————————
              _sectionHeader("Today"),
              const SizedBox(height: 14),
              _gridMatches(today),

              const SizedBox(height: 30),

              /// YESTERDAY SECTION —————————————
              _sectionHeader("Yesterday"),
              const SizedBox(height: 14),
              _gridMatches(yesterday),

              const SizedBox(height: 38),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        Text("Matches", style: AppTextStyles.heading(45)),
        const Spacer(),
        _filterButton(),
      ],
    );
  }

  Widget _filterButton() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(Icons.tune_rounded, size: 26, color: AppColors.primary),
    );
  }

  Widget _sectionHeader(String title) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: AppColors.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            style: AppTextStyles.subtitle.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: AppColors.border)),
      ],
    );
  }

  Widget _gridMatches(List<MatchUser> list) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 16,
      childAspectRatio: 0.68,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: list.map((e) => MatchCard(user: e)).toList(),
    );
  }
}
