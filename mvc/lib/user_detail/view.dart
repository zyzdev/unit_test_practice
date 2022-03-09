import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:misc/const/const.dart';
import 'package:misc/cubit/boolean/boolean_cubit.dart';
import 'package:misc/model/user_detail.dart';
import 'package:misc/model/user_overview.dart';
import 'package:misc/ui/error_widget.dart';
import 'package:misc/ui/loading.dart';
import 'package:misc/ui/signal_api_view.dart';
import 'package:misc/ui/user_detail_widget.dart';
import 'package:mvc/user_detail/control.dart';
import 'package:transparent_image/transparent_image.dart';

class View extends StatefulWidget {
  const View({Key? key, required this.data}) : super(key: key);
  final UserOverview data;

  @override
  ViewState createState() => ViewState();
}

class ViewState extends State with SignalApiView {
  UserDetail? _data;

  @override
  void initState() {
    Control.getUserDetail(this, (widget as View).data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close)),
                Expanded(
                    child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                      )
                    ],
                  ),
                ))
              ],
            )),
            const Divider(
              height: 1,
            ),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Expanded(child: infoItem(Icons.person, _data?.login)),
                  Expanded(child: infoItem(Icons.location_on, _data?.location)),
                  Expanded(child: infoItem(Icons.link, _data?.htmlUrl))
                ]))
          ],
        ),
        BlocBuilder<BooleanCubit, bool>(
          bloc: loadingBloc,
          builder: (context, state) => AnimatedSwitcher(
            duration: defDur,
            child: state ? Loading() : emptyWidget,
          ),
        ),
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
      if (value) Control.getUserDetail(this, (widget as View).data);
    });
    super.error(e);
  }
}
