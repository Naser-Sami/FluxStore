import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart'
    show TPadding, TSize, TextWidget, TextFormFieldComponent;
import '/core/_core.dart'
    show
        sl,
        BuildContextExtensions,
        ISendEmailOtpService,
        LocaleKeys,
        TValidator,
        errorDialog,
        showLoadingDialog;
import 'verification_code_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgot-password';
  static const String name = 'Forgot Password';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TPadding.p36),
          child: Form(
            key: _formKey,
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
                  controller: _emailController,
                  labelText: LocaleKeys.Authentication_enterYourEmailHere,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator:
                      (value) =>
                          TValidator.validateEmail(_emailController.text),
                  onFieldSubmitted: (val) async {
                    // Check if the form is valid
                    if (_formKey.currentState?.validate() ?? false) {
                      // Show loading dialog
                      showLoadingDialog(context);

                      // Send OTP to the user via email
                      final emailSent = await sl<ISendEmailOtpService>()
                          .sendOTP(email: _emailController.text);

                      // Hide loading dialog
                      if (context.mounted) Navigator.of(context).pop();

                      if (emailSent) {
                        if (context.mounted) {
                          // Navigate to the verification code screen
                          // and pass the email to the screen
                          context.push(
                            VerificationCodeScreen.routeName,
                            extra: {'email': _emailController.text},
                          );
                        }
                      } else {
                        if (context.mounted) {
                          errorDialog(
                            context,
                            message: LocaleKeys.Common_otpFailed,
                          );
                        }
                      }
                    }
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
