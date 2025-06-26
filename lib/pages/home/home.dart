import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'package:tramo/pages/home/widgets/botonera.dart';
import 'package:tramo/pages/home/widgets/mapa.dart';
import 'package:tramo/pages/home/widgets/v.dart';
import 'package:tramo/pages/home/widgets/vmax.dart';
import 'package:tramo/pages/home/widgets/vavg.dart';
import 'package:tramo/pages/home/widgets/crono.dart';
import 'package:tramo/pages/home/widgets/hora.dart';
import 'package:tramo/pages/home/widgets/brujula.dart';
import 'package:tramo/pages/home/widgets/delta.dart';
import 'package:tramo/pages/home/widgets/precision.dart';
import 'package:tramo/pages/home/widgets/altura.dart';
import 'package:tramo/rotate.dart';
import 'package:tramo/constants.dart';
import 'package:tramo/logo.dart';
import 'package:tramo/models/trip.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final StopWatchTimer _st = StopWatchTimer();
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  Trip trip = Trip();
  bool paused = false;

  @override
  void dispose() async {
    super.dispose();
    await _st.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Geolocator.getPositionStream(locationSettings: locationSettings),
      builder: (context, snp) {
        if (snp.hasError) {
          return ErrorPage(e: snp.error.toString());
        }
        if (snp.connectionState == ConnectionState.waiting) {
          return const CupertinoActivityIndicator();
        } else {
          if (!snp.hasData) {
            return const ErrorPage(e: 'No hay datos de posición');
          }
          final Point point = Point(snp.data!);
          if (_st.isRunning) trip.addPoint(point, !paused);
          return OrientationBuilder(
            builder: (context, orientation) {
              return orientation == Orientation.portrait
                  ? const Rota()
                  : Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                              Boton(
                                ontap: () {},
                                color: CupertinoColors.systemGrey,
                                icon: CupertinoIcons.settings_solid,
                              ),
                              Boton(
                                ontap: () {},
                                color: CupertinoColors.systemPurple,
                                icon: CupertinoIcons.rocket_fill,
                              ),
                              Boton(
                                ontap: () {},
                                color: CupertinoColors.systemYellow,
                                icon: CupertinoIcons.list_bullet,
                              ),
                              _st.isRunning
                                  ? Boton(
                                      ontap: () {
                                        setState(() {
                                          _st.onStopTimer();
                                          paused = true;
                                        });
                                      },
                                      color: CupertinoColors.activeOrange,
                                      icon: CupertinoIcons.pause_solid,
                                    )
                                  : Boton(
                                      ontap: () {
                                        if (!paused) {
                                          trip.start(
                                            DateFormat(
                                              'hh:mm',
                                            ).format(DateTime.now()),
                                          );
                                        }
                                        setState(() {
                                          _st.onStartTimer();
                                          paused = false;
                                        });
                                      },
                                      color: CupertinoColors.activeGreen,
                                      icon: CupertinoIcons.play_arrow_solid,
                                    ),
                              Boton(
                                ontap: () {
                                  setState(() {
                                    _st.onResetTimer();
                                    paused = false;
                                    trip.finish(
                                      _st.toString(),
                                      DateFormat(
                                        'hh:mm',
                                      ).format(DateTime.now()),
                                      "nombre",
                                    );
                                    trip = Trip();
                                  });
                                },
                                color: CupertinoColors.destructiveRed,
                                icon: CupertinoIcons.square_fill,
                              ),
                              Expanded(
                                child: Container(
                                  color: CupertinoColors.destructiveRed,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Column(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Row(
                                  children: [
                                    const Flexible(flex: 1, child: Hora()),
                                    const VerticalDivider(
                                      width: 0,
                                      color: dividerColor,
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Crono(seconds: _st.rawTime),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(height: 0, color: dividerColor),
                              Flexible(
                                flex: 4,
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 4,
                                      child: Velocidad(v: point.getV()),
                                    ),
                                    const VerticalDivider(
                                      width: 0,
                                      color: dividerColor,
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: VelocidadMax(
                                              v: trip.getVMax(),
                                            ),
                                          ),
                                          const Divider(
                                            height: 0,
                                            color: dividerColor,
                                          ),
                                          Expanded(
                                            child: VelocidadAvg(
                                              v: trip.getVAvg(),
                                            ),
                                          ),
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
                                    Flexible(
                                      flex: 1,
                                      child: Precision(p: point.getGpsAcc()),
                                    ),
                                    const VerticalDivider(
                                      width: 0,
                                      color: dividerColor,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Altura(a: point.getAltitude()),
                                    ),
                                    const VerticalDivider(
                                      width: 0,
                                      color: dividerColor,
                                    ),
                                    const Flexible(
                                      flex: 1,
                                      child: Center(child: Text('abd')),
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
                                    VerticalDivider(
                                      width: 0,
                                      color: dividerColor,
                                    ),
                                    Expanded(child: Brujula()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Flexible(flex: 6, child: Mapa()),
                      ],
                    );
            },
          );
        }
      },
    );
  }
}
