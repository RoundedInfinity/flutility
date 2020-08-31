
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

  void confirmationDialog(
    BuildContext context, {
    String title,
    bool hasCancelButton = true,
    VoidCallback onCancel,
    String cancelButtonText = 'CANCEL',
    String confirmButtonText = 'OK',
    VoidCallback onConfirm,
    final ValueChanged<int> onChanged,
    final ValueChanged<int> onSubmitted,
    @required final List<String> options,
    int initialValue = 0,
  }) {
    int _radioValue = initialValue;

    void _radioValueChanged(int value) {
      _radioValue = value;
      if (onChanged != null) onChanged(value);
    }

    List<Widget> _scrollable(void Function(void Function()) setState) {
      return [
        Divider(),
        Container(
          height: 360,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(options[index]),
                leading: Radio(
                  value: index,
                  groupValue: _radioValue,
                  onChanged: (value) {
                    setState(() => _radioValueChanged(value));
                  },
                ),
              );
            },
          ),
        ),
        Divider(),
      ];
    }

    List<Widget> _solid(void Function(void Function()) setState) {
      return [
        ListView.builder(
          shrinkWrap: true,
          itemCount: options.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(options[index]),
              leading: Radio(
                value: index,
                groupValue: _radioValue,
                onChanged: (value) {
                  setState(() => _radioValueChanged(value));
                },
              ),
            );
          },
        ),
      ];
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title'),
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          content: StatefulBuilder(
            builder: (context, setState) {
              if (options == null || options == []) {
                log.logError(
                    'Options can\'t be null or empty',
                    options,
                    Exception(
                        'options for confirmationDialog was called on null'));
                return Container();
              } else
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: options.length >= 7
                      ? _scrollable(setState)
                      : _solid(setState),
                );
            },
          ),
          actions: [
            hasCancelButton
                ? TextButton(
                    child: Text(cancelButtonText),
                    onPressed: () {
                      if (onCancel != null) onCancel();

                      Navigator.of(context).pop();
                    },
                  )
                : null,
            TextButton(
              child: Text(confirmButtonText),
              onPressed: () {
                if (onSubmitted != null) onSubmitted(_radioValue);

                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void alertDialog(
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
      list.add(TextButton(
        child: Text("CLOSE"),
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
