import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart'
    show TPadding, TSize, TextWidget, TextFormFieldComponent, CustomButton;
import '/core/_core.dart'
    show LocaleKeys, TValidator, BuildContextExtensions, errorDialog;
import '/features/_features.dart'
    show ResetPasswordCubit, ResetPasswordParams, LoginScreen;

class CreateNewPasswordScreen extends StatefulWidget {
  static const String routeName = '/create-new-password';
  static const String name = 'Create New Password';
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _createNewPasswordButtonPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_passwordController.text.trim() !=
          _confirmPasswordController.text.trim()) {
        errorDialog(
          context,
          message: LocaleKeys.Validation_passwordsDoNotMatch,
        );
        return;
      } else {
        try {
          context.read<ResetPasswordCubit>().resetPassword(
            params: ResetPasswordParams(
              // TODO: get token from the url
              token:
                  '/LduTVHizGxL6RIbkYquofVCdMxfp7xqmkz0Urb2H5pG4mALIby/EtsqzZZqUs3uHzQWeQrRhOXwqYLqOs694g==',
              newPassword: _passwordController.text.trim(),
              confirmNewPassword: _confirmPasswordController.text.trim(),
            ),
          );

          context.go(LoginScreen.routeName);
        } catch (e) {
          errorDialog(context, message: e.toString());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    LocaleKeys.Authentication_createNewPassword,
                    style: context.textTheme.headlineLarge?.copyWith(
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: TSize.s08),
                  TextWidget(
                    LocaleKeys.Authentication_createNewPasswordMsg,
                    style: context.textTheme.bodySmall?.copyWith(height: 1.7),
                  ),
                  const SizedBox(height: TSize.s48),
                  TextFormFieldComponent(
                    controller: _passwordController,
                    labelText: LocaleKeys.Authentication_newPassword,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: TValidator.validatePassword,
                  ),
                  const SizedBox(height: TSize.s20),
                  TextFormFieldComponent(
                    controller: _confirmPasswordController,
                    labelText: LocaleKeys.Authentication_confirmNewPassword,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: TValidator.validatePassword,
                  ),
                  const SizedBox(height: TSize.s100),
                  Center(
                    child: CustomButton(
                      onTap: _createNewPasswordButtonPressed,
                      backgroundColor: context.theme.colorScheme.secondary,
                      text: LocaleKeys.Authentication_confirm,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
