part of 'models.dart';

class History extends Equatable {
  final String userID;
  final String userName;
  final String userPhoto;
  final int absentCheckIn;
  final int absentCheckOut;

  History({
    this.userID,
    this.userName,
    this.userPhoto,
    this.absentCheckIn,
    this.absentCheckOut,
  });

  History copyWith({int absentCheckOut}) => History(
    userID: this.userID,
    userName: this.userName,
    userPhoto: this.userPhoto,
    absentCheckIn: this.absentCheckIn,
    absentCheckOut: absentCheckOut,
  );

  @override
  List<Object> get props => [userID, userName, userPhoto, absentCheckIn, absentCheckOut];
}
