import 'package:flutter/material.dart';

import '/core/_core.dart' show BuildContextExtensions;

class AddProfileImage extends StatelessWidget {
  const AddProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;

    return Center(
      child: SizedBox(
        width: 120,
        height: 120,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.surfaceContainerHighest,
              ),
              child: Icon(
                Icons.person,
                color: color.onSurface.withValues(alpha: 0.50),
                size: 50,
              ),
            ),
            Positioned(
              right: 5,
              bottom: 5,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: color.secondary,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    color: color.onSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
