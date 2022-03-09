import 'package:flutter/material.dart';

typedef MyValueWidgetBuilder<T> = Widget Function(
    BuildContext context, T value);

class PageChangeNotifierBuilder extends StatefulWidget {
  const PageChangeNotifierBuilder(
      {Key? key, required this.listener, required this.builder})
      : super(key: key);
  final PageController listener;
  final MyValueWidgetBuilder builder;

  @override
  _ChangeNotifierBuilderState createState() => _ChangeNotifierBuilderState();
}

class _ChangeNotifierBuilderState extends State<PageChangeNotifierBuilder> {
  int? get _value => widget.listener.hasClients
      ? widget.listener.page?.toInt() ?? widget.listener.initialPage
      : widget.listener.initialPage;

  void _listener() {
    setState(() {});
  }

  @override
  void initState() {
    widget.listener.addListener(_listener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _value);

  @override
  void dispose() {
    widget.listener.removeListener(_listener);
    super.dispose();
  }
}
