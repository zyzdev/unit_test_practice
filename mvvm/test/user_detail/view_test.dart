import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:misc/model/user_detail.dart';
import 'package:misc/model/user_overview.dart';
import 'package:misc/ui/error_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvvm/user_detail/view.dart';
import 'package:mvvm/user_detail/view_model.dart';

import 'view_test.mocks.dart';

@GenerateMocks([ViewModel])
void main() {
  testWidgets(
    "User detail page",
    (tester) async {
      MockViewModel mockViewModel = MockViewModel();
      ViewState.mockViewModel = mockViewModel;
      final user = UserOverview(
        login: "test",
      );

      when(mockViewModel.getUserDetail(user))
          .thenAnswer((realInvocation) async {});
      when(mockViewModel.stream).thenAnswer((realInvocation) => Stream.empty());
      final view = View(
        data: user,
      );
      await tester.pumpWidget(MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
              home: Material(
            child: view,
          ))));
      ViewState vs = tester.state(find.byWidget(view)) as ViewState;
      vs.done(UserDetail(
          login: "test",
          name: "name",
          location: "location",
          htmlUrl: "htmlUrl"));
      await tester.pumpAndSettle();
      expect(find.text("test"), findsOneWidget);
      expect(find.text("name"), findsOneWidget);
      expect(find.text("location"), findsOneWidget);
      expect(find.text("htmlUrl"), findsOneWidget);

      vs.error(Exception());
      await tester.pumpAndSettle();
      expect(find.byType(ErrorView), findsOneWidget);
    },
  );
}
