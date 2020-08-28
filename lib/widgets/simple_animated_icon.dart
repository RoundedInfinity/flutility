import 'package:flutter/material.dart';

///An Animated Icon controlled by a `bool`. [animate] and [icon] can't be null. [duration] is normally 200 milliseconds.
class SimpleAnimatedIcon extends StatefulWidget {
  final bool animate;
  final AnimatedIconData icon;
  final Duration duration;
  final Color color;
  final double size;

  const SimpleAnimatedIcon({
    Key key,
    @required this.animate,
    @required this.icon,
    this.duration = const Duration(milliseconds: 200),
    this.color,
    this.size,
  }) : super(key: key);
  @override
  _SimpleAnimatedIconState createState() => _SimpleAnimatedIconState();
}

class _SimpleAnimatedIconState extends State<SimpleAnimatedIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> fadeIn;
  Animation<double> fadeOut;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.duration,
    );
    var fadeInTween = Tween<double>(begin: 0, end: 1);
    var fadeOutTween = Tween<double>(begin: 1, end: 0);
    fadeIn = fadeInTween.animate(_controller);
    fadeOut = fadeOutTween.animate(_controller);
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
    return AnimatedIcon(
      icon: widget.icon,
      color: widget.color ?? Theme.of(context).iconTheme.color,
      size: widget.size ?? Theme.of(context).iconTheme.size,
      progress: _controller,
    );
  }
}
