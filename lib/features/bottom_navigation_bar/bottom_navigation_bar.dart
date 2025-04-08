import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart'
    show BottomNavigationBarComponent, BottomNavigationBarCubit;

class BottomNavigationBarWidget extends StatelessWidget {
  static const routeName = '/flux-store';
  static const String name = 'Flux Store';

  const BottomNavigationBarWidget({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocListener<BottomNavigationBarCubit, int>(
        listener: (context, state) {
          navigationShell.goBranch(
            state,
            initialLocation: state == navigationShell.currentIndex,
          );
        },
        child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: true,
          body: navigationShell,
          bottomNavigationBar: const BottomNavigationBarComponent(),
        ),
      ),
    );
  }
}
