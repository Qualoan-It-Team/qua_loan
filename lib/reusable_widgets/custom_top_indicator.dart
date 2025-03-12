import 'package:flutter/material.dart';
import 'package:qualoan/constants/app_colors.dart';

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
      ..color = AppColors.orangeLogoColor
      // const Color.fromARGB(255, 191, 190, 190)
      ..strokeWidth = 4
      ..isAntiAlias = true;
    canvas.drawLine(offset, Offset(cfg.size!.width + offset.dx, 0), _paint);
  }
}
