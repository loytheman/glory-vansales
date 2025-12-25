import 'package:flutter_test/flutter_test.dart';
import 'package:m360_app_corpsec/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('AccountViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
