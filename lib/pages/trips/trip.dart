import 'package:flutter/cupertino.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:tramo/constants.dart';
import 'package:tramo/models.dart';
import 'package:tramo/pages/trips/trip_popup.dart';
import 'package:tramo/pages/trips/trip_tile.dart';

class TripPage extends StatefulWidget {
  const TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  void _showTripPopup(TripInfo trip) {
    showCupertinoModalBottomSheet(
      context: context,
      expand: false, // set to true if you want it to expand fully
      builder: (context) => TripPopup(trip: trip),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TripInfo> trips = [
      TripInfo.test('primeraruta'),
      TripInfo.test('segundaruta'),
    ];

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            border: Border(bottom: BorderSide(color: dividerColor)),
            alwaysShowMiddle: false,
            middle: const Text(
              'Rutas',
              style: TextStyle(color: CupertinoColors.white, fontSize: 20),
            ),
            largeTitle: const Text(
              'Rutas',
              style: TextStyle(color: CupertinoColors.white),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final trip = trips[index];
              return TripTile(trip: trip, onTap: () => _showTripPopup(trip));
            }, childCount: trips.length),
          ),
        ],
      ),
    );
  }
}
