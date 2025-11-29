import 'package:datingapp/screens/signup/phone_number_page.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/social_icon_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  // A small helper to compute scale based on a reference width (375)
  double _scale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width / 375).clamp(0.85, 1.25);
  }

  @override
  Widget build(BuildContext context) {
    final scale = _scale(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            // use flexible spacing to keep page balanced on taller screens
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: height),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      children: [
                        const SizedBox(height: 70),

                        // Logo
                        SizedBox(
                          height: 120 * scale,
                          child: Center(
                            child: Image.asset(
                              'assets/images/dating_app_icon.png',
                              fit: BoxFit.contain,
                              height: 120 * scale,
                              semanticLabel: 'App logo',
                            ),
                          ),
                        ),

                        const SizedBox(height: 44),

                        // Title
                        Text(
                          'Sign up to continue',

                          style: AppTextStyles.title(18 * scale),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 28),

                        // Primary button - filled
                        PrimaryButton(
                          label: 'Continue with email',
                          labelSize: 16,
                          onPressed: () {
                            // implement navigation to email flow
                          },
                          variant: PrimaryButtonVariant.filled,
                          height: 64 * scale,
                          borderRadius: 15,
                        ),

                        const SizedBox(height: 18),

                        // Secondary button - outlined
                        PrimaryButton(
                          label: 'Use phone number',
                          labelSize: 16,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PhoneNumberPage(),
                              ),
                            );
                          },
                          variant: PrimaryButtonVariant.outlined,
                          height: 64 * scale,
                          borderRadius: 24,
                        ),

                        const SizedBox(height: 86),

                        // Or divider
                        Row(
                          children: [
                            Expanded(child: Divider(color: AppColors.border)),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                'or sign up with',
                                style: TextStyle(
                                  color: Color(0xFF9A9A9A),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Expanded(child: Divider(color: AppColors.border)),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // Social icons row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SocialIconButton(
                              assetPath: 'assets/images/facebook_50.png',
                              size: 72,
                              onTap: () {},
                            ),
                            SocialIconButton(
                              assetPath: 'assets/images/google_50.png',
                              size: 72,
                              onTap: () {},
                            ),
                            SocialIconButton(
                              assetPath: 'assets/images/apple_inc_50.png',
                              size: 72,
                              onTap: () {},
                            ),
                          ],
                        ),

                        const Spacer(),

                        // Terms / Privacy links
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0, top: 36),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Terms of use',
                                  style: AppTextStyles.footerLink(14 * scale),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Privacy Policy',
                                  style: AppTextStyles.footerLink(14 * scale),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
