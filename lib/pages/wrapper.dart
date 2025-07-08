import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tramo/models/time.dart';
import 'package:tramo/pages/home/home.dart';

import 'package:tramo/pages/home/widgets/botonera.dart';
import 'package:tramo/constants.dart';
import 'package:tramo/logo.dart';
import 'package:tramo/models/trip_info.dart';
import 'package:tramo/pages/home/widgets/mapa.dart';
import 'package:tramo/pages/launch.dart';
import 'package:tramo/popup.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final StopWatchTimer _st = StopWatchTimer();

  TripInfo trip = TripInfo();
  late Point point;
  bool paused = false;
  bool launch = false;
  bool guardar = false;

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
        if (snp.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (snp.hasError) {
          if (snp.error is TimeoutException) {
            point = Point.still(point);
          } else {
            return ErrorPage(e: snp.error.toString());
          }
        } else {
          if (!snp.hasData) {
            return const ErrorPage(e: 'No hay datos de posición');
          }
          point = Point(snp.data!);
        }
        if (_st.isRunning && !paused) {
          try {
            trip.addPoint(point);
          } catch (err) {
            return ErrorPage(e: 'Error adding point: $err');
          }
        }
        return Stack(
          children: [
            Row(
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
                        color: launch
                            ? CupertinoColors.activeBlue
                            : CupertinoColors.systemPurple,
                        icon: launch
                            ? CupertinoIcons.map
                            : CupertinoIcons.rocket_fill,
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
                                  trip.start();
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
                          if (trip.points.length > 5) {
                            setState(() {
                              guardar = true;
                            });
                          } else {
                            _st.onResetTimer();
                            setState(() {
                              paused = false;
                              trip = TripInfo();
                            });
                          }
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
                    ? Flexible(flex: 5, child: Launch(speed: point.v))
                    : Flexible(
                        flex: 5,
                        child: Home(st: _st, trip: trip, point: point),
                      ),
                const Flexible(flex: 6, child: Mapa()),
              ],
            ),
            Visibility(
              visible: true,
              child: Center(
                child: Popup(
                  color: CupertinoColors.activeOrange,
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 200),
                  title: 'Guardar ruta',
                  widgets: [],
                  buttons: [
                    Button(
                      color: CupertinoColors.activeOrange,
                      txt: 'Cancelar',
                      onTap: () {
                        setState(() {
                          guardar = false;
                        });
                      },
                    ),
                    Button(
                      color: CupertinoColors.destructiveRed,
                      txt: 'Descartar',
                      onTap: () {
                        setState(() {
                          trip = TripInfo();
                          guardar = false;
                          _st.onResetTimer();
                          paused = false;
                        });
                      },
                    ),
                    Button(
                      color: CupertinoColors.systemGreen,
                      txt: 'Guardar',
                      onTap: () {
                        trip.finish(
                          Time.fromStopwatch(_st),
                          "nombre",
                          Vehicle.other,
                        );
                        setState(() {
                          trip = TripInfo();
                          guardar = false;
                          _st.onResetTimer();
                          paused = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
