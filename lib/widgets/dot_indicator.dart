import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DotIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final double activeWidth;
  final double dotSize;
  final double spacing;

  const DotIndicator({
    Key? key,
    required this.count,
    required this.currentIndex,
    this.activeWidth = 14,
    this.dotSize = 8,
    this.spacing = 6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final bool active = i == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          width: active ? activeWidth : dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color: active ? AppColors.primary : AppColors.dotInactive,
            borderRadius: BorderRadius.circular(dotSize),
          ),
        );
      }),
    );
  }
}
