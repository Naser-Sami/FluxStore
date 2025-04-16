import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '/core/_core.dart' show InternetStatus;

class InternetConnectionCubit extends Cubit<InternetStatus> {
  late StreamSubscription<InternetConnectionStatus> _subscription;
  final connectionChecker = InternetConnectionChecker.instance;

  InternetConnectionCubit() : super(InternetStatus.connected) {
    _subscription = connectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        emit(InternetStatus.connected);
      } else {
        emit(InternetStatus.disconnected);
      }
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
