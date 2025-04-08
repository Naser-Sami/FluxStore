import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_store/features/home_screen.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/authentication/_authentication.dart';

class CreateAccountScreen extends StatefulWidget {
  static const String routeName = '/create-account';
  static const String name = 'Create Account';
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _signUpButtonPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      final params = SignUpParams(
        username: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        confirmPassword: _confirmPasswordController.text.trim(),
        role: 0,
      );

      if (_passwordController.text.trim() !=
          _confirmPasswordController.text.trim()) {
        errorDialog(
          context,
          message: LocaleKeys.Validation_passwordsDoNotMatch,
        );
      } else {
        context.read<SignUpBloc>().add(SignUpButtonPressed(params: params));
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) async {
          if (state is SignUpLoading) {
            showLoadingDialog(context);
          } else if (state is SignUpSuccess) {
            context.pop();
            await sl<UserSessionCubit>().saveUser(state.user);
            // handel user or admin
            if (context.mounted) {
              context.pushReplacement(HomeScreen.routeName);
            }
          } else if (state is SignUpFailure) {
            context.pop();
            errorDialog(
              context,
              message: state.error.replaceAll('Exception: ', ''),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TPadding.p36),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: TSize.s20),
                  TextWidget(
                    LocaleKeys.Authentication_create,
                    style: context.textTheme.headlineLarge?.copyWith(
                      height: 1.7,
                    ),
                  ),
                  TextWidget(
                    LocaleKeys.Authentication_yourAccount,
                    style: context.textTheme.headlineLarge?.copyWith(
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: TSize.s20),
                  TextFormFieldComponent(
                    controller: _nameController,
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
                    controller: _emailController,
                    labelText: LocaleKeys.Authentication_emailAddress,
                    keyboardType: TextInputType.emailAddress,
                    validator: TValidator.validateEmail,
                  ),
                  const SizedBox(height: TSize.s20),
                  TextFormFieldComponent(
                    controller: _passwordController,
                    labelText: LocaleKeys.Authentication_password,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: TValidator.validatePassword,
                  ),
                  const SizedBox(height: TSize.s20),
                  TextFormFieldComponent(
                    controller: _confirmPasswordController,
                    labelText: LocaleKeys.Authentication_confirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: TValidator.validatePassword,
                  ),
                  const SizedBox(height: TSize.s44),
                  Center(
                    child: CustomButton(
                      onTap: _signUpButtonPressed,
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
      ),
    );
  }
}
