import 'package:geolocator/geolocator.dart';
import 'package:tramo/constants.dart';

class Point {
  final double lat;
  final double lon;
  final int v;
  final double gpsAcc;
  final int altitude;

  Point(Position p)
    : lat = p.latitude,
      lon = p.longitude,
      v = (p.speed * 3.6).toInt(),
      gpsAcc = double.parse(p.accuracy.toStringAsFixed(2)),
      altitude = p.altitude.toInt();

  int getV() {
    return v;
  }

  double getGpsAcc() {
    return gpsAcc;
  }

  int getAltitude() {
    return altitude;
  }
}

class TripInfo {
  late final String name;
  late final String time;
  late final String startTime;
  late final String endTime;
  late final Vehicle vehicle;
  double? distance;
  List<Point> points = [];
  int? vMax;
  double? vAvg;
  bool running;

  TripInfo() : distance = 0, vMax = 0, vAvg = 0, running = false;

  void start(String startTime) {
    this.startTime = startTime;
    running = true;
  }

  void finish(String time, String end, String name, Vehicle vehicle) {
    this.time = time;
    this.name = name;
    endTime = end;
    running = false;
    this.vehicle = vehicle;
    /* TODO: guardar en dtb
    if (points.isNotEmpty) {
      for (int i = 0; i < points.length - 1; i++) {
        double dx = points[i + 1].lat - points[i].lat;
        double dy = points[i + 1].lon - points[i].lon;
        distance = (distance ?? 0) + (dx * dx + dy * dy).sqrt();
      } */
  }

  void addPoint(Point p) {
    if (running) {
      points.add(p);
      int l = points.length;
      vAvg = ((vAvg! * (l - 1)) + p.v) / l;
      if (p.v > vMax!) vMax = p.v;
    } else {
      throw 'The trip hasnt started';
    }
  }

  int len() {
    return points.length;
  }

  double? getVAvg() {
    return vAvg;
  }

  int? getVMax() {
    return vMax;
  }
}

class LaunchInfo {
  late final String name;
  late final String startTime;
  late final Vehicle vehicle;
  late final int vMax;
  String? zeroHundred;
  String? zeroTwohundred;
  String? zeroThreehundred;

  LaunchInfo()
    : zeroHundred = null,
      zeroTwohundred = null,
      zeroThreehundred = null;

  void start(String startTime) {
    this.startTime = startTime;
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

  int? getVMax() {
    return vMax;
  }
}
