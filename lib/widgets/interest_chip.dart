import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class InterestChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback? onTap;
  final double height;
  final double borderRadius;

  const InterestChip({
    Key? key,
    required this.label,
    required this.icon,
    this.selected = false,
    this.onTap,
    this.height = 45,
    this.borderRadius = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bg = selected ? AppColors.primary : Colors.white;
    final txtColor = selected ? Colors.white : AppColors.textPrimary;
    final iconColor = selected ? Colors.white : AppColors.primary;

    final borderColor = selected ? AppColors.primary : AppColors.border;
    final shadow = selected
        ? [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: .18),
              offset: const Offset(0, 10),
              blurRadius: 20,
            ),
          ]
        : null;

    return Semantics(
      button: true,
      label: '$label ${selected ? "selected" : "not selected"}',
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor, width: 1.2),
            boxShadow: shadow,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon holder (slightly padded)
              Container(
                width: height * 0.56,
                height: height * 0.56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected
                      ? Colors.white.withValues(alpha: .12)
                      : Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: height * 0.36, color: iconColor),
              ),
              const SizedBox(width: 7),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: txtColor,
                    fontSize: 10,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
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
