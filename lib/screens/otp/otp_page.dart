import 'dart:async';
import 'package:datingapp/widgets/numeric_keypad.dart';
import 'package:datingapp/widgets/otp_box.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class OtpPage extends StatefulWidget {
  final int length;
  final Duration countdown;
  final void Function(String code)? onCompleted;

  const OtpPage({
    super.key,
    this.length = 4,
    this.countdown = const Duration(seconds: 60),
    this.onCompleted,
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  bool _isVerifying = false;
  bool _isSuccess = false;

  late List<String> _digits;
  late Duration _remaining;
  bool _resendAvailable = false;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _digits = List.generate(widget.length, (_) => '');
    _remaining = widget.countdown;

    _timer = Timer.periodic(Duration.zero, (_) {}); // placeholder
    _startTimer();
  }

  void _startTimer() {
    _timer.cancel(); // FIXED
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        if (_remaining.inSeconds > 0) {
          _remaining = Duration(seconds: _remaining.inSeconds - 1);
          _resendAvailable = false;
        } else {
          _resendAvailable = true;
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _currentCode => _digits.join();

  void _onKeyTap(String key) {
    setState(() {
      if (key == 'back') {
        for (var i = _digits.length - 1; i >= 0; i--) {
          if (_digits[i].isNotEmpty) {
            _digits[i] = '';
            break;
          }
        }
      } else {
        for (var i = 0; i < _digits.length; i++) {
          if (_digits[i].isEmpty) {
            _digits[i] = key;
            break;
          }
        }
      }

      // When all OTP digits filled
      if (!_digits.contains('')) {
        _triggerVerification();
        widget.onCompleted?.call(_currentCode);
      }
    });
  }

  Future<void> _triggerVerification() async {
    setState(() => _isVerifying = true);

    await Future.delayed(const Duration(seconds: 1)); // Simulate API

    setState(() => _isSuccess = true);

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, '/nextPage');
  }

  void _onResend() {
    if (!_resendAvailable) return;

    setState(() {
      _remaining = widget.countdown;
      _resendAvailable = false;
      _digits = List.generate(widget.length, (_) => '');
    });

    _startTimer();
  }

  String _formatTimer(Duration d) {
    final s = d.inSeconds % 60;
    final m = d.inMinutes.remainder(60);
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final scale = (width / 390).clamp(0.85, 1.15);

    final boxSize = (width * 0.145).clamp(36.0, 48.0);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                // Back button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () => Navigator.maybePop(context),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFFE74C67),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                // Timer
                Text(
                  _formatTimer(_remaining),
                  style: TextStyle(
                    fontSize: 44 * scale,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 12),

                // Subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Type the verification code\nwe've sent you",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18 * scale,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // OTP boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.length, (i) {
                    final digit = _digits[i];
                    final filled = digit.isNotEmpty;
                    final focused =
                        !filled &&
                        _digits.sublist(0, i).every((d) => d.isNotEmpty);

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: OtpBox(
                        digit: digit,
                        filled: filled,
                        focused: focused,
                        size: boxSize,
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 32),

                // Keypad
                Expanded(
                  child: Center(
                    child: NumericKeypad(
                      onKeyTap: _onKeyTap,
                      spacing: 24,
                      buttonSize: (width * 0.20).clamp(60.0, 86.0),
                      backspaceIcon: const Icon(
                        Icons.backspace_outlined,
                        size: 24,
                      ),
                    ),
                  ),
                ),

                // Resend
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  child: TextButton(
                    onPressed: _resendAvailable ? _onResend : null,
                    child: Text(
                      'Send again',
                      style: TextStyle(
                        color: AppColors.primary.withValues(
                          alpha: _resendAvailable ? 1.0 : 0.5,
                        ),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        decoration: _resendAvailable
                            ? TextDecoration.underline
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ),

        // =========================
        // SUCCESS & LOADING OVERLAY
        // =========================
        if (_isVerifying || _isSuccess)
          Container(
            color: Colors.black.withValues(alpha: 120),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: _isSuccess
                    ? Icon(
                        Icons.check_circle,
                        key: const ValueKey("success"),
                        size: 96,
                        color: Colors.green,
                      )
                    : const CircularProgressIndicator(
                        key: ValueKey("loading"),
                        strokeWidth: 3,
                      ),
              ),
            ),
          ),
      ],
    );
  }
}
