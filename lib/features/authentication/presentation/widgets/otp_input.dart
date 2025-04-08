import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart' show BuildContextExtensions, ISendEmailOtpService, sl;
import '/features/_features.dart'
    show CreateNewPasswordScreen, ForgotPasswordCubit, ForgotPasswordParams;

class OTPInput extends StatefulWidget {
  const OTPInput({super.key, required this.email});

  final String email;

  @override
  State<OTPInput> createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  final int length = 4;
  late List<FocusNode> focusNodes;
  late List<TextEditingController> controllers;
  Color? borderColor;

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

  // Compare OTP with the one sent to the user
  bool verifyOTP(String otp) {
    final otpService = sl<ISendEmailOtpService>();
    return otpService.verifyEmailOTP(otp: otp);
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
              color:
                  borderColor ??
                  context.theme.colorScheme.secondary.withValues(alpha: 0.40),
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
            style: context.textTheme.bodyLarge?.copyWith(
              fontSize: 20,
              color: context.theme.colorScheme.primary,
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                if (i < length - 1) {
                  FocusScope.of(context).requestFocus(focusNodes[i + 1]);
                } else {
                  // Verify the OTP
                  final otpCode = controllers.map((e) => e.text).join();
                  if (verifyOTP(otpCode)) {
                    borderColor = Colors.green;

                    // Navigate to the next screen
                    context.push(
                      CreateNewPasswordScreen.routeName,
                      extra: {'email': widget.email},
                    );

                    // Send the TOKEN via API to user email
                    context.read<ForgotPasswordCubit>().forgotPassword(
                      params: ForgotPasswordParams(email: widget.email),
                    );
                  } else {
                    borderColor = context.theme.colorScheme.error;
                  }

                  focusNodes[i].unfocus(); // Final field
                }
              } else {
                borderColor = null;
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
