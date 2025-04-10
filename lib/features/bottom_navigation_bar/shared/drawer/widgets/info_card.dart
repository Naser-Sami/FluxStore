import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flux_store/features/_features.dart';

import '/config/_config.dart';
import '/core/_core.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;
    final textStyle = context.textTheme;
    final user = sl<UserSessionCubit>().state;

    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: color.secondary,
        child: Icon(CupertinoIcons.person, color: color.onSecondary),
      ),
      title: TextWidget(
        user?.username ?? "User Name",
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
  }
}
