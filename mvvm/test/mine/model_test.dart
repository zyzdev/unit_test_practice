import 'package:misc/model/user_detail.dart';
import 'package:misc/util/dio_util.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvvm/mine/model.dart';
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
    test("return mine data", () async {
      String tmp =
          "LDF8y3sWUhSA3aI1tMyAFLr38jWqw2HTrWHX_phg,Or7wOKfFQZTSmBL5L2oKpN2qxEQur2230izu"
              .split(",")[0];
      String token = tmp.split('').reversed.join();
      when(mockDioUtil
              ?.get(Api.user, header: {"Authorization": "token $token"}))
          .thenAnswer((realInvocation) {
        return Future.value(UserDetail(login: "test").toJson());
      });
      final data = await model.getMineDetail();
      expect(data, isA<UserDetail>());
    });
  });
}
