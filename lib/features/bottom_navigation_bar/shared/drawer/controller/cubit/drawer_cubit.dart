import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/_core.dart' show LocaleKeys;
import '/features/_features.dart' show DrawerItem;

class DrawerCubit extends Cubit<List<DrawerItem>> {
  DrawerCubit() : super([]);

  void loadDrawerItems() {
    emit([
      DrawerItem(
        icon: 'home',
        title: LocaleKeys.DrawerMenu_homePage,
        isSelected: true,
      ),
      DrawerItem(icon: 'search', title: LocaleKeys.DrawerMenu_discover),
      DrawerItem(icon: 'bag', title: LocaleKeys.DrawerMenu_myOrders),
      DrawerItem(icon: 'profile', title: LocaleKeys.DrawerMenu_myProfile),
      DrawerItem(icon: 'settings', title: LocaleKeys.DrawerMenu_settings),
      DrawerItem(icon: 'mail', title: LocaleKeys.DrawerMenu_support),
      DrawerItem(icon: 'info', title: LocaleKeys.DrawerMenu_aboutUs),
    ]);
  }

  void selectItem(int index) {
    final updatedList = List<DrawerItem>.generate(state.length, (i) {
      return state[i].copyWith(isSelected: i == index);
    });
    emit(updatedList);

    // Optionally trigger the onTap callback
    final selectedItem = updatedList[index];
    selectedItem.onTap?.call();
  }
}
