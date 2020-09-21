part of 'utils.dart';

Future<String> getAbsentStatus() async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString('absentStatus');
}

Future<bool> setAbsentStatus(String value) async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.setString('absentStatus', value);
}