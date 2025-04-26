import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  static const String name = 'Login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _storage = sl<SecureStorageService>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(tryBiometricLogin);
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      final params = LoginParams(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      context.read<LoginBloc>().add(OnLoginEvent(params: params));
    }
  }

  Future<void> tryBiometricLogin() async {
    final refreshToken = await _storage.read(key: Constants.keyRefreshToken);
    log('Refreshing token: $refreshToken');

    if (refreshToken == null) {
      log('No refresh token found');
      return;
    }

    final isAuthenticated =
        await LocalAuthenticationService.authenticateWithBiometrics();

    if (isAuthenticated) {
      final success = await sl<RefreshTokenHandler>().tryRefreshToken();

      if (success) {
        final user = await sl<UserSessionCubit>().getSavedUser();
        if (user?.role.toLowerCase() == 'admin') {
          if (mounted) context.pushReplacement(AdminCategoryScreen.routeName);
        } else {
          if (mounted) context.pushReplacement(HomeScreen.routeName);
        }
      } else {
        // fallback or show login form
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state is LoginLoading) {
            showLoadingDialog(context);
          } else if (state is LoginSuccess) {
            context.pop();
            await sl<UserSessionCubit>().saveUser(state.user);

            // handel user or admin
            if (context.mounted) {
              if (state.user.role.toLowerCase() == 'admin') {
                context.pushReplacement(AdminCategoryScreen.routeName);
              } else {
                context.pushReplacement(HomeScreen.routeName);
              }
            }
          } else if (state is LoginFailure) {
            context.pop();
            errorDialog(
              context,
              message: state.error.replaceAll('Exception: ', ''),
            );
          }
        },
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
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
                        LocaleKeys.Authentication_loginInto,
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
                      const SizedBox(height: TSize.s48),
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
                      const SizedBox(height: TSize.s24),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: GestureDetector(
                          onTap:
                              () =>
                                  context.push(ForgotPasswordScreen.routeName),
                          child: TextWidget(
                            LocaleKeys.Authentication_forgotPassword,
                            style: context.textTheme.bodySmall,
                          ),
                        ),
                      ),
                      const SizedBox(height: TSize.s24),
                      Center(
                        child: CustomButton(
                          onTap: _login,
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
          ),
        ),
      ),
    );
  }
}
