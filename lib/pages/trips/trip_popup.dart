import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';

import 'package:tramo/constants.dart';
import 'package:tramo/models.dart';
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
          Flexible(
            flex: 2,
            child: Stack(
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
          ),
          Flexible(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(trip.name, style: titleStyle.copyWith(fontSize: 40)),
                  Text(trip.time.toString(), style: titleStyle),
                  Row(
                    children: [
                      Text('${trip.distance}km'),
                      Expanded(child: SizedBox()),
                      Text(
                        '${DateFormat('HH:mm:ss.SS').format(trip.startTime)} - ${DateFormat('HH:mm:ss.SS').format(trip.endTime)}',
                      ),
                    ],
                  ),
                  Row(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
