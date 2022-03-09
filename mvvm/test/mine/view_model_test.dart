import 'dart:async';

import 'package:misc/model/user_detail.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvvm/mine/model.dart';
import 'package:mvvm/mine/view_model.dart';
import 'package:test/test.dart';

import 'view_model_test.mocks.dart';

@GenerateMocks([Model])
void main() {
  group("view model of mine", () {
    MockModel mockModel = MockModel();
    Model.setModel(mockModel);

    final viewModel = ViewModel();

    test("should return UserDetail", () async {
      final data = UserDetail();
      when(mockModel.getMineDetail())
          .thenAnswer((realInvocation) => Future.value(data));
      await viewModel.getMineDetail();
      expect(await viewModel.stream.first, isA<UserDetail>());
    });

    test("should return exception", () async {
      final ViewModel viewModel = ViewModel();
      final e = Exception();
      when(mockModel.getMineDetail())
          .thenAnswer((realInvocation) => Future.error(e));
      Completer<Exception> watcher = Completer();
      final listener = viewModel.stream.listen((event) {})
        ..onError((e) => watcher.complete(e));
      await viewModel.getMineDetail();
      expectLater(await watcher.future, isA<Exception>());
      listener.cancel();
    });
  });
}
