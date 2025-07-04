import 'package:geolocator/geolocator.dart';
import 'package:tramo/constants.dart';
import 'package:tramo/models/time.dart';

class Point {
  final double lat;
  final double lon;
  final int v;
  final double gpsAcc;
  final int altitude;
  final int slope;

  Point(Position p)
    : lat = p.latitude,
      lon = p.longitude,
      v = (p.speed * 3.6).toInt(),
      gpsAcc = double.parse(p.accuracy.toStringAsFixed(2)),
      altitude = p.altitude.toInt(),
      slope = 0;
  Point.still(Point p)
    : lat = p.lat,
      lon = p.lon,
      v = 0,
      gpsAcc = 0.0,
      altitude = p.altitude,
      slope = 0;
}

class TripInfo {
  late final String name;
  late final Time time;
  late final Time startTime;
  late final Time endTime;
  late final Vehicle vehicle;
  double distance; // m
  List<Point> points = [];
  int? vMax;
  double? vAvg;
  bool running;
  int? currentSlope;

  TripInfo() : distance = 0, vMax = 0, vAvg = 0, running = false;
  TripInfo.test(this.name)
    : distance = 0,
      vMax = 0,
      vAvg = 0,
      running = false,
      time = Time(DateTime(1970, 1, 1, 0, 0, 0, 0, 0)),
      startTime = Time.now(),
      endTime = Time.now(),
      vehicle = Vehicle.car;

  void start() {
    startTime = Time.now();
    running = true;
  }

  void finish(Time time, String name, Vehicle vehicle) {
    this.time = time;
    this.name = name;
    endTime = Time.now();
    running = false;
    this.vehicle = vehicle;
    // TODO: guardar en dtb
  }

  void addPoint(Point p) {
    if (running) {
      points.add(p);
      distance = distance + 0.02;
      int l = points.length;
      vAvg = ((vAvg! * (l - 1)) + p.v) / l;
      if (p.v > vMax!) vMax = p.v;
      if (l > 1) {
        currentSlope =
            ((points[l - 1].altitude - points[l - 2].altitude).abs() /
                    distanceFilter)
                .toInt();
      }
    } else {
      throw 'The trip hasnt started';
    }
  }
}
