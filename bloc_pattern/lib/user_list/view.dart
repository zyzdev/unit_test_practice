import 'package:bloc_pattern/user_detail/view.dart' as detail;
import 'package:bloc_pattern/user_list/user_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:misc/const/const.dart';
import 'package:misc/cubit/boolean/boolean_cubit.dart';
import 'package:misc/misc.dart';
import 'package:misc/ui/error_widget.dart';
import 'package:misc/ui/loading.dart';

class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  @override
  ViewState createState() => ViewState();
}

class ViewState extends State with SignalApiView {
  final ScrollController _controller = ScrollController();
  late List<UserOverview> _data;

  late UserListCubit _cubit;
  @visibleForTesting
  static UserListCubit? mockCubit;

  @override
  void initState() {
    _data = [
      UserOverview(),
      UserOverview(),
      UserOverview(),
      UserOverview(),
      UserOverview()
    ];
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _cubit.getUserList(_data.last.id);
        showLoading();
      }
    });
    _cubit = mockCubit != null ? mockCubit! : UserListCubit();
    _cubit.getUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocConsumer(
          bloc: _cubit,
          listenWhen: (previous, current) => current is UserListError,
          listener: (context, state) => error((state as UserListError).e),
          buildWhen: (previous, current) => current is UserListDone,
          builder: (context, state) {
            if (state is UserListDone) {
              done(state.data);
            }
            return ListView.separated(
                controller: _controller,
                itemBuilder: (context, index) {
                  UserOverview data = _data[index];
                  return item(
                      data, () => showDetail(context, detail.View(data: data)));
                },
                separatorBuilder: (context, index) => const Divider(
                      height: 1,
                    ),
                itemCount: _data.length);
          },
        ),
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
  void done(Iterable<UserOverview> data) {
    if (!init) {
      init = true;
      _data.clear();
    }
    _data.addAll(data);
    hideLoading();
  }

  @override
  void error(Exception e) {
    showError(context).then((value) {
      if (value) _cubit.getUserList(!init ? null : _data.last.id);
    });
    super.error(e);
  }
}
