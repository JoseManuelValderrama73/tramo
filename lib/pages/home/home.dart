import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'package:tramo/constants.dart';
import 'package:tramo/models.dart';
import 'package:tramo/pages/home/widgets/distance.dart';
import 'package:tramo/pages/home/widgets/hora.dart';
import 'package:tramo/pages/home/widgets/std.dart';
import 'package:tramo/pages/home/widgets/v.dart';
import 'package:tramo/pages/home/widgets/vavg.dart';
import 'package:tramo/pages/home/widgets/vmax.dart';
import 'package:tramo/pages/home/widgets/crono.dart';
import 'package:tramo/pages/home/widgets/brujula.dart';
import 'package:tramo/pages/home/widgets/delta.dart';
import 'package:tramo/pages/home/widgets/precision.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.st,
    required this.trip,
    required this.point,
  });
  final StopWatchTimer st;
  final TripInfo trip;
  final Point point;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 2,
          child: Row(
            children: [
              const Flexible(flex: 1, child: Hora()),
              const VerticalDivider(width: 0, color: dividerColor),
              Flexible(flex: 2, child: Crono(seconds: widget.st.rawTime)),
            ],
          ),
        ),
        const Divider(height: 0, color: dividerColor),
        Flexible(
          flex: 4,
          child: Row(
            children: [
              Flexible(flex: 4, child: Velocidad(v: widget.point.v)),
              const VerticalDivider(width: 0, color: dividerColor),
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(child: VelocidadMax(v: widget.trip.vMax)),
                    const Divider(height: 0, color: dividerColor),
                    Expanded(child: VelocidadAvg(v: widget.trip.vAvg)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 0, color: dividerColor),
        Flexible(
          flex: 3,
          child: Row(
            children: [
              Flexible(flex: 1, child: Precision(p: widget.point.gpsAcc)),
              const VerticalDivider(width: 0, color: dividerColor),
              Flexible(
                flex: 1,
                child: StdWidget(desc: 'ALTITUD', data: widget.point.altitude),
              ),
              const VerticalDivider(width: 0, color: dividerColor),
              Flexible(
                flex: 1,
                child: Center(child: Distance(dist: widget.trip.distance)),
              ),
            ],
          ),
        ),
        const Divider(height: 0, color: dividerColor),
        const Flexible(
          flex: 5,
          child: Row(
            children: [
              Expanded(child: Delta()),
              VerticalDivider(width: 0, color: dividerColor),
              Expanded(child: Brujula()),
            ],
          ),
        ),
      ],
    );
  }
}
