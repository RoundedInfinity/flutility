import 'package:flutter/material.dart';

///A widget to switch between two icons with the simple material icon transition. [Like the third transition here](https://kstatic.googleusercontent.com/files/b1f75f6411f22085feac9d957c977d65afc67c4850878bd4f4268f350e3eb3c500f7926fd207ea2c4453222cc6ce76f1ba8dc998c7f63e1bee5c629948d40518).
///
///The animation is controlled by the [animate] value. [firstIcon] and [secondIcon] are properties in a `IconButton` so they should be some sort of icon.
///
///If [firstIcon] or [secondIcon] are not set the other icon will just disappear.
///Icons are in the disabled state if they don't have there VoidCallback set
///
///__Example__:
///```
///bool animate = false;
///
///void switchIcon() {
///setState(()) {
///animate = !animate;
///}}
///
///ScaleIconSwitch(
///  animate: animate,
///  firstIcon: Icon(Icons.delete_outline),
///  fsecondIcon: Icon(Icons.share_outlined),
///  onFirstPressed: switchIcon,
///  onSecondPressed: switchIcon,
///)
///```
class ScaleIconSwitch extends StatefulWidget {
  ///[animate] must not be null
  final bool animate;

  ///Typically a `icon`. If not set the other icon will just disappear.
  final Widget firstIcon, secondIcon;

  ///Normally this is 200ms.
  ///
  /// Thats the average icon animation duration specified in the material design guidelines
  final Duration duration;

  ///If you press one of the icons. Icons are in the disabled state if this is `null`.
  final VoidCallback onFirstPressed, onSecondPressed;

  const ScaleIconSwitch({
    Key key,
    @required this.animate,
    this.firstIcon,
    this.secondIcon,
    this.duration = const Duration(milliseconds: 200),
    this.onFirstPressed,
    this.onSecondPressed,
  }) : super(key: key);
  @override
  _ScaleIconSwitchState createState() => _ScaleIconSwitchState();
}

class _ScaleIconSwitchState extends State<ScaleIconSwitch> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.ease,
      switchOutCurve:
          widget.firstIcon != null ? Curves.easeInExpo : Curves.easeIn,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: IconButton(
        key: ValueKey(widget.animate),
        icon: widget.animate
            ? widget.secondIcon ?? Container()
            : widget.firstIcon ?? Container(),
        onPressed:
            widget.animate ? widget.onSecondPressed : widget.onFirstPressed,
      ),
      duration: widget.duration,
    );
  }
}
