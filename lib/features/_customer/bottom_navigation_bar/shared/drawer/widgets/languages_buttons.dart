import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart';
import '/core/_core.dart';

class LanguagesButtons extends StatelessWidget {
  const LanguagesButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth;

    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, state) {
        return Center(
          child: SizedBox(
            height: 40,
            child: ToggleButtons(
              borderRadius: BorderRadius.circular(TRadius.r16),
              onPressed: (index) {},
              isSelected: [
                context.locale == const Locale('en'),
                context.locale == const Locale('ar'),
              ],
              children: [
                OnTapScaler(
                  onTap: () {
                    context.read<LanguageCubit>().changeLanguage(
                      const Locale('en'),
                      context,
                    );
                  },
                  child: SizedBox(
                    width: width * 0.32,
                    child: const Center(
                      child: TextWidget(
                        "English",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                OnTapScaler(
                  onTap: () {
                    context.read<LanguageCubit>().changeLanguage(
                      const Locale('ar'),
                      context,
                    );
                  },
                  child: SizedBox(
                    width: width * 0.32,
                    child: const Center(
                      child: TextWidget(
                        "العربية",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
