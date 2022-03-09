import 'package:misc/model/user_overview.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvp/user_list/model.dart';
import 'package:mvp/user_list/presenter.dart';
import 'package:mvp/user_list/view.dart';
import 'package:test/scaffolding.dart';

import 'presenter_test.mocks.dart';

@GenerateMocks([ViewState, Model])
void main() {
  group("presenter of user list", () {
    ViewState mockVS = MockViewState();
    MockModel mockModel = MockModel();
    Model.setModel(mockModel);

    final presenter = Presenter(view: mockVS);

    test("should call ViewState done", () async {
      final data = [UserOverview()];
      when(mockModel.getUserList()).thenAnswer((realInvocation) {
        return Future.value(data);
      });
      await presenter.getUserList();
      verify(mockVS.done(data)).called(1);
    });

    test("should call ViewState error", () async {
      final e = Exception();
      when(mockModel.getUserList()).thenAnswer((realInvocation) {
        return Future.error(e);
      });
      await presenter.getUserList();
      verify(mockVS.error(e)).called(1);
    });
  });
}
