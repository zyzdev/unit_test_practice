import 'package:misc/model/user_detail.dart';
import 'package:misc/util/dio_util.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvc/user_detail/model.dart';
import 'package:test/test.dart';

import 'model_test.mocks.dart';

@GenerateMocks([DioUtil])
void main() {
  group("fetch user detail data.", () {
    MockDioUtil? mockDioUtil;
    setUp(() {
      mockDioUtil = MockDioUtil();
      DioUtil.setDioUtil(mockDioUtil!);
    });

    final model = Model();
    test("return user detail data", () async {
      when(mockDioUtil?.get(Api.users, path: "test"))
          .thenAnswer((realInvocation) => Future.value(UserDetail().toJson()));
      expectLater(UserDetail.fromJson(model.fetchUserDetail("test")),
          isA<UserDetail>());
    });
  });
}
