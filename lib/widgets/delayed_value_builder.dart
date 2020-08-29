import 'package:flutter/widgets.dart';

typedef DelayBuilder = Widget Function(BuildContext context, dynamic value);

///This widget updates a [value] for his child after a [delay]. Useful if you want to delay values for Foo animations.
///
///Give the `DelayedValueBuilder` a value.
///Then you can access the delayed value in the builder. When you call `setState` the [value] in the builder will be updated after the [delay].
///
///__Example__:
///
///```
///DelayedValueBuilder(
///  builder: (context, value) => AnimatedContainer(
///    duration: Duration(milliseconds: 200),
///    color: value ? Colors.green : Colors.black,
///    height: 40,
///    width: 40,
///  ),
///  value: animate,
///  delay: Duration(milliseconds: 700),
///),
///```
class DelayedValueBuilder extends StatefulWidget {
  /// For multiple values you can pass a `List`.
  final value;
  final DelayBuilder builder;
  final Duration delay;

  const DelayedValueBuilder(
      {Key key,
      @required this.value,
      @required this.builder,
      this.delay = const Duration(milliseconds: 200)})
      : super(key: key);
  @override
  _DelayedValueBuilderState createState() => _DelayedValueBuilderState();
}

class _DelayedValueBuilderState extends State<DelayedValueBuilder> {
  ValueNotifier listenableValue = ValueNotifier(false);

  @override
  void didUpdateWidget(DelayedValueBuilder oldWidget) {
    update();
    super.didUpdateWidget(oldWidget);
  }

  update() async {
    await Future.delayed(widget.delay);
    listenableValue = ValueNotifier(widget.value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: listenableValue,
      builder: (context, value, child) {
        return widget.builder(context, value);
      },
    );
  }
}
