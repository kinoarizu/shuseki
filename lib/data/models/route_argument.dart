import 'auth.dart';
import 'user.dart';

class RouteArgument {
  final Auth auth;
  final User user;

  RouteArgument({
    this.auth,
    this.user,
  });
}