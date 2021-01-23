import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShapesPainter extends CustomPainter {
  final Color color;
  final double tailPercent;
  final bool inverseBookmark;
  final double borderRadius;
  final Color borderColor;

  ShapesPainter(
      {this.borderRadius,
      this.borderColor,
      this.color,
      this.tailPercent,
      this.inverseBookmark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderRadius
      ..color = borderColor;
    var path = Path();
    if (inverseBookmark) {
      path.lineTo(0, size.height);
      path.lineTo(size.width * 0.5, size.height * tailPercent);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    } else {
      path.lineTo(0, size.height * tailPercent);
      path.lineTo(size.width * 0.5, size.height);
      path.lineTo(size.width, size.height * tailPercent);
      path.lineTo(size.width, 0);
    }
    canvas.drawPath(path, line);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ShapesClipper extends CustomClipper<Path> {
  final double tailPercent;
  final bool inverseBookmark;

  ShapesClipper({this.tailPercent, this.inverseBookmark});

  @override
  Path getClip(Size size) {
    var path = Path();
    if (inverseBookmark) {
      path.lineTo(0, size.height);
      path.lineTo(size.width * 0.5, size.height * tailPercent);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    } else {
      path.lineTo(0, size.height * tailPercent);
      path.lineTo(size.width * 0.5, size.height);
      path.lineTo(size.width, size.height * tailPercent);
      path.lineTo(size.width, 0);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BookmarkShape extends StatelessWidget {
  Color color;
  final double height;
  final double width;
  final double tailPercent;
  final bool inverseBookmark;
  final double borderRadius;
  Color borderColor;
  final Widget child;

  BookmarkShape(
      {Key key,
      this.color,
      @required this.height,
      @required this.width,
      this.tailPercent = 0.8,
      this.inverseBookmark = true,
      this.borderRadius = 5.0,
      this.borderColor,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    color ??= Colors.red[700];
    borderColor ??= Colors.red[900];

    return ClipPath(
      clipper: ShapesClipper(
        tailPercent: tailPercent,
        inverseBookmark: inverseBookmark,
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: borderRadius, right: borderRadius, bottom: 2 * borderRadius),
        child: CustomPaint(
          painter: ShapesPainter(
              color: color,
              tailPercent: tailPercent,
              inverseBookmark: inverseBookmark,
              borderRadius: borderRadius,
              borderColor: borderColor),
          child: Container(
            height: height,
            width: width,
            child: child,
          ),
        ),
      ),
    );
  }
}
