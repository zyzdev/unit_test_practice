import 'package:bloc_pattern/mine/mine_cubit.dart';
import 'package:bloc_pattern/mine/model.dart';
import 'package:misc/model/user_detail.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'mine_cubit_test.mocks.dart';

@GenerateMocks([Model])
void main() {
  group("view model of mine", () {
    MockModel mockModel = MockModel();
    Model.setModel(mockModel);

    final cubit = MineCubit();

    test("should return UserDetail", () async {
      final data = UserDetail();
      when(mockModel.getMineDetail())
          .thenAnswer((realInvocation) => Future.value(data));
      cubit.getMineDetail();
      expect(await cubit.stream.first, isA<MineDone>());
    });

    test("should return exception", () async {
      final e = Exception();
      when(mockModel.getMineDetail())
          .thenAnswer((realInvocation) => Future.error(e));
      cubit.getMineDetail();
      expect(await cubit.stream.first, isA<MineError>());
    });
  });
}
