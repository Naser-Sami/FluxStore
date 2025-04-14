import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart'
    show TPadding, TSize, TextWidget, CustomButton, IconWidget;
import '/core/_core.dart' show LocaleKeys, BuildContextExtensions;
import '/features/_features.dart' show LoginParams, LoginBloc, OnLoginEvent;

showModalBottomSheetOnSuccessResetPassword(
  BuildContext context, {
  required String email,
  required String password,
}) {
  return showModalBottomSheet(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: context.theme.colorScheme.primaryContainer,
    builder: (context) {
      final colors = context.theme.colorScheme;
      return FractionallySizedBox(
        heightFactor: context.screenHeight > 670 ? 0.45 : 0.55,
        child: SizedBox(
          width: context.screenWidth,
          child: Padding(
            padding: const EdgeInsets.all(TPadding.p24),
            child: Column(
              spacing: TSize.s20,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: colors.surfaceContainer,
                  child: IconWidget(
                    name: 'success',
                    width: 50,
                    height: 50,
                    color: colors.onSurface,
                  ),
                ),
                TextWidget(
                  LocaleKeys.Authentication_yourPasswordHasBeenChanged,
                  style: context.textTheme.titleMedium,
                ),
                TextWidget(
                  LocaleKeys.Authentication_welcomeBackDiscoverNow,
                  style: context.textTheme.bodyMedium,
                ),
                const Spacer(),
                SizedBox(
                  width: context.screenWidth,
                  child: CustomButton(
                    onTap: () {
                      // LOGIN USER
                      final params = LoginParams(
                        email: email.trim(),
                        password: password.trim(),
                      );

                      context.read<LoginBloc>().add(
                        OnLoginEvent(params: params),
                      );
                    },
                    backgroundColor: colors.primary,
                    borderColor: colors.primary,
                    text: LocaleKeys.Authentication_browseHome,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
    },
  );
}
