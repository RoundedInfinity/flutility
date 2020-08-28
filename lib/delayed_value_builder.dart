import 'package:flutter/widgets.dart';

typedef DelayBuilder = Widget Function(BuildContext context, dynamic value);

class DelayedValueBuilder extends StatefulWidget {
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
