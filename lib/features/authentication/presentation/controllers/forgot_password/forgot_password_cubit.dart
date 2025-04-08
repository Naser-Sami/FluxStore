import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/_features.dart'
    show ForgotPasswordUseCase, ForgotPasswordParams;

class ForgotPasswordCubit extends Cubit<String> {
  final ForgotPasswordUseCase forgotPasswordUseCase;
  ForgotPasswordCubit({required this.forgotPasswordUseCase}) : super("");

  Future<void> forgotPassword({required ForgotPasswordParams params}) async {
    final response = await forgotPasswordUseCase.call(params);
    response.fold((failure) => emit(failure.error), emit);
  }
}
