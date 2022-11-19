import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PlaceClass {
  final String Name;
  final String image;
  PlaceClass({
    required this.Name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Name': Name,
      'image': image,
    };
  }

  factory PlaceClass.fromMap(Map<String, dynamic> map) {
    return PlaceClass(
      Name: map['Name'] as String,
      image: map['image'] as String,
    );
  }
}
