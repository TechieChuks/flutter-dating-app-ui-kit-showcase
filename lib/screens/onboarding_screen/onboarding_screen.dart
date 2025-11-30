import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding_data_model.dart'; // leave your model file as-is
import '../../widgets/primary_button.dart';
import '../../widgets/dot_indicator.dart';
import '../../widgets/onboarding_card.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_colors.dart';
import '../signup/sign_up_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, required this.title});

  final String title;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // You can replace these with assets or remote data; left as network to match your original.
  final List<OnboardingPage> _pages = [
    OnboardingPage(
      image:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=800&auto=format&fit=crop',
      title: 'Algorithm',
      subtitle:
          'Users going through a vetting process to ensure you never match with bots.',
    ),
    OnboardingPage(
      image:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?q=80&w=800&auto=format&fit=crop',
      title: 'Matches',
      subtitle:
          'We match you with people that have a large array of similar interests.',
    ),
    OnboardingPage(
      image:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=800&auto=format&fit=crop',
      title: 'Discover',
      subtitle: 'Find people and events happening near you every day.',
    ),
    OnboardingPage(
      image:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?q=80&w=801&auto=format&fit=crop',
      title: 'Secure',
      subtitle: 'Privacy-first design and secure messaging built in.',
    ),
  ];

  late final PageController _pageController;
  Timer? _autoPlayTimer;
  int _currentIndex = 0;

  final Duration _autoPlayInterval = const Duration(seconds: 4);
  final Duration _pageTransitionDuration = const Duration(milliseconds: 400);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.82);
    _pageController.addListener(_pageListener);
    _startAutoPlay();
  }

  void _pageListener() {
    final page = _pageController.page;
    if (page == null) return;
    final round = page.round();
    if (round != _currentIndex) {
      setState(() => _currentIndex = round);
    }
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(_autoPlayInterval, (_) {
      var next = _currentIndex + 1;
      if (next >= _pages.length) next = 0;
      _pageController.animateToPage(
        next,
        duration: _pageTransitionDuration,
        curve: Curves.easeInOut,
      );
    });
  }

  void _stopAutoPlay() => _autoPlayTimer?.cancel();

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  void _onUserInteraction() {
    _stopAutoPlay();
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) _startAutoPlay();
    });
  }

  void _onCreateAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SignUpPage()),
    );
  }

  // Scale helper for responsive typography/padding
  double _scale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width / 390).clamp(0.85, 1.25);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final scale = _scale(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _onUserInteraction,
          onPanDown: (_) => _onUserInteraction(),
          child: Column(
            children: [
              // PageView (top area)
              SizedBox(
                height: media.height * 0.5,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                    _onUserInteraction();
                  },
                  itemBuilder: (context, index) {
                    final item = _pages[index];

                    // compute parallax/scale based on PageController.page
                    double scaleValue = 1.0;
                    if (_pageController.hasClients &&
                        _pageController.position.haveDimensions) {
                      final page =
                          _pageController.page ??
                          _pageController.initialPage.toDouble();
                      final distance = (page - index).abs();
                      scaleValue = (1 - (distance * 0.08)).clamp(0.92, 1.0);
                    } else {
                      scaleValue = index == 0 ? 1.0 : 0.94;
                    }

                    return OnboardingCard(
                      data: item,
                      scale: scaleValue,
                      cornerRadius: 28,
                    );
                  },
                ),
              ),

              SizedBox(height: 14 * scale),

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  _pages[_currentIndex].title,
                  style: AppTextStyles.heading(28 * scale),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 12),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  _pages[_currentIndex].subtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.subtitle,
                ),
              ),

              const SizedBox(height: 20),

              // Dots
              DotIndicator(
                count: _pages.length,
                currentIndex: _currentIndex,
                activeWidth: 14,
                dotSize: 8,
                spacing: 6,
              ),

              SizedBox(height: 20 * scale),

              // CTA (reuses PrimaryButton)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: PrimaryButton(
                  label: 'Create an account',
                  onPressed: _onCreateAccount,
                  variant: PrimaryButtonVariant.filled,
                  height: 56 * scale,
                  borderRadius: 14,
                ),
              ),

              const SizedBox(height: 12),

              // Sign In hint
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextButton(
                  onPressed: () {
                    // TODO: implement sign-in navigation
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14 * scale,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14 * scale,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 6),

              // thin bottom progress bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                width: 120,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.thinBar,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (_currentIndex + 1) / _pages.length,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
