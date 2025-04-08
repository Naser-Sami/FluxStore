import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '/config/_config.dart' show TPadding, TSize, TextWidget;
import '/core/_core.dart'
    show
        BuildContextExtensions,
        ISendEmailOtpService,
        LocaleKeys,
        showLoadingDialog,
        sl;
import '/features/authentication/_authentication.dart' show OTPInput;

class VerificationCodeScreen extends StatefulWidget {
  static const String routeName = '/verification-code';
  static const String name = 'Verification Code';

  const VerificationCodeScreen({super.key, required this.email});
  final String email;

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  Timer? _timer;
  int _remainingSeconds = 60;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _remainingSeconds = 60; // ✅ Start from 60
    _timer?.cancel(); // Clear any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _resendCode() async {
    // Show loading dialog
    showLoadingDialog(context);
    await sl<ISendEmailOtpService>().sendOTP(email: widget.email);
    _startCountdown(); // ✅ Restart timer
    // Hide loading dialog
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final canResend = _remainingSeconds == 0;

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TPadding.p36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: TSize.s96),
            TextWidget(
              LocaleKeys.Authentication_verificationCode,
              style: context.textTheme.headlineLarge?.copyWith(height: 1.7),
            ),
            const SizedBox(height: TSize.s08),
            TextWidget(
              LocaleKeys.Authentication_verificationCodeMsg,
              style: context.textTheme.bodyMedium?.copyWith(height: 1.7),
            ),
            const Spacer(),
            OTPInput(email: widget.email),
            const SizedBox(height: TSize.s24),
            TextButton(
              onPressed: canResend ? _resendCode : null,
              child: TextWidget(
                canResend
                    ? LocaleKeys.Common_resendOtp
                    : '${LocaleKeys.Common_resendIn.tr()} $_remainingSeconds ${LocaleKeys.Common_seconds.tr()}',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: canResend ? context.theme.colorScheme.primary : null,
                  fontWeight: canResend ? FontWeight.bold : null,
                ),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
