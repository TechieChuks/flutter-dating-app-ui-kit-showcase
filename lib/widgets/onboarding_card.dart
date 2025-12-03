import 'package:flutter/material.dart';
import '../screens/onboarding_screen/onboarding_data_model.dart'; // your model

class OnboardingCard extends StatelessWidget {
  final OnboardingPage data;
  final double scale;
  final double cornerRadius;

  const OnboardingCard({
    super.key,
    required this.data,
    this.scale = 1.0,
    this.cornerRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    // this card focuses only on the visual - title/subtitle are rendered externally in the screen
    return Transform.scale(
      scale: scale,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(cornerRadius),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      offset: Offset(0, 10),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(cornerRadius),
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: Image.network(
                      data.image,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(Icons.broken_image, size: 48),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
