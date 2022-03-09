import 'dart:async';

import 'package:misc/model/user_overview.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvvm/user_list/model.dart';
import 'package:mvvm/user_list/view_model.dart';
import 'package:test/test.dart';

import 'view_mode_test.mocks.dart';

@GenerateMocks([Model])
void main() {
  group("view model of user list", () {
    MockModel mockModel = MockModel();
    Model.setModel(mockModel);

    test("should return Iterable<UserOverview>", () async {
      final ViewModel viewModel = ViewModel();
      final data = [UserOverview()];
      when(mockModel.getUserList())
          .thenAnswer((realInvocation) => Future.value(data));
      await viewModel.getUserList();
      expect(await viewModel.stream.first, isA<Iterable<UserOverview>>());
    });

    test("should return exception", () async {
      final ViewModel viewModel = ViewModel();
      final e = Exception();
      when(mockModel.getUserList())
          .thenAnswer((realInvocation) => Future.error(e));
      Completer<Exception> watcher = Completer();
      final listener = viewModel.stream.listen((event) {})
        ..onError((e) => watcher.complete(e));
      await viewModel.getUserList();
      expectLater(await watcher.future, isA<Exception>());
      listener.cancel();
    });
  });
}
