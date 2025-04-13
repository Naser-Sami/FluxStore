import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/_features.dart'
    show ResetPasswordUseCase, ResetPasswordParams;

class ResetPasswordCubit extends Cubit<String> {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordCubit({required this.resetPasswordUseCase}) : super("");

  Future<void> resetPassword({required ResetPasswordParams params}) async {
    final response = await resetPasswordUseCase.call(params);
    response.fold((failure) => emit("Error: ${failure.error}"), emit);
  }
}
