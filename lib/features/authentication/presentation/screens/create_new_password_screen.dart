import 'package:flutter/material.dart';

import '/config/_config.dart'
    show TPadding, TSize, TextWidget, TextFormFieldComponent, CustomButton;
import '/core/_core.dart' show LocaleKeys, TValidator, BuildContextExtensions;

class CreateNewPasswordScreen extends StatelessWidget {
  static const String routeName = '/create-new-password';
  static const String name = 'Create New Password';
  const CreateNewPasswordScreen({super.key});

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
                  LocaleKeys.Authentication_createNewPassword,
                  style: context.textTheme.headlineLarge?.copyWith(height: 1.7),
                ),
                const SizedBox(height: TSize.s08),
                TextWidget(
                  LocaleKeys.Authentication_createNewPasswordMsg,
                  style: context.textTheme.bodySmall?.copyWith(height: 1.7),
                ),
                const SizedBox(height: TSize.s48),
                TextFormFieldComponent(
                  labelText: LocaleKeys.Authentication_newPassword,
                  keyboardType: TextInputType.visiblePassword,
                  validator:
                      (value) => TValidator.validateEmail(
                        LocaleKeys.Authentication_newPassword,
                      ),
                ),
                const SizedBox(height: TSize.s20),
                TextFormFieldComponent(
                  labelText: LocaleKeys.Authentication_confirmNewPassword,
                  keyboardType: TextInputType.visiblePassword,
                  validator:
                      (value) => TValidator.validateEmail(
                        LocaleKeys.Authentication_confirmNewPassword,
                      ),
                ),
                const SizedBox(height: TSize.s100),
                CustomButton(
                  onTap: () {},
                  text: LocaleKeys.Authentication_confirm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
