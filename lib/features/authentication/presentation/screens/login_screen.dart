import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/core/_core.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: TPadding.p36),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: TSize.s44),
                TextWidget(
                  LocaleKeys.Authentication_loginInto,
                  style: context.textTheme.headlineLarge?.copyWith(height: 1.7),
                ),
                TextWidget(
                  LocaleKeys.Authentication_yourAccount,
                  style: context.textTheme.headlineLarge?.copyWith(height: 1.7),
                ),
                const SizedBox(height: TSize.s48),
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
                const SizedBox(height: TSize.s24),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: GestureDetector(
                    onTap: () => context.push(ForgotPasswordScreen.routeName),
                    child: TextWidget(
                      LocaleKeys.Authentication_forgotPassword,
                      style: context.textTheme.bodySmall,
                    ),
                  ),
                ),
                const SizedBox(height: TSize.s24),
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
                const SizedBox(height: TSize.s24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
