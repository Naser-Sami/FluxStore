import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension AnimatedWidgetX on Widget {
  Widget scaleAnimation({
    Duration duration = const Duration(milliseconds: 600),
    Curve curve = Curves.easeInOut,
    Offset scaleBegin = const Offset(2.0, 2.0),
    Offset scaleEnd = const Offset(1.0, 1.0),
  }) {
    return SizedBox(child: this)
        .animate()
        .fade(duration: duration, curve: curve)
        .scale(
          begin: scaleBegin,
          end: scaleEnd,
          duration: duration,
          curve: curve,
        );
  }
}
