part of 'provider.dart';

class PresenceProvider extends ChangeNotifier {
  Presence _presence;

  Presence get presence => _presence;

  void getPresence(String userID) async {
    _presence = await PresenceServices.getPresence(userID);

    notifyListeners();
  }

  void updateTotal(String userID) async {
    _presence = presence.copyWith(total: _presence.total + 1);

    await PresenceServices.updatePresence(userID, _presence);

    notifyListeners();
  }

  void updateSick(String userID) async {
    _presence = presence.copyWith(sick: _presence.sick + 1);

    await PresenceServices.updatePresence(userID, _presence);

    notifyListeners();
  }

  void updatePermit(String userID) async {
    _presence = presence.copyWith(permit: _presence.permit + 1);

    await PresenceServices.updatePresence(userID, _presence);

    notifyListeners();
  }

  void updateAlpha(String userID) async {
    _presence = presence.copyWith(alpha: _presence.alpha + 1);

    await PresenceServices.updatePresence(userID, _presence);

    notifyListeners();
  }
}