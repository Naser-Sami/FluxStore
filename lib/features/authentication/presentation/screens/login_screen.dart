import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/authentication/presentation/presentation.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  static const String name = 'Login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: TPadding.p53,
            horizontal: TPadding.p36,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  LocaleKeys.Authentication_loginInto,
                  style: context.textTheme.headlineLarge?.copyWith(height: 2.0),
                ),
                TextWidget(
                  LocaleKeys.Authentication_yourAccount,
                  style: context.textTheme.headlineLarge?.copyWith(height: 2.0),
                ),
                const SizedBox(height: TSize.s48),

                TextFormFieldComponent(
                  labelText: LocaleKeys.Authentication_emailAddress,
                  validator:
                      (value) => TValidator.validateEmail(
                        LocaleKeys.Authentication_emailAddress,
                      ),
                ),
                const SizedBox(height: TSize.s20),
                TextFormFieldComponent(
                  labelText: LocaleKeys.Authentication_password,
                  obscureText: true,
                  validator:
                      (value) => TValidator.validateEmail(
                        LocaleKeys.Authentication_password,
                      ),
                ),
                const SizedBox(height: TSize.s44),
                Center(
                  child: CustomButton(
                    onTap: () {},
                    text: LocaleKeys.Authentication_login,
                    backgroundColor: context.theme.colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: TSize.s28),
                Center(
                  child: TextWidget(
                    LocaleKeys.Authentication_orLoginWith,
                    style: context.textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: TSize.s28),
                const AuthenticationWithSocialWidget(),
                const SizedBox(height: TSize.s32),
                AuthenticationRichTextWidget(
                  text1: LocaleKeys.Authentication_noAccount,
                  text2: LocaleKeys.Authentication_signup,
                  onTap:
                      () => context.pushReplacement(
                        CreateAccountScreen.routeName,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
