import 'package:flutter_test/flutter_test.dart';

import 'package:hy_router/hy_router.dart';

void main() {
 test('getRouterName', () {
   final routerName = getRouterName<PageRouter>();
   expect(routerName, "PageRouter");
 });
}