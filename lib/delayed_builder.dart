import 'package:flutter/widgets.dart';

typedef _DelayBuilder = Widget Function(BuildContext context, dynamic value);

class DelayedBuilder extends StatefulWidget {
  final value;
  final _DelayBuilder builder;
  final Duration delay;

  const DelayedBuilder(
      {Key key,
      @required this.value,
      @required this.builder,
      this.delay = const Duration(milliseconds: 200)})
      : super(key: key);
  @override
  _DelayedBuilderState createState() => _DelayedBuilderState();
}

class _DelayedBuilderState extends State<DelayedBuilder> {
  ValueNotifier listenableValue = ValueNotifier(false);

  @override
  void didUpdateWidget(DelayedBuilder oldWidget) {
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
