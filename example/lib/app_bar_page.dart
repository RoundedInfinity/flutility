import 'package:flutter/material.dart';

import 'package:flutility/flutility.dart';

class AppBarPage extends StatefulWidget {
  @override
  _AppBarPageState createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  //We are using a logger here
  Logger logger = Logger();
  //If the item is selected animate animate will be set to true.
  bool animate = false;

  @override
  Widget build(BuildContext context) {
    Widget _appBar() => SliverAppBar(
          pinned: true,

          title: AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 200),
            child: Text(
              animate ? '1 item selected' : 'Advanced example',
            ),
            style: Theme.of(context).textTheme.headline6.copyWith(color: animate ? Colors.white : Colors.black87),
          ),

          backgroundColor: Colors.white,
          leading: Center(
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (animate) {
                    animate = false;
                    logger.log('Selection cancelled');
                  }
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
            DelayedValueStagger(
              value: animate,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              duration: Duration(milliseconds: 90),
              builder: (context, value) => [
                ScaleIconSwitch(
                  animate: value,
                  secondIcon: Icon(
                    Icons.share_outlined,
                    color: Colors.white,
                  ),
                  onSecondPressed: () => logger.log('Share!'),
                ),
                ScaleIconSwitch(
                  animate: value,
                  firstIcon:
                      Icon(Icons.info_outline_rounded, color: Colors.black),
                  secondIcon: Icon(
                    Icons.delete_outline_outlined,
                    color: Colors.white,
                  ),
                  onFirstPressed: () => logger.logInfo('Info!'),
                  onSecondPressed: () => logger.log('Delete!'),
                ),
              ],
            )
          ],
          //Put the RippleAnimation in the flexibleSpace
          flexibleSpace: Container(
            child: RippleAnimation(
              animate: animate,
              duration: Duration(milliseconds: 260),
              // Offset so it looks like it starts at the bottom
              offsetY: 90,
              offsetX: 40,
              rippleColor: Colors.deepPurpleAccent[400],
              //If backgroundColor is not set it will be set transparent
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
