import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart' show UserSessionCubit;

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, this.radius = 30});

  final double radius;

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;
    final textStyle = context.textTheme;

    return FutureBuilder(
      future: sl<UserSessionCubit>().getSavedUser(),
      builder: (context, snapshot) {
        final user = snapshot.data;

        return ListTile(
          leading: CircleAvatar(
            radius: radius,
            backgroundColor: color.secondary,
            child: Icon(CupertinoIcons.person, color: color.onSecondary),
          ),
          title: TextWidget(
            user?.username ?? LocaleKeys.Authentication_userName,
            style: textStyle.titleLarge?.copyWith(fontSize: 18.sp),
          ),
          subtitle: TextWidget(
            user?.email ?? "user@email.com",
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
