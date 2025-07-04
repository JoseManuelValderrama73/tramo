import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tramo/constants.dart';
import 'package:tramo/models/trip_info.dart';

class TripTile extends StatelessWidget {
  final TripInfo trip;
  final VoidCallback onTap;

  const TripTile({super.key, required this.trip, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: const Center(
                    child: Icon(CupertinoIcons.car, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(trip.name),
                    Text(trip.startTime.date, style: subtextStyle),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: dividerColor, height: 0),
        ],
      ),
    );
  }
}
