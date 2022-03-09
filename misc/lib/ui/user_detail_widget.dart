import 'package:flutter/material.dart';

import '../const/const.dart';

Widget infoItem(IconData icon, String? info) {
  bool hasInfo = info != null;
  return Row(
    children: [
      const SizedBox(
        width: 32,
      ),
      Icon(icon),
      const SizedBox(
        width: 16,
      ),
      Text(info ?? "      ",
          style: TextStyle(
              color: !hasInfo ? Colors.transparent : null,
              backgroundColor: !hasInfo ? loadingColor : Colors.transparent))
    ],
  );
}
