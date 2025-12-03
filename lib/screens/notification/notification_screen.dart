import 'package:datingapp/screens/home_screen/home_screen_main.dart';
import 'package:flutter/material.dart';
import '../../widgets/primary_button.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  void _onSkip(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onEnableNotifications(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () => _onSkip(context),
                  child: Text('Skip', style: AppTextStyles.footerLink(16)),
                ),
              ),
            ),

            SizedBox(height: size.height * 0.02),

            // Illustration
            SizedBox(
              height: size.height * 0.35,
              child: Center(
                child: Image.asset(
                  'assets/images/chat.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            SizedBox(height: size.height * 0.05),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Enable notification's",
                textAlign: TextAlign.center,
                style: AppTextStyles.heading(24),
              ),
            ),

            const SizedBox(height: 14),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Text(
                "Get push-notification when you get the match\nor receive a message.",
                textAlign: TextAlign.center,
                style: AppTextStyles.description(14),
              ),
            ),

            const Spacer(),

            // Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              child: PrimaryButton(
                label: "I want to be notified",
                onPressed: () => _onEnableNotifications(context),
                height: 64,
                borderRadius: 24,
                labelSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
