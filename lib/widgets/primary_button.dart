import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum PrimaryButtonVariant { filled, outlined }

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final PrimaryButtonVariant variant;
  final bool loading;
  final double height;
  final double borderRadius;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.variant = PrimaryButtonVariant.filled,
    this.loading = false,
    this.height = 64,
    this.borderRadius = 22,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isOutlined = variant == PrimaryButtonVariant.outlined;
    final Color backgroundColor = isOutlined ? Colors.white : AppColors.primary;
    final Color borderColor = isOutlined ? AppColors.border : AppColors.primary;
    final Color textColor = isOutlined ? AppColors.primary : Colors.white;

    return Semantics(
      button: true,
      label: label,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: loading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: backgroundColor,
            side: BorderSide(color: borderColor, width: isOutlined ? 1.25 : 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          child: loading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
