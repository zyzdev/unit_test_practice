import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:misc/model/user_overview.dart';
import 'package:misc/ui/error_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvp/user_list/presenter.dart';
import 'package:mvp/user_list/view.dart';

import 'view_test.mocks.dart';

@GenerateMocks([Presenter])
void main() {
  testWidgets("test view of user list", (WidgetTester tester) async {
    final mockPresenter = MockPresenter();
    ViewState.mockPresenter = mockPresenter;

    when(mockPresenter.getUserList()).thenAnswer((realInvocation) async {});

    const Widget w = View();
    await tester.pumpWidget(const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
            home: Material(
          child: w,
        ))));
    ViewState vs = tester.state(find.byWidget(w)) as ViewState;
    mockPresenter.setView(vs);

    final list = find.byType(ListView);
    final initItems = find.byType(ListTile);
    expect(list, findsOneWidget, reason: "Page should be include a list view.");
    expect(initItems, findsNWidgets(5),
        reason: "Init list should be include five items.");

    vs.done([
      UserOverview(login: "test1", type: "User"),
      UserOverview(login: "test2", type: "User")
    ]);
    await tester.pumpAndSettle();
    final list1 = find.byType(ListView);
    expect(list1, findsOneWidget,
        reason: "Page should be include a list view.");
    final doneItems = find.byType(ListTile);
    expect(doneItems, findsNWidgets(2),
        reason: "Done list should be include two items.");
    expect(find.text("test1"), findsOneWidget,
        reason: "Should found a user name 'test1'.");
    expect(find.text("test2"), findsOneWidget,
        reason: "Should found a user name 'test2'.");
    expect(find.text("User"), findsNWidgets(2),
        reason: "Should found two user with subtitle 'User'.");

    vs.error(Exception());
    await tester.pumpAndSettle();
    expect(find.byType(ErrorView), findsOneWidget,
        reason: "Should find ErrorView.");
  });
}
