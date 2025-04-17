import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart' show LoadedState, ProfileBloc, ProfileState;

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;
    final textStyle = context.textTheme;

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is LoadedState) {
          final user = state.profile;
          final image = '${ApiEndpoints.imageUrl}${user.imageUrl}';

          return ListTile(
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.onSecondary,
                shape: BoxShape.circle,
                image:
                    user.imageUrl != ''
                        ? DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                        )
                        : null,
              ),
              child:
                  user.imageUrl == ''
                      ? Icon(CupertinoIcons.person, color: color.onSecondary)
                      : null,
            ),
            title: TextWidget(
              user.firstName.isNotEmpty
                  ? '${user.firstName} ${user.lastName}'
                  : LocaleKeys.Authentication_userName,
              style: textStyle.titleLarge?.copyWith(fontSize: 18),
            ),
            subtitle: TextWidget(
              user.email,
              style: textStyle.bodyMedium?.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
