import 'package:flutter/material.dart';

class PhoneInput extends StatelessWidget {
  final String countryFlag;
  final String dialCode;
  final TextEditingController controller;
  final VoidCallback? onTapCountry;

  const PhoneInput({
    super.key,
    required this.countryFlag,
    required this.dialCode,
    required this.controller,
    this.onTapCountry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade300, width: 1.2),
      ),
      child: Row(
        children: [
          // Country selector
          GestureDetector(
            onTap: onTapCountry,
            child: Row(
              children: [
                Text(countryFlag, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 6),
                Text(
                  dialCode,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down, size: 22),
              ],
            ),
          ),

          const SizedBox(width: 20),

          // Divider
          Container(height: 30, width: 1.4, color: Colors.grey.shade300),

          const SizedBox(width: 20),

          // Phone number input
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "331 623 8413",
                border: InputBorder.none,
              ),
              style: theme.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
