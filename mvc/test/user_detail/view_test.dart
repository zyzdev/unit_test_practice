import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:misc/misc.dart';
import 'package:misc/model/user_detail.dart';
import 'package:misc/ui/error_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvc/user_detail/model.dart';
import 'package:mvc/user_detail/view.dart';

import 'view_test.mocks.dart';

@GenerateMocks([Model])
void main() {
  testWidgets(
    "User detail page",
    (tester) async {
      Model.setModel(MockModel());
      final data = UserOverview(
        login: "test",
      );
      final view = View(
        data: data,
      );
      when(Model.instance.getUserDetail(ViewState(), data))
          .thenAnswer((realInvocation) {});
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
