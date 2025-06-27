import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tramo/constants.dart';
import 'package:tramo/models.dart';

class TripTile extends StatelessWidget {
  final TripInfo trip;

  const TripTile({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                child: Center(
                  child: Icon(CupertinoIcons.car, color: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('nombre'),
                  Text('fecha', style: subtextStyle),
                ],
              ),
            ],
          ),
        ),
        Divider(color: dividerColor, height: 0),
      ],
    );
  }
}

class TripPage extends StatefulWidget {
  const TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          border: Border(bottom: BorderSide(color: dividerColor)),
          alwaysShowMiddle: false,
          middle: const Text(
            'Rutas',
            style: TextStyle(color: CupertinoColors.white, fontSize: 20),
          ),
          largeTitle: const Text('Rutas'),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return TripTile(trip: TripInfo());
          }, childCount: 100),
        ),
      ],
    );
  }
}
