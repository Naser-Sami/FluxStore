import 'package:flutter/material.dart';

import '/core/_core.dart' show BuildContextExtensions;

class HomeSliderBanner extends StatefulWidget {
  const HomeSliderBanner({super.key});

  @override
  State<HomeSliderBanner> createState() => HomeSliderBannerState();
}

class HomeSliderBannerState extends State<HomeSliderBanner> {
  @override
  Widget build(BuildContext context) {
    //  final user = sl<UserSessionCubit>().state;
    final color = context.theme.colorScheme;

    return SizedBox(
      height: 168,
      child: PageView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 312,
            height: 168,
            decoration: BoxDecoration(
              color: color.primary.withValues(alpha: 0.1 * (index + 1)),
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }
}
