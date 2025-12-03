import 'package:datingapp/screens/favourites_match_Screen/fav_match_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class MatchCard extends StatelessWidget {
  final MatchUser user;

  const MatchCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          /// Image
          _buildImage(),

          /// Bottom row with buttons
          Container(
            height: 55,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(22),
              ),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withOpacity(0.75),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
            child: Row(
              children: [
                _actionBtn(
                  icon: Icons.close,
                  color: Colors.white.withOpacity(0.95),
                  onTap: () {},
                ),
                Container(
                  width: 1,
                  height: 26,
                  color: Colors.white.withOpacity(0.27),
                ),
                _actionBtn(
                  icon: Icons.favorite,
                  color: AppColors.primary,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Expanded(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            child: CachedNetworkImage(
              imageUrl: user.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
            left: 12,
            bottom: 12,
            child: Text(
              "${user.name}, ${user.age}",
              style: AppTextStyles.heading(20).copyWith(
                color: Colors.white,
                shadows: [
                  const Shadow(
                    blurRadius: 6,
                    color: Colors.black54,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionBtn({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Center(child: Icon(icon, color: color, size: 26)),
      ),
    );
  }
}
