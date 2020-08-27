import 'package:flutter/material.dart';
import 'package:flutter_util/flutter_util.dart';

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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HomePage')),
      body: Column(
        children: [
          RaisedButton(
              onPressed: () {
                Logger logger = Logger(name: 'Dieter the logger');
                logger.log('Hello there!');
                
              },
              child: Text('Hello logger'))
        ],
      ),
    );
  }
}
