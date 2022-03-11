import 'package:bloc_pattern/mine/view.dart' as mine;
import 'package:bloc_pattern/user_list/view.dart' as user_list;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:misc/generated/l10n.dart';
import 'package:misc/ui/page_change_notifier_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.black),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.black.withOpacity(0.75),
              unselectedItemColor: Colors.grey.withOpacity(0.75))),
      home: HomePage(title: S().title_github),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: PageView(
        controller: _controller,
        children: const [user_list.View(), mine.View()],
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: PageChangeNotifierBuilder(
        listener: _controller,
        builder: (context, value) {
          return BottomNavigationBar(
            currentIndex: value,
            items: _bottomNavItems,
            onTap: (index) {
              _controller.jumpToPage(index);
            },
          );
        },
      ),
    ));
  }

  List<BottomNavigationBarItem> get _bottomNavItems => [
        BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline), label: S().title_user),
        BottomNavigationBarItem(
            icon: const Icon(Icons.info_outline), label: S().title_mine)
      ];
}
