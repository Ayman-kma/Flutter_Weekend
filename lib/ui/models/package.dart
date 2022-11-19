// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

class PackageClass {
  final String Name;
  final List<dynamic> Features;
  final String Price;
  final String PromoCode;
  PackageClass({
    required this.Name,
    required this.Features,
    required this.Price,
    required this.PromoCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Name': Name,
      'Features': Features,
      'price': Price,
      'PromoCode': PromoCode,
    };
  }

  factory PackageClass.fromMap(Map<String, dynamic> map) {
    return PackageClass(
      Name: map['Name'] as String,
      Features: map['Features'] as List<dynamic>,
      Price: map['Price'] as String,
      PromoCode: map['PromoCode'] as String,
    );
  }
}
