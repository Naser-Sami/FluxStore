import 'package:flutter/material.dart';

import '/core/_core.dart' show BuildContextExtensions;

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    // barrierDismissible: false, // prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: context.theme.colorScheme.surface,
        elevation: 0,
        child: const SizedBox(
          height: 200,
          width: 100,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    },
  );
}
