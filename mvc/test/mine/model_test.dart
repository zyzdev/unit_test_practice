import 'package:misc/model/user_detail.dart';
import 'package:misc/util/dio_util.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvc/mine/model.dart';
import 'package:test/test.dart';

import '../user_detail/model_test.mocks.dart';

@GenerateMocks([DioUtil])
void main() {
  group("fetch mine data", () {
    MockDioUtil? mockDioUtil;
    setUp(() {
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
      final data = UserDetail.fromJson(await model.fetchMineDetail());
      expect(data, isA<UserDetail>());
    });
  });
}
