import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/authentication/presentation/presentation.dart';

class CreateAccountScreen extends StatelessWidget {
  static const String routeName = '/create-account';
  static const String name = 'Create Account';
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TPadding.p36),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: TSize.s20),
                TextWidget(
                  LocaleKeys.Authentication_create,
                  style: context.textTheme.headlineLarge?.copyWith(height: 1.7),
                ),
                TextWidget(
                  LocaleKeys.Authentication_yourAccount,
                  style: context.textTheme.headlineLarge?.copyWith(height: 1.7),
                ),
                const SizedBox(height: TSize.s20),
                TextFormFieldComponent(
                  labelText: LocaleKeys.Authentication_enterYourName,
                  keyboardType: TextInputType.text,
                  validator:
                      (value) => TValidator.validateEmptyText(
                        LocaleKeys.Authentication_enterYourName,
                        value,
                      ),
                ),
                const SizedBox(height: TSize.s20),
                TextFormFieldComponent(
                  labelText: LocaleKeys.Authentication_emailAddress,
                  keyboardType: TextInputType.emailAddress,
                  validator:
                      (value) => TValidator.validateEmail(
                        LocaleKeys.Authentication_emailAddress,
                      ),
                ),
                const SizedBox(height: TSize.s20),
                TextFormFieldComponent(
                  labelText: LocaleKeys.Authentication_password,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator:
                      (value) => TValidator.validateEmail(
                        LocaleKeys.Authentication_password,
                      ),
                ),
                const SizedBox(height: TSize.s20),
                TextFormFieldComponent(
                  labelText: LocaleKeys.Authentication_confirmPassword,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator:
                      (value) => TValidator.validateEmail(
                        LocaleKeys.Authentication_confirmPassword,
                      ),
                ),
                const SizedBox(height: TSize.s44),
                Center(
                  child: CustomButton(
                    onTap: () {},
                    text: LocaleKeys.Authentication_signup,
                    backgroundColor: context.theme.colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: TSize.s28),
                Center(
                  child: TextWidget(
                    LocaleKeys.Authentication_orSignUpWith,
                    style: context.textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: TSize.s28),
                const AuthenticationWithSocialWidget(),
                const SizedBox(height: TSize.s32),
                AuthenticationRichTextWidget(
                  text1: LocaleKeys.Authentication_haveAccount,
                  text2: LocaleKeys.Authentication_login,
                  onTap: () => context.pushReplacement(LoginScreen.routeName),
                ),
                const SizedBox(height: TSize.s24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
