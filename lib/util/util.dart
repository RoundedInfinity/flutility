import 'package:flutter/material.dart';

import 'logger.dart';

class Utility {
  Logger log = Logger();
  bool _snackVisible = false;

  void snackbar(
    String text, {
    SnackBarAction action,
    bool floating = false,
    BuildContext context,
    Duration duration = const Duration(seconds: 4),
    GlobalKey<ScaffoldState> key,
  }) {
    final snackBar = SnackBar(
      content: Text(text),
      action: action,
      duration: duration,
      behavior: floating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
    );
    if (key == null && context == null) {
      log.logError(
          'key and context can\'t be both null. Prefere context over global key',
          [context, key],
          Exception('key and context can\'t be both null'));
    }
    key != null
        ? key.currentState.showSnackBar(snackBar)
        : Scaffold.of(context).showSnackBar(snackBar);
  }

  void noStackSnackbar(
    String text, {
    SnackBarAction action,
    bool floating = false,
    BuildContext context,
    Duration duration = const Duration(seconds: 4),
    GlobalKey<ScaffoldState> key,
  }) {
    if (!_snackVisible) {
      snackbar(
        text,
        action: action,
        floating: floating,
        context: context,
        duration: duration,
      );
      _disableSnackbar(duration);
    }
  }

  void _disableSnackbar(Duration duration) async {
    if (!_snackVisible) {
      _snackVisible = true;
      await Future.delayed(duration);
      _snackVisible = false;
    }
  }

  void simpleDialog(
    BuildContext context, {
    String title,
    String content,
    bool hasCloseButton = true,
    VoidCallback onClose,
    List<Widget> actions,
  }) {
    List<Widget> list = [];

    if (actions != null) list.addAll(actions);

    if (hasCloseButton)
      list.add(FlatButton(
        child: Text("Close"),
        onPressed: () {
          if (onClose != null) onClose();

          Navigator.of(context).pop();
        },
      ));
      
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title'),
          content: Text('$content'),
          actions: list,
        );
      },
    );
  }
}
