part of 'models.dart';

class User extends Equatable{
  final String id;
  final String nidk;
  final String name;
  final String email;
  final String photoURL;
  final List<String> imei;
  final List<String> coordinate;

  User({
    this.id,
    this.nidk,
    this.name,
    this.email,
    this.photoURL,
    this.imei,
    this.coordinate,
  });

  User copyWith({String name, String photoURL}) => User(
    id: this.id,
    nidk: this.nidk,
    name: name ?? this.name,
    email: this.email,
    photoURL: photoURL ?? this.photoURL,
    imei: this.imei,
    coordinate: this.coordinate,
  );

  @override
  List<Object> get props => [id, nidk, name, email, photoURL, imei, coordinate];
}