import 'dart:async';

import 'package:misc/model/user_detail.dart';
import 'package:misc/model/user_overview.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvvm/user_detail/model.dart';
import 'package:mvvm/user_detail/view_model.dart';
import 'package:test/test.dart';

import 'view_model_test.mocks.dart';

@GenerateMocks([Model])
void main() {
  group("view model of user detail", () {
    MockModel mockModel = MockModel();
    Model.setModel(mockModel);

    final viewModel = ViewModel();

    test("should return UserDetail", () async {
      final user = UserOverview();
      final data = UserDetail();
      when(mockModel.getUserDetail(user))
          .thenAnswer((realInvocation) => Future.value(data));
      await viewModel.getUserDetail(user);
      expect(await viewModel.stream.first, isA<UserDetail>());
    });

    test("should return exception", () async {
      final ViewModel viewModel = ViewModel();
      final e = Exception();
      final user = UserOverview();
      when(mockModel.getUserDetail(user))
          .thenAnswer((realInvocation) => Future.error(e));
      Completer<Exception> watcher = Completer();
      final listener = viewModel.stream.listen((event) {})
        ..onError((e) => watcher.complete(e));
      await viewModel.getUserDetail(user);
      expectLater(await watcher.future, isA<Exception>());
      listener.cancel();
    });
  });
}
