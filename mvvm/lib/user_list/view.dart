import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:misc/const/const.dart';
import 'package:misc/cubit/boolean/boolean_cubit.dart';
import 'package:misc/misc.dart';
import 'package:misc/ui/error_widget.dart';
import 'package:misc/ui/loading.dart';
import 'package:mvvm/user_detail/view.dart' as detail;
import 'package:mvvm/user_list/view_model.dart';

class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  @override
  ViewState createState() => ViewState();
}

class ViewState extends State with SignalApiView {
  final ScrollController _controller = ScrollController();
  late ViewModel _viewModel;
  late List<UserOverview> _data;
  late StreamSubscription _dataObserver;
  @visibleForTesting
  static ViewModel? mockViewModel;

  @override
  void initState() {
    _data = [
      UserOverview(),
      UserOverview(),
      UserOverview(),
      UserOverview(),
      UserOverview()
    ];
    _viewModel = mockViewModel != null ? mockViewModel! : ViewModel();
    _dataObserver = _viewModel.stream.listen((data) {
      done(data);
    })
      ..onError((e) {
        error(e);
      });
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _viewModel.getUserList(_data.last.id);
        showLoading();
      }
    });
    _viewModel.getUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.separated(
            controller: _controller,
            itemBuilder: (context, index) {
              UserOverview data = _data[index];
              return item(
                  data, () => showDetail(context, detail.View(data: data)));
            },
            separatorBuilder: (context, index) => const Divider(
                  height: 1,
                ),
            itemCount: _data.length),
        BlocBuilder<BooleanCubit, bool>(
          bloc: loadingBloc,
          builder: (context, state) => AnimatedSwitcher(
            duration: defDur,
            child: state ? Loading() : emptyWidget,
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _dataObserver.cancel();
    _viewModel.destroy();
    super.dispose();
  }

  @override
  void done(Iterable<UserOverview> data) {
    if (!init) {
      init = true;
      _data.clear();
    }
    _data.addAll(data);
    super.done(data);
  }

  @override
  void error(Exception e) {
    showError(context).then((value) {
      if (value) _viewModel.getUserList(!init ? null : _data.last.id);
    });
    super.error(e);
  }
}
