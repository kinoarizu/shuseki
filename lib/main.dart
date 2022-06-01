import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'common/colors.dart';
import 'screens/splash_screen.dart';
import 'utils/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics();
    return MaterialApp(
      title: "GoAbsensi",
      home: SplashScreen(),
      routes: appRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
    );
  }
}
