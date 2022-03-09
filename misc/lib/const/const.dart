import 'package:flutter/material.dart';

final Color loadingColor = Colors.grey.withOpacity(0.3);

const AssetImage githubIcon = AssetImage(
  "assets/images/img_github.png",
  package: "misc",
);

const SizedBox emptyWidget = SizedBox();

const SizedBox h8 = SizedBox(
  height: 8,
);
const SizedBox h16 = SizedBox(
  height: 16,
);
const SizedBox w4 = SizedBox(
  width: 4,
);
const SizedBox w8 = SizedBox(
  width: 8,
);
const SizedBox w16 = SizedBox(
  width: 16,
);

SizedBox gap({double width = 0, double height = 0}) => SizedBox(
      width: width,
      height: height,
    );

const Duration defDur = Duration(milliseconds: 250);
