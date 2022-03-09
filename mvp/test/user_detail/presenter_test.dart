import 'package:misc/misc.dart';
import 'package:misc/model/user_detail.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvp/user_detail/model.dart';
import 'package:mvp/user_detail/presenter.dart';
import 'package:mvp/user_detail/view.dart';
import 'package:test/test.dart';

import 'presenter_test.mocks.dart';

@GenerateMocks([ViewState, Model])
void main() {
  group("presenter of user detail", () {
    ViewState mockVS = MockViewState();
    MockModel mockModel = MockModel();
    Model.setModel(mockModel);

    final presenter = Presenter(view: mockVS);

    test("should call ViewState done", () async {
      final user = UserOverview();
      final data = UserDetail();
      when(mockModel.getUserDetail(user))
          .thenAnswer((realInvocation) => Future.value(data));
      await presenter.getUserDetail(user);
      verify(mockVS.done(data)).called(1);
    });

    test("should call ViewState error", () async {
      final user = UserOverview();
      final e = Exception();
      when(mockModel.getUserDetail(user))
          .thenAnswer((realInvocation) => Future.error(e));
      await presenter.getUserDetail(user);
      verify(mockVS.error(e)).called(1);
    });
  });
}
