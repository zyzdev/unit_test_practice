import 'package:misc/model/user_detail.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvp/mine/model.dart';
import 'package:mvp/mine/presenter.dart';
import 'package:mvp/mine/view.dart';
import 'package:test/test.dart';

import 'presenter_test.mocks.dart';

@GenerateMocks([ViewState, Model])
void main() {
  group("presenter of mine", () {
    ViewState mockVS = MockViewState();
    MockModel mockModel = MockModel();
    Model.setModel(mockModel);

    final presenter = Presenter(view: mockVS);

    test("should call viewState done", () async {
      final data = UserDetail();
      when(mockModel.getMineDetail())
          .thenAnswer((realInvocation) => Future.value(data));
      await presenter.getMineDetail();
      verify(mockVS.done(data)).called(1);
    });

    test("should call viewState error", () async {
      final e = Exception();
      when(mockModel.getMineDetail())
          .thenAnswer((realInvocation) => Future.error(e));
      await presenter.getMineDetail();
      verify(mockVS.error(e)).called(1);
    });
  });
}
