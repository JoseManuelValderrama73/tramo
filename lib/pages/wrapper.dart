import 'package:flutter/cupertino.dart';

import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:tramo/pages/home/home.dart';

import 'package:tramo/pages/home/widgets/botonera.dart';
import 'package:tramo/constants.dart';
import 'package:tramo/logo.dart';
import 'package:tramo/models.dart';
import 'package:tramo/pages/home/widgets/mapa.dart';
import 'package:tramo/pages/launch.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final StopWatchTimer _st = StopWatchTimer();

  TripInfo trip = TripInfo();
  bool paused = false;
  bool launch = false;

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
          return const Center(child: CupertinoActivityIndicator());
        } else {
          if (!snp.hasData) {
            return const ErrorPage(e: 'No hay datos de posición');
          }
          final Point point = Point(snp.data!);
          if (_st.isRunning && !paused) {
            try {
              trip.addPoint(point);
            } catch (err) {
              // Handle any errors that may occur when adding a point
              return ErrorPage(e: 'Error adding point: $err');
            }
          }
          return Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(color: CupertinoColors.systemGrey),
                    ),
                    Boton(
                      ontap: () {},
                      color: CupertinoColors.systemGrey,
                      icon: CupertinoIcons.settings_solid,
                    ),
                    Boton(
                      ontap: () {
                        setState(() => launch = !launch);
                      },
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
                                trip.start(dateFormat(DateTime.now()));
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
                            DateFormat('hh:mm').format(DateTime.now()),
                            "nombre",
                            Vehicle.other,
                          );
                          trip = TripInfo();
                        });
                      },
                      color: CupertinoColors.destructiveRed,
                      icon: CupertinoIcons.square_fill,
                    ),
                    Expanded(
                      child: Container(color: CupertinoColors.destructiveRed),
                    ),
                  ],
                ),
              ),
              launch
                  ? Flexible(flex: 5, child: Launch(speed: point.getV()))
                  : Flexible(
                      flex: 5,
                      child: Home(st: _st, trip: trip, point: point),
                    ),
              const Flexible(flex: 6, child: Mapa()),
            ],
          );
        }
      },
    );
  }
}
