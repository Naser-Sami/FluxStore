import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit(super.initialLocale);

  void changeLanguage(Locale locale, BuildContext context) {
    context.setLocale(locale);
    emit(locale);
  }
}
