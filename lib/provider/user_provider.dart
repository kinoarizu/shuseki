part of 'provider.dart';

class UserProvider extends ChangeNotifier {
  User _user;

  User get user => _user;

  void loadUser(String id) async {
    _user = await UserServices.getUser(id);

    notifyListeners();
  }

  void updateUser({String name, String photoURL}) async {
    _user = user.copyWith(
      name: name,
      photoURL: photoURL,
    );

    await UserServices.updateUser(_user);

    notifyListeners();
  }
}