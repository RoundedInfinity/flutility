import 'package:flutter/material.dart';
import 'package:flutilitiy/flutter_util.dart';

import 'app_bar_page.dart';

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
            firstIcon: Icon(Icons.share_outlined),
            secondIcon: Icon(Icons.delete_outline),
            // giving the icons a on pressed function so they are not in the disabled state.
            onFirstPressed: () {},
            onSecondPressed: () {},
          ),
          //Just lets the icon disappear
          ScaleIconSwitch(
            animate: animate, duration: Duration(milliseconds: 500),
            firstIcon: Icon(Icons.add_a_photo_outlined),

            // giving the icons a on pressed function so they are not in the disabled state.
            onFirstPressed: () {},
          ),
        ],
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
          ],
        ),
      ),
    );
  }
}
