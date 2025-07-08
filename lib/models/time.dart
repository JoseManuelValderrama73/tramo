import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Time {
  final DateTime dateTime;

  Time(this.dateTime);
  Time.now() : dateTime = DateTime.now();
  Time.fromString(String str) : dateTime = DateTime.parse(str);
  Time.fromStopwatch(StopWatchTimer st)
    : dateTime = DateTime(
        2005,
        12,
        6,
      ).add(Duration(milliseconds: st.rawTime.value));

  String get hMinSec => DateFormat('HH:mm:ss').format(dateTime);

  String get hMinSecMil => DateFormat('HH:mm:ss.SS').format(dateTime);

  String get ymd => DateFormat('dd / MM / yyyy').format(dateTime);

  String get date => DateFormat('d MMMM yyyy').format(dateTime);
}
