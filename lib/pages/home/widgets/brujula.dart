import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import 'package:flutter_compass/flutter_compass.dart';

class Brujula extends StatelessWidget {
  const Brujula({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.heading == null) {
          return const Center(child: CupertinoActivityIndicator());
        }

        final double heading = snapshot.data!.heading!;
        final double rotation = (heading) * (math.pi / 180) * -1 - math.pi / 4;

        return Transform.rotate(
          angle: rotation,
          child: const Icon(CupertinoIcons.location_north_fill, size: 70),
        );
      },
    );
  }
}
