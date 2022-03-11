import 'package:bloc_pattern/user_detail/model.dart';
import 'package:misc/model/user_detail.dart';
import 'package:misc/util/dio_util.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'model_test.mocks.dart';

@GenerateMocks([DioUtil])
void main() {
  group("test user detail data", () {
    MockDioUtil? mockDioUtil;
    setUp(() {
      mockDioUtil = null;
      mockDioUtil = MockDioUtil();
      DioUtil.setDioUtil(mockDioUtil!);
    });

    test("return user detail data", () async {
      when(mockDioUtil?.get(Api.users, path: "test")).thenAnswer(
          (realInvocation) => Future.value(UserDetail(login: "test").toJson()));

      final model = Model();
      final data = UserDetail.fromJson(await model.fetchUserDetail("test"));
      expect(data, isA<UserDetail>());
    });
  });
}
