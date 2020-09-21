part of 'screens.dart';

class Wrapper extends StatelessWidget {
  static String routeName = '/wrapper';

  @override
  Widget build(BuildContext context) {
    auth.User firebaseUser = Provider.of<auth.User>(context);

    if (firebaseUser == null) {
      return Scaffold(
        body: LoginScreen(),
      );
    }
    else {
      Provider.of<UserProvider>(context).loadUser(firebaseUser.uid);
      Provider.of<PresenceProvider>(context).getPresence(firebaseUser.uid);
      Provider.of<HistoryProvider>(context).loadHistory(firebaseUser.uid);

      return Scaffold(
        body: MainScreen(),
      );
    }
  }
}
