import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

final EmailProvider = StateProvider<String>((ref) {
  return "";
});
final passProvider = StateProvider<String>((ref) {
  return "";
});

final updateState = StateProvider<bool>((ref) {
  return false;
});

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Location location = new Location();

  bool? _serviceEnabled;

  PermissionStatus? _permissionGranted;

  LocationData? _locationData;
  String curentLocationDD = "12355";

  @override
  void initState() {
    super.initState();

    setup();
  }

  void setup() async {
    Location location = new Location();

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
    print("123");
    print(_locationData);
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        curentLocationDD = currentLocation!.latitude.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home page")),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                setup();
              },
              child: Text("123")),
          Text(curentLocationDD),
        ],
      ),
    );
  }
}
