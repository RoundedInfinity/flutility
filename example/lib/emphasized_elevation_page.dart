import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutility/flutility.dart';

class TransitionPage extends StatefulWidget {
  @override
  _TransitionPageState createState() => _TransitionPageState();
}

class _TransitionPageState extends State<TransitionPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation<double> scale;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      reverseDuration: Duration(milliseconds: 200),
    );
    var scaleTween = Tween<double>(begin: 0, end: 1);

    scale = scaleTween.animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool animate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text('Hey'),
          )
        ],
        body: DelayedValueStagger(
          value: scale,
          builder: (context, value) {
            return [
              AnimatedBuilder(
                animation: value,
                builder: (context, child) {
                  
                  return FadeTransition(
                  opacity: value,
                  child: ListTile(
                    title: Text('$value'),
                    subtitle: Text('there'),
                  ),
                );
                },
              ),
              ListTile(
                title: Text('Hello'),
                subtitle: Text('there'),
                onTap: () => scale.value == 1
                    ? _controller.reverse()
                    : _controller.forward(),
              ),
            ];
          },
        ),
      ),
    );
  }
}

class _AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text('Hey'),
          )
        ],
        body: Center(
          child: Text('Hey'),
        ),
      ),
    );
  }
}
