import 'package:bloc_pattern/user_list/model.dart';
import 'package:misc/model/user_overview.dart';
import 'package:misc/util/dio_util.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'model_test.mocks.dart';

@GenerateMocks([DioUtil])
void main() {
  group("test model of user list", () {
    MockDioUtil? mockDioUtil;
    setUp(() {
      mockDioUtil = null;
      mockDioUtil = MockDioUtil();
      DioUtil.setDioUtil(mockDioUtil!);
    });

    final model = Model();
    test("return user list data", () async {
      when(mockDioUtil?.get(Api.users)).thenAnswer((realInvocation) {
        return Future.value([UserOverview().toJson()]);
      });
      final data = model.convert(await model.fetchUserList());
      expect(data, isA<Iterable<UserOverview>>());
    });
  });
}
