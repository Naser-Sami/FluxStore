import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/config/_config.dart';
import '/core/_core.dart' show BuildContextExtensions, sl;
import '/features/_features.dart' show CategoryItem, UserSessionCubit;

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  static const String name = 'Home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = sl<UserSessionCubit>().state;
    final color = context.theme.colorScheme;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: TPadding.p32.r,
        ).copyWith(top: TPadding.p28.r),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [for (int i = 0; i < 4; i++) const CategoryItem()],
            ),
            const SizedBox(height: TSize.s32),
          ],
        ),
      ),
    );
  }
}
