import 'package:flutter/material.dart';

class GenderTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderTile({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final background = isSelected ? const Color(0xFFE83F5F) : Colors.white;
    final border = isSelected ? Colors.transparent : Colors.black12;
    final textColor = isSelected ? Colors.white : Colors.black;
    final iconColor = isSelected ? Colors.white : Colors.grey;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: border),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              Icon(Icons.check, size: 22, color: iconColor),
            ],
          ),
        ),
      ),
    );
  }
}
