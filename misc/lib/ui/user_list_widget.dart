import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

import '../const/const.dart';
import '../model/user_overview.dart';

Widget item(UserOverview data, VoidCallback onTap) {
  String? name = data.login;
  String? type = data.type;
  bool isEmpty = name == null && type == null;
  return ListTile(
    onTap: isEmpty ? null : onTap,
    leading: CircleAvatar(
      radius: 48,
      backgroundColor: loadingColor,
      child: ClipOval(
        child: isEmpty || data.avatarUrl == null
            ? const SizedBox()
            : FadeInImage.memoryNetwork(
                placeholder: kTransparentImage, image: data.avatarUrl!),
      ),
    ),
    title: Text(
      isEmpty ? "YourName" : name!,
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isEmpty ? Colors.transparent : null,
          backgroundColor: isEmpty ? loadingColor : Colors.transparent),
    ),
    subtitle: Text(
      isEmpty ? "Type" : type!,
      style: TextStyle(
          color: isEmpty ? Colors.transparent : null,
          backgroundColor: isEmpty ? loadingColor : Colors.transparent),
    ),
  );
}

void showDetail(BuildContext context, Widget view) {
  showGeneralDialog(
    context: context,
    barrierColor: Colors.black12.withOpacity(0.6), // Background color
    barrierDismissible: false,
    barrierLabel: 'Dialog',
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return SafeArea(
          child: Material(
        child: view,
      ));
    },
  );
}
