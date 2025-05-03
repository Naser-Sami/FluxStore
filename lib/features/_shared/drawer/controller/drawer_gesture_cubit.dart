import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerGestureCubit extends Cubit<bool> {
  DrawerGestureCubit() : super(false); // disabled by default

  void enable() => emit(true);
  void disable() => emit(false);
}
