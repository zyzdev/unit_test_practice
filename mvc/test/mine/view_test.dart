import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:misc/model/user_detail.dart';
import 'package:misc/ui/error_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvc/mine/model.dart';
import 'package:mvc/mine/view.dart';

import 'view_test.mocks.dart';

@GenerateMocks([Model])
void main() {
  testWidgets(
    "Mine page",
    (tester) async {
      Model.setModel(MockModel());
      when(Model.instance.getMineDetail(ViewState()))
          .thenAnswer((realInvocation) {});
      View view = const View();
      await tester.pumpWidget(MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
              home: Material(
            child: view,
          ))));
      ViewState vs = tester.state(find.byWidget(view)) as ViewState;
      vs.done(UserDetail(
          login: "test", name: "name", followers: 50, following: 100));
      await tester.pumpAndSettle();
      expect(find.text("test"), findsOneWidget,
          reason: "should find Text with text 'test'.");
      expect(find.text("name"), findsOneWidget,
          reason: "should find Text with text 'name'.");
      expect(find.text("50"), findsOneWidget,
          reason: "should find Text with text '50'.");
      expect(find.text("100"), findsOneWidget,
          reason: "should find Text with text '100'.");

      vs.error(Exception());
      await tester.pumpAndSettle();
      expect(find.byType(ErrorView), findsOneWidget,
          reason: "should find ErrorView.");
    },
  );
}
