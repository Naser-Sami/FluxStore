import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart' show TextWidget, TSize, TPadding, CustomButton;
import '/core/_core.dart';
import '/features/_features.dart' show OnboardingScreen;

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/welcome';
  static const String name = 'Welcome';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: context.screenWidth,
            height: context.screenHeight,
            child: const Image(
              image: AssetImage(ImagesPath.welcomeBackground),
              fit: BoxFit.cover,
            ),
          ).scaleAnimation(duration: const Duration(milliseconds: 600)),

          SizedBox(
            width: context.screenWidth,
            height: context.screenHeight,
            child: ColoredBox(
              color: const Color.fromRGBO(0, 0, 0, 1).withValues(alpha: 0.50),
              child: Padding(
                padding: const EdgeInsets.only(bottom: TPadding.p100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget(
                      LocaleKeys.Welcome_welcomeMessage,
                      style: context.textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ).scaleAnimation(
                      duration: const Duration(milliseconds: 800),
                    ),
                    const SizedBox(height: TSize.s14),
                    TextWidget(
                      LocaleKeys.Welcome_explore,
                      style: context.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ).scaleAnimation(
                      duration: const Duration(milliseconds: 900),
                    ),
                    const SizedBox(height: TSize.s40),
                    CustomButton(
                      onTap: () => context.go(OnboardingScreen.routeName),
                      text: LocaleKeys.Welcome_getStarted,
                      textColor: Colors.white,
                      borderColor: Colors.white,
                    ).scaleAnimation(
                      duration: const Duration(milliseconds: 1000),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
