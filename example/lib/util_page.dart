import 'package:flutter/material.dart';

import 'package:flutility/util/util.dart';

class UtilPage extends StatefulWidget {
  @override
  _UtilPageState createState() => _UtilPageState();
}

class _UtilPageState extends State<UtilPage> {
  var util = Utility();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Util Examples'),
      ),
      body: Center(
        child: Column(
          children: [
            Builder(
              builder: (context) => Column(
                children: [
                  RaisedButton(
                    child: Text('snackbar'),
                    onPressed: () {
                      util.snackbar('Hello there', context: context,floating: true);
                    },
                  ),
                  RaisedButton(
                    child: Text('no stack snackbar'),
                    onPressed: () {
                      util.noStackSnackbar('Hello there once',
                          context: context);
                    },
                  ),
                  RaisedButton(
                    child: Text('alert dialog'),
                    onPressed: () {
                      //util.noStackSnackbar('Hello there', context: context);

                      util.alertDialog(
                        context,
                        title: 'Hello there',
                        content: 'Want to say hi?',
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {},
                          )
                        ],
                      );
                    },
                  ),
                  Text('Confirmation Dialog'),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        child: Text('few choices'),
                        onPressed: () {
                          //util.noStackSnackbar('Hello there', context: context);

                          util.confirmationDialog(
                            context,
                            onChanged: (value) => print(value),
                            onSubmitted: (value) => print(value),
                            title: 'Hellooo',
                            initialValue: null,
                            options: [
                              'Choise here',
                              'Choise there',
                              'Choise everywhere',
                            ],
                          );
                        },
                      ),
                      RaisedButton(
                        child: Text('many choices'),
                        onPressed: () {
                          //util.noStackSnackbar('Hello there', context: context);

                          util.confirmationDialog(
                            context,
                            onChanged: (value) => print(value),
                            onSubmitted: (value) => print(value),
                            title: 'Hellooo',
                            initialValue: null,
                            options: [
                              'Choise 1',
                              'Choise 2',
                              'Choise 3',
                              'Choise 4',
                              'Choise 5',
                              'Choise 6',
                              'Choise 7',
                            ],
                          );
                        },
                      ),
                      PopupMenuButton<String>(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'Hello',
                            child: Text(
                              "English",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
