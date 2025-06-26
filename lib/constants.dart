import 'package:flutter/cupertino.dart';

const CupertinoDynamicColor dividerColor = CupertinoColors.systemGrey4;

Widget title(String t) {
  return Text(
    t,
    style: TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.bold,
      color: CupertinoColors.lightBackgroundGray,
    ),
  );
}

Widget text(String t) {
  return Text(t, style: TextStyle(fontSize: 20, color: CupertinoColors.white));
}

Widget text2(String t) {
  return Text(
    t,
    style: TextStyle(fontSize: 15, color: CupertinoColors.inactiveGray),
  );
}

// Precision
const double limitePrecisionBuena = 10;
const double limitePrecisionRegular = 10;

enum Vehicle { car, bike, bus, train, walk, other }
