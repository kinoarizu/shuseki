part of 'utils.dart';

Future<List<String>> getPosition() async {
  Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  
  return [position.latitude.toString(), position.longitude.toString()];
}

Future<bool> isFakeGPS() async {
  await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  
  bool isMockLocation = await TrustLocation.isMockLocation;

  return isMockLocation;
}

Future<bool> onRadiusDistance() async {
  Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  double startLatPoint = -6.261000;
  double startLongPoint = 106.980000;

  double endLatPoint = -6.261999;
  double endLongPoint = 106.980999;

  bool onLatRadius = position.latitude <= startLatPoint && position.latitude >= endLatPoint;
  bool onLongRadius = position.longitude >= startLongPoint && position.longitude <= endLongPoint;

  print(position.latitude.toString() + ', ' + position.longitude.toString());

  return onLatRadius && onLongRadius;
}