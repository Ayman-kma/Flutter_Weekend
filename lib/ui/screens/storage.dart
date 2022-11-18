import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class SingletonStorage {
  abstract final String objectKey;
  Map<String, dynamic> toJson();

  Future save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(this.objectKey, json.encode(this.toJson()));
  }

  Future remove() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(this.objectKey);
  }
}
