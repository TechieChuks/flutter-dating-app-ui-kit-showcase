import 'package:flutter/material.dart';

class SocialIconButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback? onTap;
  final double size;
  final double radius;

  const SocialIconButton({
    Key? key,
    required this.assetPath,
    this.onTap,
    this.size = 72,
    this.radius = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Sign up with ${assetPath.split('/').last}',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: const Color(0xFFF2F2F2), width: 1.25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              assetPath,
              width: size * 0.45,
              height: size * 0.45,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
