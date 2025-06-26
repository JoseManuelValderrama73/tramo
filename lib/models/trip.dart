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
  late final Vehicle vehicle;
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
    vehicle = Vehicle.other;
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
      double l = points.length.toDouble();
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
