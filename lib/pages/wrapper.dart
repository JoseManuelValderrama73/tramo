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

  final TextEditingController _tripNameController = TextEditingController();
  String? tripName;

  TripInfo trip = TripInfo();
  late Point point;
  bool paused = false;
  bool launch = false;
  bool guardar = false;

  int? selectedVehicle;
  void _showVehicleDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(top: false, child: child),
      ),
    );
  }

  @override
  void dispose() async {
    _tripNameController.dispose();
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

            // POPUPS
            Visibility(
              visible: guardar,
              child: Center(
                child: Popup(
                  color: CupertinoColors.activeOrange,
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 200),
                  title: 'Guardar ruta',
                  widgets: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6.withOpacity(0.8),
                        border: Border.all(
                          color: CupertinoColors.activeOrange,
                          width: 2.5,
                        ),
                      ),
                      child: CupertinoTextField(
                        controller: _tripNameController,
                        placeholder: 'Nombre de la ruta',
                        style: const TextStyle(fontSize: 18),
                        decoration: null,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    PopupButton(
                      color: CupertinoColors.activeOrange,
                      txt: selectedVehicle == null
                          ? 'Vehículo'
                          : Vehicle.values[selectedVehicle!].name,
                      onTap: () => _showVehicleDialog(
                        CupertinoPicker(
                          magnification: 1.22,
                          squeeze: 1.2,
                          useMagnifier: true,
                          itemExtent: 32,
                          scrollController: FixedExtentScrollController(
                            initialItem: selectedVehicle ?? 0,
                          ),
                          onSelectedItemChanged: (int selectedItem) {
                            setState(() {
                              selectedVehicle = selectedItem;
                            });
                          },
                          children: List<Widget>.generate(
                            Vehicle.values.length,
                            (int index) {
                              return Center(
                                child: Text(Vehicle.values[index].name),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                  buttons: [
                    PopupButton(
                      color: CupertinoColors.activeOrange,
                      txt: 'Cancelar',
                      onTap: () {
                        setState(() {
                          guardar = false;
                        });
                      },
                    ),
                    PopupButton(
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
                    PopupButton(
                      color: CupertinoColors.systemGreen,
                      txt: 'Guardar',
                      onTap: () {
                        if (_tripNameController.text.trim().isNotEmpty) {
                          setState(() {
                            tripName = _tripNameController.text.trim();
                            trip.finish(
                              Time.fromStopwatch(_st),
                              tripName!,
                              Vehicle.values[selectedVehicle!],
                            );
                            trip = TripInfo();
                            guardar = false;
                            _st.onResetTimer();
                            paused = false;
                          });
                        }
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
