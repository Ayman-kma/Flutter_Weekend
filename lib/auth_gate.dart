import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:location/location.dart';

import 'ui/screens/skeleton_screen.dart';

class AuthGate extends StatefulWidget {
  static String long = "";
  static String lat = "";
  static bool isInside = false;
  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  Location location = new Location();

  bool? _serviceEnabled;

  PermissionStatus? _permissionGranted;

  LocationData? _locationData;
  String curentLocationDD = "123";
  @override
  void initState() {
    super.initState();

    setup();
  }

  void setup() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();


    location.enableBackgroundMode(enable: true);
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        AuthGate.long = currentLocation!.longitude.toString();
        AuthGate.lat = currentLocation!.latitude.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(AuthGate.long + " now ");
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providerConfigs: const [
              EmailProviderConfiguration(),
            ],
          );
        }

        return const SkeletonScreen();
      },
    );
  }
}
