///A [Logger] to display colorful and named logs.
///
///__Expample__:
///```
///Logger logger = Logger(name: 'Logan the logger');
///
///logger.log('Hello there');
///```
class Logger {
  ///The Logger [name] is displayed in front of every message.
  String name;

  ///If this Logger should print colored logs. Defaults to `true`.
  final bool colored;
  Logger({
    this.name = "Logger",
    this.colored = true,
  });

  String get _textColor => colored ? '\x1B[38;2;190;190;160m' : '';
  String get _nameColor => colored ? '\x1B[33m' : '';
  String get _infoColor => colored ? '\x1B[96;1m' : '';
  String get _errorColor => '\x1B[91;1m';

  void log(var message) {
    print(
      _nameColor + '[$name]' + '\x1B[0m ' + _textColor + message.toString(),
    );
  }

  void logInfo(var message) {
    print(
      _infoColor + '[$name]' + '\x1B[0m ' + _textColor + message.toString(),
    );
  }

  ///Rich logs also include runtime Types.
  void logRich(var message, [String description]) {
    print(_nameColor + '< ℹ $name - $description >' + '\x1B[0m ');
    print(_textColor + 'message: ${message.toString()}');
    print(_textColor + 'runtimeType: ${message.runtimeType.toString()}');
  }

  ///Prints an error message. If [exception] is given it will also throw an exception.
  void logError(var message, [var error, Exception exception]) {
    print(
      _errorColor + '[⚠ $name]' + '\x1B[0m ' + _errorColor + message.toString(),
    );
    if (error != null) print(_errorColor + error.toString());
    if (exception != null) throw exception;
  }
}
