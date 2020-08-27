import 'package:flutter/material.dart';

import 'package:flutter_util/flutter_util.dart';

class AppBarPage extends StatefulWidget {
  @override
  _AppBarPageState createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  bool animate = false;

  @override
  Widget build(BuildContext context) {
    Widget _appBar() => SliverAppBar(
          pinned: true,
          title: Text(
            animate ? '1 item selected' : 'Advanced exaple',
            style: TextStyle(color: animate ? Colors.white : Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: Center(
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (animate) animate = false;
                });
              },
              icon: SimpleAnimatedIcon(
                animate: animate,
                color: animate ? Colors.white : Colors.black,
                icon: AnimatedIcons.menu_close,
              ),
            ),
          ),
          actions: [
            ScaleIconSwitch(
              animate: animate,
              secondIcon: Icon(
                Icons.share_outlined,
                color: Colors.white,
              ),
              onSecondPressed: () {},
            ),
            ScaleIconSwitch(
              animate: animate,
              firstIcon: Icon(Icons.info_outline_rounded, color: Colors.black),
              secondIcon: Icon(
                Icons.delete_outline_outlined,
                color: Colors.white,
              ),
              onFirstPressed: () {},
              onSecondPressed: () {},
            ),
          ],
          flexibleSpace: Container(
            child: RippleAnimation(
              animate: animate,
              duration: Duration(milliseconds: 260),
              offsetY: 90,
              offsetX: 40,
              rippleColor: Colors.deepPurpleAccent[400],
              backgroundColor: Colors.white,
              height: 56,
            ),
          ),
        );

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [_appBar()],
        body: Column(
          children: [
            CheckboxListTile(
              activeColor: Colors.deepPurpleAccent[400],
              value: animate,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text('Something you can select'),
              subtitle: Text('For a cool effect'),
              onChanged: (bool value) {
                setState(
                  () {
                    animate = value;
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
