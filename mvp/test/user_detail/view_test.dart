import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:misc/model/user_detail.dart';
import 'package:misc/model/user_overview.dart';
import 'package:misc/ui/error_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mvp/user_detail/presenter.dart';
import 'package:mvp/user_detail/view.dart';

import 'view_test.mocks.dart';

@GenerateMocks([Presenter])
void main() {
  testWidgets(
    "User detail page",
    (tester) async {
      MockPresenter mockPresenter = MockPresenter();
      ViewState.mockPresenter = mockPresenter;
      final data = UserOverview(
        login: "test",
      );
      final view = View(
        data: data,
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
