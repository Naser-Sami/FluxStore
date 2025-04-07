import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart'
    show TPadding, TSize, TextWidget, TextFormFieldComponent;
import '/core/_core.dart' show LocaleKeys, TValidator, BuildContextExtensions;
import 'verification_code_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = '/forgot-password';
  static const String name = 'Forgot Password';
  const ForgotPasswordScreen({super.key});

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
                  LocaleKeys.Authentication_forgotPassword,
                  style: context.textTheme.headlineLarge?.copyWith(height: 1.7),
                ),
                const SizedBox(height: TSize.s08),
                TextWidget(
                  LocaleKeys.Authentication_forgotPasswordMsg,
                  style: context.textTheme.bodySmall?.copyWith(height: 1.7),
                ),
                const SizedBox(height: TSize.s48),
                TextFormFieldComponent(
                  labelText: LocaleKeys.Authentication_enterYourEmailHere,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator:
                      (value) => TValidator.validateEmail(
                        LocaleKeys.Authentication_enterYourEmailHere,
                      ),
                  onFieldSubmitted: (val) {
                    // Send OTP to the user via email
                    // Navigate to the verification code screen
                    context.push(VerificationCodeScreen.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
