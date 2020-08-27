import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


///Use this for a cool ripple effect. [Like this](https://kstatic.googleusercontent.com/files/c91a5e469e9cf95ea723487f8992d66c5cd26619e3296da4c83d4aa19060e654c9c658f427e149c809afe7cd02eee31c6847628c5f43010adbc4ccb8f550202c)
class RippleAnimation extends StatefulWidget {
  final bool animate;
  final double height, offsetX, offsetY;
  final Color rippleColor, backgroundColor;
  final Duration duration;

  const RippleAnimation(
      {Key key,
      @required this.animate,
      this.height = 100,
      this.offsetX,
      this.offsetY,
      this.rippleColor = Colors.blue,
      this.backgroundColor = Colors.transparent, this.duration = const Duration(milliseconds: 200)})
      : super(key: key);
  @override
  _RippleAnimationState createState() => _RippleAnimationState();
}

class _RippleAnimationState extends State<RippleAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation _animation;

  @override
  initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (!widget.animate) {
      _controller.reverse();
    } else if (widget.animate) _controller.forward();
    return AnimatedContainer(
      color: widget.backgroundColor,
      height: widget.height,
      width: screenWidth,
      duration: Duration(milliseconds: 200),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: RipplePaint(
              color: widget.rippleColor,
              containerHeight: widget.height,
              center: Offset(widget.offsetX ?? 0, widget.offsetY ?? 0),
              radius: _animation.value * screenWidth * 1.5,
              context: context,
            ),
          );
        },
      ),
    );
  }
}

class RipplePaint extends CustomPainter {
  final Offset center;
  final double radius, containerHeight;
  final BuildContext context;

  Color color;
  double statusBarHeight, screenWidth;

  RipplePaint(
      {this.context,
      this.containerHeight,
      this.center,
      this.radius,
      this.color}) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePainter = Paint();

    circlePainter.color = color;
    canvas.clipRect(
        Rect.fromLTWH(0, 0, screenWidth, containerHeight + statusBarHeight));
    canvas.drawCircle(center, radius, circlePainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
