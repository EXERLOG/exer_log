import 'dart:convert';

import 'package:exerlog/src/core/base/extensions/string_extension.dart';
import 'package:exerlog/src/utils/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences sharedPreferences;

  static Future<void> initializeSharedPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Returns SharedPref Instance
  static Future<SharedPreferences> getSharedPref() async {
    return await SharedPreferences.getInstance();
  }

  /// Add a value in SharedPref based on their type - Must be a String, int, bool, double, Map<String, dynamic> or StringList
  static Future<bool> setValue(String key, dynamic value) async {
    Log.info('${value.runtimeType} - $key - $value');

    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else if (value is Map<String, dynamic>) {
      return await sharedPreferences.setString(key, jsonEncode(value));
    } else if (value is List<String>) {
      return await sharedPreferences.setStringList(key, value);
    } else {
      throw ArgumentError(
          'Invalid value ${value.runtimeType} - Must be a String, int, bool, double, Map<String, dynamic> or StringList');
    }
  }

  /// Returns a StringList if exists in SharedPref
  static List<String>? getStringListAsync(String key) {
    return sharedPreferences.getStringList(key);
  }

  /// Returns a Bool if exists in SharedPref
  static bool getBoolAsync(String key, {bool defaultValue = false}) {
    return sharedPreferences.getBool(key) ?? defaultValue;
  }

  /// Returns a Double if exists in SharedPref
  static double getDoubleAsync(String key, {double defaultValue = 0.0}) {
    return sharedPreferences.getDouble(key) ?? defaultValue;
  }

  /// Returns a Int if exists in SharedPref
  static int getIntAsync(String key, {int defaultValue = 0}) {
    return sharedPreferences.getInt(key) ?? defaultValue;
  }

  /// Returns a String if exists in SharedPref
  static String getStringAsync(String key, {String defaultValue = ''}) {
    return sharedPreferences.getString(key) ?? defaultValue;
  }

  /// Returns a JSON if exists in SharedPref
  static Map<String, dynamic> getJSONAsync(String key,
      {Map<String, dynamic>? defaultValue}) {
    if (sharedPreferences.containsKey(key) &&
        sharedPreferences.getString(key)!.validate().isNotEmpty) {
      return jsonDecode(sharedPreferences.getString(key)!);
    } else {
      return defaultValue ?? {};
    }
  }

  /// remove key from SharedPref
  static Future<bool> removeKey(String key) async {
    return await sharedPreferences.remove(key);
  }

  /// clear SharedPref
  static Future<bool> clearSharedPref() async {
    return await sharedPreferences.clear();
  }
}
