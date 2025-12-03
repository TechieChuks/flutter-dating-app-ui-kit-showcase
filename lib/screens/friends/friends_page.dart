import 'package:datingapp/screens/notification/notification_screen.dart';
import 'package:flutter/material.dart';
import '../../widgets/primary_button.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  // If you use this screen as Stateful later (permission state), convert to StatefulWidget.
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final width = media.width;
    final height = media.height;
    final scale = (width / 390).clamp(0.85, 1.15);

    // image height - clamp so it won't be huge on tablets
    final heroHeight = (height * 0.36).clamp(160.0, 380.0);

    const horizontalPadding = 28.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              // ensure it takes at least viewport height so CTA positions near bottom visually
              minHeight: height - MediaQuery.of(context).padding.vertical,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // top spacing
                  SizedBox(height: 16 * scale),

                  // Skip aligned to right
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        // Skip action - navigate or dismiss
                        Navigator.maybePop(context);
                      },
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        'Skip',
                        style: AppTextStyles.footerLink(16 * scale),
                      ),
                    ),
                  ),

                  // Hero illustration center
                  SizedBox(height: 8 * scale),
                  Center(
                    child: Container(
                      height: heroHeight,
                      width: heroHeight, // keep square for circular composition
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // subtle shadow like sample
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.08),
                            blurRadius: 28,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Semantics(
                        image: true,
                        label: 'Friends illustration',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            'assets/images/people.png',
                            fit: BoxFit.contain,
                            width: heroHeight,
                            height: heroHeight,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Spacer between image and text
                  SizedBox(height: 34 * scale),

                  // Title
                  Text(
                    "Search friend's",
                    style: AppTextStyles.heading(32 * scale),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 12 * scale),

                  // Subtitle
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8 * scale),
                    child: Text(
                      "You can find friends from your contact lists to connected",
                      style: AppTextStyles.description(16 * scale),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Fill remaining vertical space so CTA sits near bottom
                  const Spacer(),

                  // CTA (PrimaryButton)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 20 + MediaQuery.of(context).viewPadding.bottom,
                      top: 16 * scale,
                    ),
                    child: Semantics(
                      button: true,
                      label: 'Access to a contact list',
                      child: PrimaryButton(
                        label: 'Access to a contact list',
                        onPressed: () {
                          // Recommended flow:
                          // 1) show rationale / explain
                          // 2) request permission via permission_handler plugin
                          // 3) if allowed, fetch contacts or navigate onward

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NotificationScreen(),
                            ),
                          );
                        },
                        variant: PrimaryButtonVariant.filled,
                        height: 64 * scale,
                        borderRadius: 28,
                        labelSize: 18 * scale,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
