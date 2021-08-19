import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 渐变色按钮
class GradientButton extends StatelessWidget {

  final List<Color> colors;// 渐变色数组
  // 按钮宽高
  final double? width;
  final double? height;

  final Widget child;
  final BorderRadius? borderRadius;

  final Color splashColor;// 水波颜色

  // 点击回调
  final GestureTapCallback onPressed;

  GradientButton({
    required this.colors,
    required this.splashColor,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height,
    });

  @override
  Widget build(BuildContext context) {

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: borderRadius,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: splashColor,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultTextStyle(
                style: TextStyle(fontWeight: FontWeight.bold),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 混合颜色
  static Color mixColors(List<Color> colors)
  {
    int r = 0, g = 0, b = 0, a = 0;
    for (Color color in colors)
    {
      r += color.red;
      g += color.green;
      b += color.blue;
      a += color.alpha;
    }

    return Color.fromARGB(a ~/ colors.length, r ~/ colors.length, g ~/ colors.length, b ~/ colors.length);
  }
}
