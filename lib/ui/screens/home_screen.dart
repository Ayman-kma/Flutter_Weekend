// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_production_boilerplate_riverpod/auth_gate.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/models/community.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/models/package.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/models/places.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/widgets/first_screen/package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import 'package:flutter_production_boilerplate_riverpod/ui/widgets/first_screen/category_section.dart';
import 'package:location/location.dart';

import '../widgets/first_screen/info_card.dart';
import '../widgets/first_screen/theme_card.dart';
import '../widgets/header.dart';

import 'package:maps_toolkit/maps_toolkit.dart';

void showSnack(BuildContext context, bool inside) {
  if (inside) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("You are inside the Community"),
              backgroundColor: Colors.green,
            )));
  }
  if (!inside) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("You are outside the Community"),
              backgroundColor: Colors.red,
            )));
  }
}

CollectionReference eventData = FirebaseFirestore.instance.collection("Event");
CollectionReference placeData = FirebaseFirestore.instance.collection("Place");
CollectionReference communityData =
    FirebaseFirestore.instance.collection("Community");

CollectionReference packageData =
    FirebaseFirestore.instance.collection("Pacage");

final SelectCategoryProvider = StateProvider<int>((ref) {
  return -1;
});

final getEvent =
    StreamProvider.autoDispose<QuerySnapshot>((ref) => eventData.snapshots());

final getPlace =
    StreamProvider.autoDispose<QuerySnapshot>((ref) => placeData.snapshots());
final getCommunity = StreamProvider.autoDispose<QuerySnapshot>(
    (ref) => communityData.snapshots());

final getPackageData =
    StreamProvider.autoDispose<QuerySnapshot>((ref) => packageData.snapshots());

class PlaceItem extends StatelessWidget {
  String imageLink;
  String placeName;
  PlaceItem({
    required this.imageLink,
    required this.placeName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.primary),
      height: 130,
      width: 300,
      child: Row(
        children: [
          Container(
            width: 100,
            child: Image.network(imageLink, fit: BoxFit.cover),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            placeName,
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  String imageLink;
  String name;
  String description;
  CategoryItem({
    required this.imageLink,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.primary,
      ),
      height: 200,
      child: Row(
        children: [
          Container(
            width: 150,
            child: Image.network(imageLink, fit: BoxFit.fill),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  static bool callIt = false;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
  @override
  Widget build(BuildContext context) {
    var eventData = ref.watch(getEvent);
    var placeData = ref.watch(getPlace);
    var communityData = ref.watch(getCommunity);
    var packageData = ref.watch(getPackageData);
    print(AuthGate.long);
    LatLng point =
        LatLng(double.parse(AuthGate.lat), double.parse(AuthGate.long));
    // LatLng point = LatLng(26.311641, 50.224461);
    // LatLng point = LatLng(26.311648, 50.224435);
    print("lat ${double.parse(AuthGate.lat)}");
    print("long ${double.parse(AuthGate.long)}");
    List<LatLng> polygonPoints = [

      LatLng(26.311694, 50.224484),
      LatLng(26.311624, 50.224504),
      LatLng(26.311613, 50.224398),
      LatLng(26.311676, 50.224384),

    ];
    bool geodesic = true;
    bool inside = PolygonUtil.containsLocation(point, polygonPoints, geodesic);
    if (HomeScreen.callIt != inside) {
      showSnack(context, inside);
    }

    HomeScreen.callIt = inside;
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            const Header(text: 'app_name'),

            const SizedBox(height: 8),
            Text(inside.toString()),
            Text(AuthGate.lat),
            Text(AuthGate.long),
            packageData.when(
              data: ((data) {
                PackageClass userModel = PackageClass.fromMap(
                    data.docs[0].data() as Map<String, dynamic>);
                return Container(
                    child: Package(
                  title: userModel.Name,
                  features: userModel.Features,
                ));
              }),
              error: (Object error, StackTrace? stackTrace) {
                return Text(error.toString());
              },
              loading: () {
                return CircularProgressIndicator();
              },
            ),

            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Divider(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(.4),
              ),
            ),

            // Place
            const SizedBox(height: 8),

            placeData.when(
              data: ((data) {
                List<PlaceClass> placesModel = data.docs
                    .map((e) =>
                        PlaceClass.fromMap(e.data() as Map<String, dynamic>))
                    .toList();
                return Container(
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: placesModel.length,
                      itemBuilder: (BuildContext, index) => PlaceItem(
                            imageLink: placesModel[index].image,
                            placeName: placesModel[index].Name,
                          )),
                );
              }),
              error: (Object error, StackTrace? stackTrace) {
                return Text(error.toString());
              },
              loading: () {
                return CircularProgressIndicator();
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text("Communites",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 30)),

            communityData.when(
              data: ((data) {
                List<CommunityClass> communityModel = data.docs
                    .map((e) => CommunityClass.fromMap(
                        e.data() as Map<String, dynamic>))
                    .toList();

                return Container(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: communityModel.length,
                    itemBuilder: (BuildContext, index) => CategoryItem(
                      description: communityModel[index].Description,
                      imageLink: communityModel[index].image,
                      name: communityModel[index].Name,
                    ),
                  ),
                );
              }),
              error: (Object error, StackTrace? stackTrace) {
                return Text(error.toString());
              },
              loading: () {
                return CircularProgressIndicator();
              },
            ),

            // SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       CategoryItem(
            //         description: '',
            //         imageLink: '',
            //         name: '',
            //       ),
            //       CategoryItem(
            //         description: '',
            //         imageLink: '',
            //         name: '',
            //       ),
            //       CategoryItem(
            //         description: '',
            //         imageLink: '',
            //         name: '',
            //       ),
            //     ],
            //   ),
            // ),

            SizedBox(height: 36),
          ]),
    );
  }
}
