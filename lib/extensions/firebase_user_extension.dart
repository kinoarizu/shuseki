part of 'extensions.dart';

extension FirebaseUserExtension on auth.User {
  User convertToUser({
    String nidk = "",
    String name = "No Name",
    List<String> imei = const [],
    List<String> coordinate = const [],
  }) {
    return User(
      id: this.uid,
      email: this.email,
      nidk: nidk,
      name: name,
      imei: imei,
      coordinate: coordinate,
    );
  }

  Future<User> fromFireStore() async => await UserServices.getUser(this.uid);
}
