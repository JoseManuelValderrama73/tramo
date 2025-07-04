import 'package:flutter/cupertino.dart';

import 'package:geolocator/geolocator.dart';

import 'package:tramo/logo.dart';
import 'package:tramo/pages/trips/trip.dart';
import 'package:tramo/pages/wrapper.dart';

void main() {
  runApp(const MyApp());
}

Future checkPermissions() async {
  LocationPermission permission;
  if (!(await Geolocator.isLocationServiceEnabled())) {
    return Future.error('Servicio de localización inhabilitado');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Acceso a la localización no permitido');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error('Los permisos de localización están inhabilitados');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Tramo',
      theme: const CupertinoThemeData(
        applyThemeToAll: true,
        barBackgroundColor: CupertinoColors.black,
        scaffoldBackgroundColor: CupertinoColors.black,
        primaryColor: CupertinoColors.white,
        textTheme: CupertinoTextThemeData(
          primaryColor: CupertinoColors.white,
          textStyle: TextStyle(color: CupertinoColors.white, fontSize: 18),
          actionTextStyle: TextStyle(
            color: CupertinoColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: CupertinoPageScaffold(
        child: FutureBuilder(
          future: checkPermissions(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorPage(e: snapshot.error?.toString());
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return OrientationBuilder(
                builder: (context, orientation) {
                  if (orientation == Orientation.landscape) {
                    return const Wrapper();
                  } else {
                    return const TripPage();
                  }
                },
              );
            } else {
              return const Logo();
            }
          },
        ),
      ),
    );
  }
}
