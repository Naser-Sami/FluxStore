import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart'
    show
        GoogleAuthEvent,
        HomeScreen,
        SignUpBloc,
        SignUpFailure,
        SignUpLoading,
        SignUpState,
        SignUpSuccess;

class AuthenticationWithSocialWidget extends StatefulWidget {
  const AuthenticationWithSocialWidget({super.key});

  @override
  State<AuthenticationWithSocialWidget> createState() =>
      _AuthenticationWithSocialWidgetState();
}

class _AuthenticationWithSocialWidgetState
    extends State<AuthenticationWithSocialWidget> {
  void _singUpWithGoogle() =>
      context.read<SignUpBloc>().add(const GoogleAuthEvent());

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) async {
        if (state is SignUpLoading) {
          showLoadingDialog(context);
          await Future.delayed(const Duration(seconds: 1)).then((v) {
            if (context.mounted) {
              context.pop();
            }
          });
        }

        if (state is SignUpSuccess) {
          // await sl<UserSessionCubit>().saveUser(state.user);
          // handel user or admin
          if (context.mounted) {
            context.go(HomeScreen.routeName);
          }
        }

        if (state is SignUpFailure) {
          log("Error: ${state.error} StatusCode: ${state.statusCode}");

          errorDialog(
            context,
            message:
                state.error.startsWith('Exception:')
                    ? state.error.substring(10)
                    : state.error,
          );
        }
      },
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OnTapScaler(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(TPadding.p12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2.0,
                    color: context.theme.colorScheme.secondary.withValues(
                      alpha: 0.20,
                    ),
                  ),
                ),
                child: IconWidget(
                  name: ImagesPath.apple,
                  color: context.theme.colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(width: TSize.s20),
            OnTapScaler(
              onTap: _singUpWithGoogle,
              child: Container(
                padding: const EdgeInsets.all(TPadding.p12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2.0,
                    color: context.theme.colorScheme.secondary.withValues(
                      alpha: 0.20,
                    ),
                  ),
                ),
                child: const IconWidget(name: ImagesPath.google),
              ),
            ),
            const SizedBox(width: TSize.s20),
            OnTapScaler(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(TPadding.p12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2.0,
                    color: context.theme.colorScheme.secondary.withValues(
                      alpha: 0.20,
                    ),
                  ),
                ),
                child: const IconWidget(name: ImagesPath.facebook),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
