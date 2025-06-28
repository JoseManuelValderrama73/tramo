import 'package:flutter/cupertino.dart';

import 'package:geolocator/geolocator.dart';

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

TextStyle subtextStyle = TextStyle(
  fontSize: 15,
  color: CupertinoColors.inactiveGray,
);

// Precision
const double limitePrecisionBuena = 10;
const double limitePrecisionRegular = 20;
final LocationSettings locationSettings = const LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 20,
  timeLimit: Duration(seconds: 10),
);

enum Vehicle { car, bike, bus, train, walk, other }

String dateFormat(DateTime date) {
  return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
}
