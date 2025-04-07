import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPInput extends StatefulWidget {
  const OTPInput({super.key});

  @override
  State<OTPInput> createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  final int length = 4;
  late List<FocusNode> focusNodes;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(length, (_) => FocusNode());
    controllers = List.generate(length, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (final node in focusNodes) {
      node.dispose();
    }
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (i) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 56,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.secondary.withValues(alpha: 0.40),
            ),
          ),
          child: TextFormField(
            controller: controllers[i],
            focusNode: focusNodes[i],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                if (i < length - 1) {
                  FocusScope.of(context).requestFocus(focusNodes[i + 1]);
                } else {
                  focusNodes[i].unfocus(); // Final field
                }
              } else {
                if (i > 0) {
                  FocusScope.of(context).requestFocus(focusNodes[i - 1]);
                }
              }
            },
          ),
        );
      }),
    );
  }
}
