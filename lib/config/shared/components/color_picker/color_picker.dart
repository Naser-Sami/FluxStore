import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '/core/utils/functions/functions.dart';

class ColorPickerComponent extends StatelessWidget {
  const ColorPickerComponent({
    super.key,
    required this.pickerColor,
    required this.onColorChanged,
    this.hexInputController,
  });

  final Color pickerColor;
  final void Function(Color) onColorChanged;
  final TextEditingController? hexInputController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorPicker(
          pickerColor: pickerColor,
          onColorChanged: onColorChanged,
          colorPickerWidth: 300,
          pickerAreaHeightPercent: 0.7,
          enableAlpha: true,
          displayThumbColor: true,
          paletteType: PaletteType.hsvWithHue,
          labelTypes: [],
          pickerAreaBorderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.circular(2),
          ),
          hexInputController: hexInputController,
          portraitOnly: true,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: CupertinoTextField(
            style: Theme.of(context).textTheme.bodyLarge,
            controller: hexInputController,
            prefix: const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(Icons.tag),
            ),
            suffix: IconButton(
              onPressed:
                  () => TFunctions.copyToClipboard(hexInputController?.text),
              icon: const Icon(Icons.content_paste_rounded),
            ),
            autofocus: true,
            maxLength: 9,
            inputFormatters: [
              UpperCaseTextFormatter(),
              FilteringTextInputFormatter.allow(RegExp(kValidHexPattern)),
            ],
          ),
        ),
      ],
    );
  }
}
