import 'package:geolocator/geolocator.dart';

class Point {
  final double lat;
  final double lon;
  final int v;
  final double gpsAcc;
  final int altitude;

  Point(Position p)
    : lat = p.latitude,
      lon = p.longitude,
      v = p.speed.toInt(),
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

class Trip {
  late final String name;
  late final String time;
  late final String startTime;
  late final String endTime;
  double? distance;
  List<Point> points = [];
  int? vMax;
  double? vAvg;
  bool running = false;

  Trip();

  void start(String startTime) {
    this.startTime = startTime;
    distance = 0;
    vMax = 0;
    vAvg = 0;
    running = true;
  }

  void finish(String time, String end, String name) {
    this.time = time;
    this.name = name;
    endTime = end;
    running = false;
    /* TODO: guardar en dtb */
  }

  void addPoint(Point p, bool save) {
    if (running) {
      if (save) points.add(p);
      double l = len().toDouble();
      vAvg = (l - 1 / l) * vAvg! + p.v.toDouble() / l;
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
