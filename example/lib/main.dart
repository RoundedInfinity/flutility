import 'package:flutter/material.dart';
import 'package:flutility/flutility.dart';

import 'app_bar_page.dart';
import 'emphasized_elevation_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool animate = false;

  //Using the logger
  void useLogger() {
    Logger logger = Logger(name: 'Dieter the logger');
    logger.log('Hello there!');

    logger.logInfo('This is a info message');

    var list = ['hello', 'there'];
    logger.logRich(list, 'This is a rich message');
  }

//Controlls the animation bool
  void setAnimation() {
    setState(() {
      animate = !animate;
    });
  }

  Widget _simpleAnimatedIcon() => SimpleAnimatedIcon(
        animate: animate,
        icon: AnimatedIcons.play_pause,
      );

  Widget _scaleItemSwitch() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleIconSwitch(
            animate: animate,
            duration: Duration(milliseconds: 1000),
            firstIcon: Icon(Icons.share_outlined, size: 40),
            secondIcon: Icon(
              Icons.delete_outline,
              size: 40,
            ),
            // giving the icons a on pressed function so they are not in the disabled state.
            onFirstPressed: () {},
            onSecondPressed: () {},
          ),
          //Just lets the icon disappear
          ScaleIconSwitch(
            animate: animate,
            firstIcon: Icon(Icons.add_a_photo_outlined),

            // giving the icons a on pressed function so they are not in the disabled state.
            onFirstPressed: () {},
          ),
        ],
      );

  Widget _itemStagger() => Container(
        height: MediaQuery.of(context).size.height * 0.1,
        child: DelayedValueStagger(
          value: animate,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          duration: Duration(milliseconds: 100),
          builder: (context, value) => [
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              child: ScaleIconSwitch(
                animate: value,
                firstIcon: Icon(Icons.share_outlined),
                secondIcon: Icon(Icons.delete_outline),
                // giving the icons a on pressed function so they are not in the disabled state.
                onFirstPressed: () {},
                onSecondPressed: () {},
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              child: ScaleIconSwitch(
                animate: value,
                firstIcon: Icon(Icons.share_outlined),
                secondIcon: Icon(Icons.delete_outline),
                // giving the icons a on pressed function so they are not in the disabled state.
                onFirstPressed: () {},
                onSecondPressed: () {},
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              child: ScaleIconSwitch(
                animate: value,
                firstIcon: Icon(Icons.share_outlined),
                secondIcon: Icon(Icons.delete_outline),
                // giving the icons a on pressed function so they are not in the disabled state.
                onFirstPressed: () {},
                onSecondPressed: () {},
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HomePage')),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              onPressed: setAnimation,
              child: Text('Animate it'),
            ),
            Text('Simple animated icon'),
            _simpleAnimatedIcon(),
            Text('ScaleIconSwitch'),
            _scaleItemSwitch(),
            RaisedButton(
              onPressed: useLogger,
              child: Text('Hello logger'),
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AppBarPage())),
              child: Text('Advanced example'),
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => TransitionPage())),
              child: Text('Transition example'),
            ),
            Text('Delayed builder'),
            Center(
              child: DelayedValueBuilder(
                builder: (context, value) => AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  color: value ? Colors.green : Colors.black,
                  height: 40,
                  width: 40,
                ),
                value: animate,
                delay: Duration(milliseconds: 700),
              ),
            ),
            Text('Delayed item stagger'),
            _itemStagger()
          ],
        ),
      ),
    );
  }
}
