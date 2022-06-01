import 'package:shared_preferences/shared_preferences.dart';

Future<String> getAbsentStatus() async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString('absentStatus');
}

Future<bool> setAbsentStatus(String value) async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.setString('absentStatus', value);
}