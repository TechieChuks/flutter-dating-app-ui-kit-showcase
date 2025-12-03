import 'package:flutter/material.dart';

class CircleActionButton extends StatelessWidget {
  final Widget child;
  final double size;
  final VoidCallback? onTap;
  final double elevation;

  const CircleActionButton({
    super.key,
    required this.child,
    this.size = 84,
    this.onTap,
    this.elevation = 12,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: child,
        ),
      ),
    );
  }
}
