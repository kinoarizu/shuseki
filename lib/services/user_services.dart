part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');

  static Future<void> updateUser(User user) async {
    await _userCollection.doc(user.id).set({
      'nidk': user.nidk,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'imei': user.imei,
      'coordinate': user.coordinate,
    });
  }

  static Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();

    return User(
      id: id,
      nidk: snapshot.data()['nidk'],
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      photoURL: snapshot.data()['photoURL'],
      imei: (snapshot.data()['imei'] as List).map((e) => e.toString()).toList(),
      coordinate: (snapshot.data()['coordinate'] as List).map((e) => e.toString()).toList(),
    );
  }

  static Future<bool> isEmailExists(String email) async {
    QuerySnapshot snapshot = await _userCollection.where('email', isEqualTo: email).limit(1).get();
    List<DocumentSnapshot> documents = snapshot.docs;

    return documents.length == 1;
  }

  static Future<bool> isImeiMatch(String email) async {
    List<String> getImeiMulti = await ImeiPlugin.getImeiMulti();

    QuerySnapshot snapshot = await _userCollection.where('imei', arrayContainsAny: getImeiMulti).limit(1).get();
    List<DocumentSnapshot> documents = snapshot.docs;

    return documents.length == 1;
  }
}