part of 'models.dart';

class Letter extends Equatable {
  final String title;
  final String type;
  final String sender;
  final String startDate;
  final String endDate;
  final String body;
  final String attachmentURL;
  final int timestamp;

  Letter({
    this.title,
    this.type,
    this.sender,
    this.startDate,
    this.endDate,
    this.body,
    this.attachmentURL,
    this.timestamp,
  });

  Letter copyWith(String attachmentURL) => Letter(
    title: this.title,
    type: this.type,
    sender: this.sender,
    startDate: this.startDate,
    endDate: this.endDate,
    body: this.body,
    attachmentURL: attachmentURL,
    timestamp: this.timestamp,
  );

  @override
  List<Object> get props => [
    title,
    type,
    sender,
    startDate,
    endDate,
    body,
    attachmentURL,
    timestamp,
  ];
}
