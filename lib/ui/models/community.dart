// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_production_boilerplate_riverpod/ui/models/geo_location.dart';

class CommunityClass {
  String Description;
  String Name;
  String PlaceId;
  List<geoLocation> geo_fence;
  String image;
  CommunityClass({
    required this.Description,
    required this.Name,
    required this.PlaceId,
    required this.geo_fence,
    required this.image,
  });

  factory CommunityClass.fromMap(Map<String, dynamic> map) {
    print(map['geo_fence'][0]["Long"].toString());
    return CommunityClass(
      Description: map['Description'] as String,
      Name: map['Name'] as String,
      PlaceId: map['PlaceId'] as String,
      geo_fence: (map['geo_fence'] as List<dynamic>)
          .map((e) => geoLocation(
                Long: e["Long"] as String,
                Lat: e["Lat"] as String,
              ))
          .toList(),
      image: map['image'] as String,
    );
  }
}
