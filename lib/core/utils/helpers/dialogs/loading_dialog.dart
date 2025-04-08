import 'package:flutter/material.dart';

import '/core/_core.dart' show BuildContextExtensions;

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: Container(
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: context.theme.colorScheme.inversePrimary,
                    width: 2,
                  ),
                ),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      );
    },
  );
}
