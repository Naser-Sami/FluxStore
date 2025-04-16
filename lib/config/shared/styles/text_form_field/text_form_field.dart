import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/config/_config.dart';
import '/core/_core.dart';

class TextFormFieldComponent extends StatelessWidget {
  const TextFormFieldComponent({
    super.key,
    this.hintText,
    this.suffix,
    this.suffixIcon,
    this.prefix,
    this.prefixIcon,
    this.textFieldWithTitle = false,
    this.title,
    this.controller,
    this.validator,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.keyboardType,
    this.inputFormatters,
    this.onSaved,
    this.label,
    this.labelText,
    this.readOnly = false,
  });

  // Variables
  final String? hintText;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? label;
  final String? labelText;
  final bool textFieldWithTitle;
  final String? title;
  final String obscuringCharacter;
  final bool obscureText;

  // Controllers
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;

  // Functions
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;

  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    if (textFieldWithTitle) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            title ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          TSize.s04.toHeight,
          _textField(context),
        ],
      );
    } else {
      return _textField(context);
    }
  }

  Widget _textField(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      readOnly: readOnly,
      focusNode: focusNode,
      autofocus: autofocus,
      controller: controller,
      onTap: onTap,
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        suffix: suffix,
        suffixIcon: suffixIcon,
        prefix: prefix,
        prefixIcon: prefixIcon,
        hintText: hintText?.tr(),
        hintStyle: theme.textTheme.bodyMedium,
        label: label,
        labelText: labelText?.tr(),
        labelStyle: theme.textTheme.bodyMedium,
      ),
    );
  }
}
