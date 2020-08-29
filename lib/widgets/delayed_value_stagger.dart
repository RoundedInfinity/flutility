import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'delayed_value_builder.dart';

typedef DelayListBuilder = List<Widget> Function(
    BuildContext context, dynamic value);

///A `ListView` that works like the delayed builder but has multiple widgets which are updated one after one.
///
///__Example__:
///```
///DelayedValueStagger(
///   value: animate,
///   shrinkWrap: true,
///   duration: Duration(milliseconds: 200),
///   builder: (context, value) => [
///     Text('$value'),
///     Text('$value'),
///     Text('$value'),
///     Text('$value'),
///  ],
/// ),
/// 
///```

class DelayedValueStagger extends StatefulWidget {
  final DelayListBuilder builder;
  /// For multiple values you can pass a `List`.
  final value;
  final Duration duration;

  final Axis scrollDirection;
  final bool reverse;

  final bool primary;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry padding;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double cacheExtent;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  const DelayedValueStagger({
    Key key,
    @required this.builder,
    @required this.value,
    this.duration = const Duration(milliseconds: 200),
    this.primary,
    this.physics,
    this.padding,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior,
    this.reverse = false,
    this.shrinkWrap = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);
  @override
  _DelayedValueStaggerState createState() => _DelayedValueStaggerState();
}

class _DelayedValueStaggerState extends State<DelayedValueStagger> {
  List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: widget.shrinkWrap,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      cacheExtent: widget.cacheExtent,
      dragStartBehavior: widget.dragStartBehavior,
      padding: widget.padding,
      physics: widget.physics,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      primary: widget.primary,
      scrollDirection: widget.scrollDirection,
      itemCount: widget.builder(context, widget.value).length,
      itemBuilder: (context, index) {
        return DelayedValueBuilder(
          builder: (context, value) => widget.builder(context, value)[index],
          value: widget.value,
          delay: widget.duration * index,
        );
      },
    );
  }
}
