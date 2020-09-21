part of 'models.dart';

class RouteArgument {
  final Auth auth;
  final User user;
  final Success success;
  final Letter letter;

  RouteArgument({
    this.auth,
    this.user,
    this.success,
    this.letter,
  });
}