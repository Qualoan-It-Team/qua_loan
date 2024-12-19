import 'package:app_here/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TopIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TopIndicatorBox();
  }
}
class _TopIndicatorBox extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    Paint _paint = Paint()
      // ..color = AppColors.logoRedColor
      ..color = AppColors.green
      // const Color.fromARGB(255, 191, 190, 190)
      ..strokeWidth = 5
      ..isAntiAlias = true;
    canvas.drawLine(offset, Offset(cfg.size!.width + offset.dx, 0), _paint);
  }
}
