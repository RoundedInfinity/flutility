import 'package:flutter/material.dart';

class EmphasizedElevationBody extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool animate;
  final double shrinkSize;

  const EmphasizedElevationBody(
      {Key key,
      this.duration = const Duration(milliseconds: 200),
      this.shrinkSize = 0.7,
      @required this.child,
      this.animate = false})
      : super(key: key);
  @override
  _EmphasizedElevationBodyState createState() =>
      _EmphasizedElevationBodyState();
}

class _EmphasizedElevationBodyState extends State<EmphasizedElevationBody>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation<double> scale;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.duration,
    );
    var scaleTween = Tween<double>(begin: 1, end: 0.5);

    scale = scaleTween.animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.animate) {
      _controller.reverse();
    } else if (widget.animate) _controller.forward();
    return ScaleTransition(
      child: widget.child,
      scale: scale,
    );
  }
}
