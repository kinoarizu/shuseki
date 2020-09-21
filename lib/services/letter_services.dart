part of 'services.dart';

class LetterServices {
  static CollectionReference _letterCollection = FirebaseFirestore.instance.collection('letters');

  static Future<List<Letter>> getLetters() async {
    QuerySnapshot snapshot = await _letterCollection.get();

    List<Letter> letters = [];

    for (var document in snapshot.docs) {
      letters.add(
        Letter(
          title: document.data()['title'],
          type: document.data()['type'],
          startDate: document.data()['startDate'],
          endDate: document.data()['endDate'],
          sender: document.data()['sender'],
          body: document.data()['body'],
          attachmentURL: document.data()['attachmentURL'],
          timestamp: document.data()['timestamp'],
        ),
      );
    }

    return letters;
  }

  static Future<void> storeLetter(Letter letterData) async {
    await _letterCollection.doc().set({
      'title': letterData.title,
      'type': letterData.type,
      'startDate': letterData.startDate,
      'endDate': letterData.endDate,
      'sender': letterData.sender,
      'body': letterData.body,
      'attachmentURL': letterData.attachmentURL,
      'timestamp': letterData.timestamp,
    });
  }
}