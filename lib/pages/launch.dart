import 'package:flutter/material.dart';

import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'package:tramo/constants.dart';
import 'package:tramo/models.dart';
import 'package:tramo/pages/home/widgets/v.dart';

class Launch extends StatefulWidget {
  const Launch({super.key, required this.speed});
  final int speed;

  @override
  State<Launch> createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  final StopWatchTimer _st = StopWatchTimer();
  int prevSpeed = 0;
  bool started = false;
  bool finished = false;
  int threshold = 3;
  int max = 0;
  LaunchInfo launchInfo = LaunchInfo();

  @override
  void dispose() async {
    super.dispose();
    await _st.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String seconds = (_st.rawTime.value / 1000).toStringAsFixed(2);
    if (widget.speed > threshold && !started) {
      _st.onStartTimer();
      started = true;
      launchInfo.start(dateFormat(DateTime.now()));
    }
    if (widget.speed < prevSpeed - threshold && started && !finished) {
      _st.onStopTimer();
      finished = true;
      // cartel indicando que debe pararse
    }
    if (finished && widget.speed < threshold) {
      _st.onResetTimer();
      finished = false;
      started = false;
      max = 0;
      // Pedir si guardar el lauch
      launchInfo.finish("nombre", Vehicle.other, max);
    }
    prevSpeed = widget.speed;
    if (started && !finished) {
      if (widget.speed > max) {
        max = widget.speed;
      }
      if (widget.speed > 100) {
        launchInfo.setZeroHundred(seconds);
      }
      if (widget.speed > 200) {
        launchInfo.setZeroTwohundred(seconds);
      }
      if (widget.speed > 300) {
        launchInfo.setZeroThreehundred(seconds);
      }
    }

    return Column(
      children: [
        Expanded(child: Text(seconds)),
        const Divider(height: 0, color: dividerColor),
        Expanded(child: Velocidad(v: widget.speed)),
      ],
    );
  }
}
