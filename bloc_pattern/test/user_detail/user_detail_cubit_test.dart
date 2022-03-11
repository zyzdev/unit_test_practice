import 'package:bloc_pattern/user_detail/model.dart';
import 'package:bloc_pattern/user_detail/user_detail_cubit.dart';
import 'package:misc/model/user_detail.dart';
import 'package:misc/model/user_overview.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'user_detail_cubit_test.mocks.dart';

@GenerateMocks([Model])
void main() {
  group("view model of user detail", () {
    MockModel mockModel = MockModel();
    Model.setModel(mockModel);

    final cubit = UserDetailCubit();

    test("should receive UserDetailDone", () async {
      final user = UserOverview();
      final data = UserDetail();
      when(mockModel.getUserDetail(user))
          .thenAnswer((realInvocation) => Future.value(data));
      cubit.getUserDetail(user);
      expect(await cubit.stream.first, isA<UserDetailDone>());
    });

    test("should receive UserDetailError", () async {
      final e = Exception();
      final user = UserOverview();
      when(mockModel.getUserDetail(user))
          .thenAnswer((realInvocation) => Future.error(e));
      cubit.getUserDetail(user);
      expect(await cubit.stream.first, isA<UserDetailError>());
    });
  });
}
