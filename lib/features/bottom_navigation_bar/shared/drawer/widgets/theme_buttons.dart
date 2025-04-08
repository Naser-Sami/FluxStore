import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart';
import '/core/_core.dart';

class ThemeButtons extends StatefulWidget {
  const ThemeButtons({super.key});

  @override
  State<ThemeButtons> createState() => _ThemeButtonsState();
}

class _ThemeButtonsState extends State<ThemeButtons> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = context.read<ThemeCubit>().initialValue.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth * 0.6;
    return SizedBox(
      height: 40,
      width: width,
      child: ToggleButtons(
        borderRadius: BorderRadius.circular(TRadius.r16),
        onPressed: (int index) {
          context.read<ThemeCubit>().switchTheme(ThemeStyle.values[index]);
          setState(() {
            _selectedIndex = index;
          });
        },
        isSelected: List.generate(
          ThemeStyle.values.length,
          (index) => index == _selectedIndex,
        ),
        children:
            ThemeStyle.values
                .map(
                  (e) => SizedBox(
                    width: width * 0.32,
                    child: Center(
                      child: TextWidget(
                        e.name.toCapitalized,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
