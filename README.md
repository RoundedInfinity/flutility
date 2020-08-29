# Flutility

A collection of useful widgets, material widgets that totally should be included in flutter and other stuff. See how it works in the [examples](##Examples)

Material selection see [Advanced Example](#AdvancedExample)



## This package contains

- SimpleAnimatedIcon
- ScaleItemSwitch
- DelayValueBuilder
- DelayValueStagger
- Logger
- RippleAnimation

## Installation

Add the package to your `pubspec.yaml` file.

```[dart]
flutility: <Newest Version>
```

And then import it.

```[dart]
import 'package:flutility/flutility.dart';
```

## How to use it

### Bool controlled animation

Most of the animated widget in this package are controlled with a `bool`.
This makes simple animation a lot easier because you don't need a animation controller anymore.
Don't forget to call `setState` after changing the value.

```[dart]
bool animate = false;

void animateSomething() {
setState(()) {
animate = !animate;
}}
```


### ScaleItemSwitch

A widget to switch between two icons with the simple material icon transition. [Like the third transition here](https://kstatic.googleusercontent.com/files/b1f75f6411f22085feac9d957c977d65afc67c4850878bd4f4268f350e3eb3c500f7926fd207ea2c4453222cc6ce76f1ba8dc998c7f63e1bee5c629948d40518).

The animation is controlled by the [animate] value. [firstIcon] and [secondIcon] are properties in a `IconButton` so they should be some sort of icon.

If [firstIcon] or [secondIcon] are not set the other icon will just disappear.
Icons are in the disabled state if they don't have there VoidCallback set.

```[dart]

ScaleIconSwitch(
  animate: animate,
  firstIcon: Icon(Icons.delete_outline),
  secondIcon: Icon(Icons.share_outlined),
  onFirstPressed: switchIcon,
  onSecondPressed: switchIcon,
)
```

### Simple animated Icon

Just use a `bool` to control an animated icon.
And give it a `Duration` if you want.

```[dart]

SimpleAnimatedIcon(
        animate: animate,
        icon: AnimatedIcons.play_pause,
);
```
### Logger

Tired of reading all these grey boring logs? Try Logger!
Just create a logger somewhere in your code. You can give it a name if you want.

```[dart]
var logger = Logger(name: 'Logan the logger');
```

And now you can use it.

```[dart]
logger.log('Hello there');
```


## Example App

Example app that is using most of the features

<details markdown='1'><summary>show/hide</summary>

```[dart]
import 'package:flutter/material.dart';
import 'package:flutter_util/flutter_util.dart';

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

```

</details>




## Advanced Example

An App that uses the [material design select effect](https://material.io/design/interaction/selection.html#item-selection)

<details markdown='1'><summary>show/hide</summary>

```[dart]

import 'package:flutter/material.dart';

import 'package:flutter_util/flutter_util.dart';

class AppBarPage extends StatefulWidget {
  @override
  _AppBarPageState createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  //We are using a logger here
  Logger logger = Logger();
  //If the item is selected animate will be set to true.
  bool animate = false;

  @override
  Widget build(BuildContext context) {
    Widget _appBar() => SliverAppBar(
          pinned: true,

          title: Text(
            animate ? '1 item selected' : 'Advanced example',
            style: TextStyle(color: animate ? Colors.white : Colors.black),
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
            ScaleIconSwitch(
              animate: animate,
              secondIcon: Icon(
                Icons.share_outlined,
                color: Colors.white,
              ),
              onSecondPressed: () => logger.log('Share!'),
            ),
            ScaleIconSwitch(
              animate: animate,
              firstIcon: Icon(Icons.info_outline_rounded, color: Colors.black),
              secondIcon: Icon(
                Icons.delete_outline_outlined,
                color: Colors.white,
              ),
              onFirstPressed: () => logger.logInfo('Info!'),
              onSecondPressed: () => logger.log('Delete!'),
            ),
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
```


</details>
