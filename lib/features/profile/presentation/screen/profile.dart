import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/core/_core.dart';
import '/features/_features.dart'
    show InfoCard, ProfileSettingsScreen, SplashScreen, UserSessionCubit;

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  static const String name = 'Profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;
    final iconColor = color.onSurface.withValues(alpha: 0.50);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 20),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TPadding.p24),
          child: ListView(
            children: [
              Row(
                children: [
                  const Expanded(child: InfoCard(radius: 40)),
                  IconButton(
                    onPressed: () {
                      context.push(ProfileSettingsScreen.routeName);
                    },
                    icon: Icon(Icons.settings, color: iconColor),
                  ),
                ],
              ),
              const SizedBox(height: TSize.s48),
              Container(
                width: context.screenWidth,
                constraints: BoxConstraints(
                  maxHeight: context.screenHeight * 0.54,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: color.surface,
                  borderRadius: BorderRadius.circular(TRadius.r20),
                  boxShadow: [
                    BoxShadow(
                      color: context.theme.colorScheme.scrim.withValues(
                        alpha: TFunctions.isDarkMode(context) ? 1 : 0.2,
                      ),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    OnTapScaler(
                      onTap: () {},
                      child: ListTile(
                        minTileHeight: 76,
                        leading: IconWidget(name: 'location', color: iconColor),
                        title: const TextWidget(LocaleKeys.Profile_address),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: iconColor,
                        ),
                      ),
                    ),
                    const Divider(),
                    OnTapScaler(
                      onTap: () {},
                      child: ListTile(
                        minTileHeight: 76,
                        leading: IconWidget(name: 'wallet', color: iconColor),
                        title: const TextWidget(
                          LocaleKeys.Profile_paymentMethods,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: iconColor,
                        ),
                      ),
                    ),
                    const Divider(),
                    OnTapScaler(
                      onTap: () {},
                      child: ListTile(
                        minTileHeight: 76,
                        leading: IconWidget(name: 'voucher', color: iconColor),
                        title: const TextWidget(LocaleKeys.Profile_vouchers),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: iconColor,
                        ),
                      ),
                    ),
                    const Divider(),
                    OnTapScaler(
                      onTap: () {},
                      child: ListTile(
                        minTileHeight: 76,
                        leading: IconWidget(name: 'favorite', color: iconColor),
                        title: const TextWidget(LocaleKeys.Profile_myWishlist),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: iconColor,
                        ),
                      ),
                    ),
                    const Divider(),
                    OnTapScaler(
                      onTap: () {},
                      child: ListTile(
                        minTileHeight: 76,
                        leading: IconWidget(name: 'star', color: iconColor),
                        title: const TextWidget(LocaleKeys.Profile_rateUs),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: iconColor,
                        ),
                      ),
                    ),
                    const Divider(),
                    OnTapScaler(
                      onTap: () {
                        sl<UserSessionCubit>().logout();
                        context.go(SplashScreen.routeName);
                      },
                      child: ListTile(
                        minTileHeight: 76,
                        leading: IconWidget(name: 'logout', color: iconColor),
                        title: const TextWidget(
                          LocaleKeys.Authentication_logout,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
