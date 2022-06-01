import 'package:flutter/material.dart';

import '../screens/check_in_screen.dart';
import '../screens/check_out_screen.dart';
import '../screens/history_screen.dart';
import '../screens/login_screen.dart';
import '../screens/main_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/wrapper.dart';

Map<String, WidgetBuilder> appRoute = {
  Wrapper.routeName: (context) => Wrapper(),
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  MainScreen.routeName: (context) => MainScreen(),
  CheckInScreen.routeName: (context) => CheckInScreen(),
  CheckOutScreen.routeName: (context) => CheckOutScreen(),
  HistoryScreen.routeName: (context) => HistoryScreen(),
};