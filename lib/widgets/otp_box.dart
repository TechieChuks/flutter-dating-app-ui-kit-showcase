import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class OtpBox extends StatelessWidget {
  final String digit;
  final bool filled;
  final bool focused;
  final double size;

  const OtpBox({
    super.key,
    required this.digit,
    this.filled = false,
    this.focused = false,
    this.size = 52,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = filled || focused
        ? AppColors.primary
        : Colors.grey.shade200;
    final backgroundColor = filled ? AppColors.primary : Colors.white;
    final textColor = filled ? Colors.white : Colors.grey.shade400;

    return Semantics(
      label: digit.isEmpty ? 'empty code digit' : 'code digit $digit',
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: filled ? 0 : 2),
          boxShadow: filled
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    offset: const Offset(0, 6),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          digit.isEmpty ? '' : digit,
          style: TextStyle(
            fontSize: size * 0.42,
            fontWeight: FontWeight.w700,
            color: filled ? Colors.white : textColor,
          ),
        ),
      ),
    );
  }
}
