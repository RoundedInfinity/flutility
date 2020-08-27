import 'package:flutter_test/flutter_test.dart';

import 'package:flutility/flutter_util.dart';

void main() {
  test('logger name', () {
    final logger = Logger(name: 'Bob');
    expect(logger.name, 'Bob');
  });
}
