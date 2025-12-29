import 'package:flutter_test/flutter_test.dart';
import 'package:glory_vansales_app/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('DevDebugViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
