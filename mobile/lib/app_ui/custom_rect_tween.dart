import 'dart:ui';

import 'package:flutter/widgets.dart';

/// {@template custom_rect_tween}
/// Linear RectTween with a [Curves.easeOut] curve.
///
/// Less dramatic that the regular [RectTween] used in [Hero] animations.
/// {@endtemplate}
class CustomRectTween extends RectTween {
  /// {@macro custom_rect_tween}
  CustomRectTween({
    required Rect begin,
    required Rect end,
  }) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final elasticCurveValue = Curves.easeOut.transform(t);
    return Rect.fromLTRB(
      lerpDouble(begin?.left ?? 0.0, end?.left ?? 0.0, elasticCurveValue)!,
      lerpDouble(begin?.top ?? 0.0, end?.top ?? 0.0, elasticCurveValue)!,
      lerpDouble(begin?.right ?? 0.0, end?.right ?? 0.0, elasticCurveValue)!,
      lerpDouble(begin?.bottom ?? 0.0, end?.bottom ?? 0.0, elasticCurveValue)!,
    );
  }
}
