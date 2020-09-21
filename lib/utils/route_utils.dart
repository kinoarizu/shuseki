part of 'utils.dart';

Map<String, WidgetBuilder> appRoute = {
  Wrapper.routeName: (context) => Wrapper(),
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  UploadPhotoScreen.routeName: (context) => UploadPhotoScreen(),
  MainScreen.routeName: (context) => MainScreen(),
  SuccessScreen.routeName: (context) => SuccessScreen(),
  CheckInScreen.routeName: (context) => CheckInScreen(),
  CheckOutScreen.routeName: (context) => CheckOutScreen(),
  HistoryScreen.routeName: (context) => HistoryScreen(),
  PermitLetterScreen.routeName: (context) => PermitLetterScreen(),
  LetterFormScreen.routeName: (context) => LetterFormScreen(),
  LetterDetailScreen.routeName: (context) => LetterDetailScreen(),
};