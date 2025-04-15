import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart' show ProfileBloc, ProfileState;

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, this.radius = 30});

  final double radius;

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;
    final textStyle = context.textTheme;

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.error.isNotEmpty) {
          return const Center(child: Text('Error loading profile'));
        }
        final user = state.profile;
        return ListTile(
          leading: CircleAvatar(
            radius: radius,
            backgroundColor: color.secondary,
            child: Icon(CupertinoIcons.person, color: color.onSecondary),
          ),
          title: TextWidget(
            user.firstName.isNotEmpty
                ? user.firstName
                : LocaleKeys.Authentication_userName,
            style: textStyle.titleLarge?.copyWith(fontSize: 18.sp),
          ),
          subtitle: TextWidget(
            user.email,
            style: textStyle.bodyMedium?.copyWith(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
