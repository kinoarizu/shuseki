part of 'services.dart';

class PresenceServices {
  static CollectionReference _presenceReference = FirebaseFirestore.instance.collection('presences');

  static Future<Presence> getPresence(String userID) async {
    DocumentSnapshot snapshot = await _presenceReference.doc(userID).get();

    return Presence(
      snapshot.data()['total'],
      snapshot.data()['sick'],
      snapshot.data()['permit'],
      snapshot.data()['alpha'],
    );
  }

  static Future<void> updatePresence(String userID, Presence presence) async {
    await _presenceReference.doc(userID).set({
      'total': presence.total,
      'sick': presence.sick,
      'permit': presence.permit,
      'alpha': presence.alpha,
    });
  }
}