import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

// FutureProvider<String>
final getDataProvider = FutureProvider<String>((ref) async {
  return "123";
});

final EmailProvider = StateProvider<String>((ref) {
  return "";
});
final passProvider = StateProvider<String>((ref) {
  return "";
});

final updateState = StateProvider<bool>((ref) {
  return false;
});

class backgroundLocation extends StatefulWidget {
  @override
  State<backgroundLocation> createState() => _backgroundLocationState();
}

class _backgroundLocationState extends State<backgroundLocation> {
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
    // print(_locationData);
    // print("_locationData");

    location.enableBackgroundMode(enable: true);
    location.onLocationChanged.listen((LocationData currentLocation) {

      setState(() {
        curentLocationDD = currentLocation!.latitude.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("bg-location 2")),
      body: Column(children: [Text(curentLocationDD)]),
    );
  }
}
