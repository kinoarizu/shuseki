part of 'models.dart';

class Auth {
  String nidk;
  String name;
  String email;
  String password;
  File photo;
  List<String> imei;
  List<String> coordinate;

  Auth({
    this.nidk = "",
    this.name = "",
    this.email = "",
    this.password = "",
    this.photo,
    this.imei = const [],
    this.coordinate = const [],
  });
}