import 'package:flutter/material.dart';

import '/config/_config.dart' show TPadding, TSize, TextWidget;
import '/core/_core.dart' show LocaleKeys, BuildContextExtensions;

class VerificationCodeScreen extends StatelessWidget {
  static const String routeName = '/verification-code';
  static const String name = 'Verification Code';
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: TPadding.p36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: TSize.s44),
                TextWidget(
                  LocaleKeys.Authentication_verificationCode,
                  style: context.textTheme.headlineLarge?.copyWith(height: 1.7),
                ),
                const SizedBox(height: TSize.s08),
                TextWidget(
                  LocaleKeys.Authentication_verificationCodeMsg,
                  style: context.textTheme.bodySmall?.copyWith(height: 1.7),
                ),
                const SizedBox(height: TSize.s48),
                // TextFormFieldComponent(
                //   labelText: LocaleKeys.Authentication_enterYourEmailHere,
                //   keyboardType: TextInputType.emailAddress,
                //   prefixIcon: const Icon(Icons.email_outlined),
                //   validator:
                //       (value) => TValidator.validateEmail(
                //         LocaleKeys.Authentication_enterYourEmailHere,
                //       ),
                //   onFieldSubmitted: (val) {
                //     // Send OTP to the user via email
                //     // Navigate to the verification code screen
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
