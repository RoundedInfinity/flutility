import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'logger.dart';

class StaggeredListView extends StatefulWidget {
  final List<Widget> children;

  const StaggeredListView({Key key, this.children}) : super(key: key);
  @override
  SstaggeredStateListView createState() => SstaggeredStateListView();
}

class SstaggeredStateListView extends State<StaggeredListView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.children.length,
      itemBuilder: (context, index) {
        return Container();
      },
    );
  }
}



