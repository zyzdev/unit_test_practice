import 'package:bloc_pattern/user_list/model.dart';
import 'package:bloc_pattern/user_list/user_list_cubit.dart';
import 'package:misc/model/user_overview.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'user_list_cubit_test.mocks.dart';

@GenerateMocks([Model])
void main() {
  group("cubit of user list", () {
    MockModel mockModel = MockModel();
    Model.setModel(mockModel);
    final UserListCubit cubit = UserListCubit();
    test("should receive UserListDone", () async {
      final data = [UserOverview()];
      when(mockModel.getUserList())
          .thenAnswer((realInvocation) => Future.value(data));
      cubit.getUserList();
      expect(await cubit.stream.first, isA<UserListDone>());
    });

    test("should receive UserListError", () async {
      final e = Exception();
      when(mockModel.getUserList())
          .thenAnswer((realInvocation) => Future.error(e));
      cubit.getUserList();
      expect(await cubit.stream.first, isA<UserListError>());
    });
  });
}
