import 'package:flutter_bloc/flutter_bloc.dart';

class OnDrawerTapCubit extends Cubit<bool> {
  OnDrawerTapCubit() : super(true);

  void toggleDrawer() {
    emit(!state);
  }
}
