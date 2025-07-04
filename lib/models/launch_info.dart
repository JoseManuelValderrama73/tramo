import 'package:tramo/constants.dart';
import 'package:tramo/models/time.dart';

class LaunchInfo {
  late final String name;
  late final Time startTime;
  late final Vehicle vehicle;
  late final int vMax;
  String? zeroHundred;
  String? zeroTwohundred;
  String? zeroThreehundred;

  LaunchInfo()
    : zeroHundred = null,
      zeroTwohundred = null,
      zeroThreehundred = null;

  void start() {
    startTime = Time.now();
  }

  void finish(String name, Vehicle vehicle, int vMax) {
    this.name = name;
    this.vehicle = vehicle;
    this.vMax = vMax;
    /* TODO: guardar en dtb */
  }

  void setZeroHundred(String time) {
    zeroHundred = time;
  }

  void setZeroTwohundred(String time) {
    zeroTwohundred = time;
  }

  void setZeroThreehundred(String time) {
    zeroThreehundred = time;
  }

  String getZeroHundred() {
    return zeroHundred ?? '-';
  }

  String getZeroTwohundred() {
    return zeroTwohundred ?? '-';
  }

  String getZeroThreehundred() {
    return zeroThreehundred ?? '-';
  }
}
