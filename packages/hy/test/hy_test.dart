import 'package:test/test.dart';

import 'package:hy/hy.dart';

void main() {
  test('progress test', () {
    final a = InProgress<Result>();
    final b = InProgress<Result>();

    expect(a, b);
  });
}
