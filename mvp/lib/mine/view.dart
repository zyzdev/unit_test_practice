import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:misc/const/const.dart';
import 'package:misc/cubit/boolean/boolean_cubit.dart';
import 'package:misc/generated/l10n.dart';
import 'package:misc/model/user_detail.dart';
import 'package:misc/ui/error_widget.dart';
import 'package:misc/ui/loading.dart';
import 'package:misc/ui/signal_api_view.dart';
import 'package:mvp/mine/presenter.dart';
import 'package:transparent_image/transparent_image.dart';

class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  @override
  ViewState createState() => ViewState();
}

class ViewState extends State with SignalApiView {
  UserDetail? _data;
  late Presenter _presenter;

  @visibleForTesting
  static Presenter? mockPresenter;

  @override
  void initState() {
    _presenter = mockPresenter != null ? mockPresenter! : Presenter(view: this);
    _presenter.getMineDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(32, 64, 16, 64),
              color: const Color.fromARGB(255, 0x00, 0x27, 0x39),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Image(
                      image: githubIcon,
                      width: 72,
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                  ),
                  w16,
                  Text(
                    S().title_github_docs,
                    style: const TextStyle(fontSize: 36, color: Colors.white),
                  )
                ],
              ),
            ),
            h8,
            Row(
              children: [
                w16,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 72,
                      backgroundColor: loadingColor,
                      child: ClipOval(
                        child: !init || _data!.avatarUrl == null
                            ? emptyWidget
                            : FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: _data!.avatarUrl!),
                      ),
                    ),
                    h8,
                    Text(
                      !init ? "YourName" : _data!.name!,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: !init ? Colors.transparent : null,
                          backgroundColor:
                              !init ? loadingColor : Colors.transparent),
                    ),
                    h8,
                    Text(
                      !init ? "YourName" : _data!.login!,
                      style: TextStyle(
                          fontSize: 16,
                          color:
                              !init ? Colors.transparent : Colors.grey.shade400,
                          backgroundColor:
                              !init ? loadingColor : Colors.transparent),
                    ),
                    h8,
                    Row(
                      children: [
                        const Icon(Icons.people),
                        w8,
                        Text(
                          "${_data?.followers ?? 0}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: !init
                                  ? Colors.transparent
                                  : Colors.grey.shade700,
                              backgroundColor:
                                  !init ? loadingColor : Colors.transparent),
                        ),
                        w4,
                        Text(
                          "${S().string_followers}.",
                          style: TextStyle(
                              fontSize: 16,
                              color: !init
                                  ? Colors.transparent
                                  : Colors.grey.shade400,
                              backgroundColor:
                                  !init ? loadingColor : Colors.transparent),
                        ),
                        w8,
                        Text(
                          "${_data?.following ?? 0}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: !init
                                  ? Colors.transparent
                                  : Colors.grey.shade700,
                              backgroundColor:
                                  !init ? loadingColor : Colors.transparent),
                        ),
                        w4,
                        Text(
                          "${S().string_following}.",
                          style: TextStyle(
                              fontSize: 16,
                              color: !init
                                  ? Colors.transparent
                                  : Colors.grey.shade400,
                              backgroundColor:
                                  !init ? loadingColor : Colors.transparent),
                        )
                      ],
                    )
                  ],
                )
              ],
            )
          ],
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
  void done(covariant dynamic data) {
    init = true;
    _data = data;
    super.done(data);
  }

  @override
  void error(Exception e) {
    showError(context).then((value) {
      if (value) _presenter.getMineDetail();
    });
    super.error(e);
  }
}
