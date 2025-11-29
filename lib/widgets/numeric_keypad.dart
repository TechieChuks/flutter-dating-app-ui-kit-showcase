import 'package:flutter/material.dart';

typedef OnKeyTap = void Function(String key);

class NumericKeypad extends StatelessWidget {
  final OnKeyTap onKeyTap;
  final double spacing;
  final double buttonSize;
  final Widget? backspaceIcon;

  const NumericKeypad({
    Key? key,
    required this.onKeyTap,
    this.spacing = 28,
    this.buttonSize = 72,
    this.backspaceIcon,
  }) : super(key: key);

  Widget _buildKey(BuildContext ctx, String label) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () => onKeyTap(label),
      child: SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final backIcon = backspaceIcon ?? Icon(Icons.backspace_outlined, size: 28);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var row in [
          ['1', '2', '3'],
          ['4', '5', '6'],
          ['7', '8', '9'],
        ])
          Padding(
            padding: EdgeInsets.only(bottom: spacing / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: row.map((k) => _buildKey(context, k)).toList(),
            ),
          ),
        // bottom row: empty, 0, back
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: buttonSize, height: buttonSize),
            _buildKey(context, '0'),
            InkWell(
              borderRadius: BorderRadius.circular(40),
              onTap: () => onKeyTap('back'),
              child: SizedBox(
                width: buttonSize,
                height: buttonSize,
                child: Center(child: backIcon),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
