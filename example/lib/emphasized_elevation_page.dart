import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutility/flutility.dart';

class TransitionPage extends StatefulWidget {
  @override
  _TransitionPageState createState() => _TransitionPageState();
}

class _TransitionPageState extends State<TransitionPage> {
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
      body: EmphasizedElevationBody(
        
        animate: animate,
        child: ListView(
          children: [
            ListTile(
              title: Text('Hello'),
              subtitle: Text('there'),
            ),
            ListTile(
              title: Text('Hello'),
              subtitle: Text('there'),
            ),
            ListTile(
              title: Text('Hello'),
              subtitle: Text('there'),
            ),
            ListTile(
              title: Text('Hello'),
              subtitle: Text('there'),
            ),
            ListTile(
              title: Text('Hello'),
              subtitle: Text('there'),
            ),
            OpenContainer(
              closedBuilder: (context, action) => ListTile(
                title: Text('Hello'),
                subtitle: Text('there'),
                onTap: () async {
                  setState(() {
                    animate = true;
                  });
                  action();
                  await Future.delayed(Duration(milliseconds: 700));
                  setState(() {
                    animate = false;
                  });
                },
              ),
              openBuilder: (context, action) => _AnotherPage(),
            )
          ],
        ),
      ),
    ));
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
