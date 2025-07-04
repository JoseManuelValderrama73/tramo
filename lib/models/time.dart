import 'package:intl/intl.dart';

class Time {
  final DateTime dateTime;

  Time(this.dateTime);
  Time.now() : dateTime = DateTime.now();
  Time.fromString(String str) : dateTime = DateTime.parse(str);

  String get hMinSec => DateFormat('HH:mm:ss').format(dateTime);

  String get hMinSecMil => DateFormat('HH:mm:ss.SS').format(dateTime);

  String get ymd => DateFormat('dd / MM / yyyy').format(dateTime);

  String get date => DateFormat('d MMMM yyyy').format(dateTime);
}
