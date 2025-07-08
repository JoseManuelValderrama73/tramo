import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tramo/constants.dart';
import 'package:tramo/models/trip_info.dart';
import 'package:tramo/pages/trips/widgets/altitude_graph.dart';
import 'package:tramo/pages/trips/widgets/map_img.dart';

class TripPopup extends StatelessWidget {
  final TripInfo trip;

  const TripPopup({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              const MapImg(),
              Positioned(
                top: 8,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 70,
                    height: 5,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey2.withOpacity(.6),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                    child: Text(
                      trip.name,
                      style: titleStyle.copyWith(fontSize: 40),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(trip.time.hMinSecMil, style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Text('${trip.distance}km'),
                        const Expanded(child: SizedBox()),
                        Text(
                          '${trip.startTime.hMinSec} - ${trip.endTime.hMinSec}',
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 0, color: dividerColor),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              trip.vAvg != null
                                  ? '${trip.vAvg!.toStringAsFixed(1)} km/h'
                                  : 'N/A',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              trip.vMax != null
                                  ? '${trip.vMax!.toStringAsFixed(1)} km/h'
                                  : 'N/A',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AltitudeGraph(altitudes: [123, 2452, 13, 2356]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
