import 'package:misc/misc.dart';
import 'package:misc/util/dio_util.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvc/user_list/model.dart';
import 'package:test/test.dart';

import 'model_test.mocks.dart';

@GenerateMocks([DioUtil])
void main() {
  group("fetch user list data", () {
    MockDioUtil? mockDioUtil;
    setUp(() {
      mockDioUtil = MockDioUtil();
      DioUtil.setDioUtil(mockDioUtil!);
    });

    final model = Model();

    test("return a user list data.", () async {
      when(mockDioUtil?.get(
        Api.users,
      )).thenAnswer((realInvocation) {
        return Future.value([UserOverview().toJson()]);
      });
      final test = model.convert(await model.fetchUserList());
      expect(test, const TypeMatcher<Iterable<UserOverview>>());
    });
  });
}
