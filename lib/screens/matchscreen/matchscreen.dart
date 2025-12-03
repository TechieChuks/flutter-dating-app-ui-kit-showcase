import 'package:cached_network_image/cached_network_image.dart';
import 'package:datingapp/theme/app_colors.dart';
import 'package:datingapp/theme/app_text_styles.dart';
import 'package:datingapp/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class MatchScreen extends StatelessWidget {
  final String matchedUserName;
  final String userImage;
  final String matchedImage;

  const MatchScreen({
    super.key,
    this.matchedUserName = "Sophie",
    this.userImage =
        "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
    this.matchedImage =
        "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d",
  });

  bool _isNetwork(String path) => path.startsWith('http');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),

            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 40,
                      left: 210,
                      child: _buildTiltedImage(userImage, -6),
                    ),

                    Positioned(
                      top: 200,
                      left: 50,
                      child: _buildTiltedMatchedImage(matchedImage, 8),
                    ),
                    Positioned(
                      top: 520,
                      left: 50,
                      child: _heartBadge(size: 62),
                    ),
                    Positioned(top: 10, child: _heartBadge(size: 62)),
                  ],
                ),
              ),
            ),

            Text(
              "It’s a match, $matchedUserName!",
              textAlign: TextAlign.center,
              style: AppTextStyles.heading(
                35,
              ).copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "Start a conversation now with each other",
                style: AppTextStyles.subtitle.copyWith(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 120),

            SizedBox(
              width: 295,
              height: 56,
              child: PrimaryButton(label: "Say hello", onPressed: () {}),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: 295,
              height: 56,
              child: PrimaryButton(
                label: "Keep swiping",
                variant: PrimaryButtonVariant.outlined,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _buildTiltedMatchedImage(String image, double angle) {
    return Transform.rotate(
      angle: angle * (3.14159 / -180),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Container(
          width: 230,
          height: 350,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 18,
                color: Colors.black.withValues(alpha: 0.10),
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: _isNetwork(image)
              ? CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 1.2),
                  ),
                  errorWidget: (_, __, ___) => _fallbackAvatar(),
                )
              : Image.asset(image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildTiltedImage(String image, double angle) {
    return Transform.rotate(
      angle: angle * (3.14159 / -180),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Container(
          width: 230,
          height: 350,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 18,
                color: Colors.black.withValues(alpha: 0.10),
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: _isNetwork(image)
              ? CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 1.2),
                  ),
                  errorWidget: (_, __, ___) => _fallbackAvatar(),
                )
              : Image.asset(image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _fallbackAvatar() {
    return Container(
      color: Colors.grey[200],
      alignment: Alignment.center,
      child: const Icon(Icons.person, size: 80, color: Colors.grey),
    );
  }

  Widget _heartBadge({required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(Icons.favorite, color: AppColors.primary, size: size * 0.55),
    );
  }
}
