part of 'screens.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();

  static String routeName = '/splash_screen';
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() { 
    super.initState();
    splashTimer(context);
  }

  splashTimer(BuildContext context) async {
    return Timer(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, Wrapper.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 130,
              height: 130,
              margin: EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/secondary_logo.png"),
                ),
              ),
            ),
            Text(
              "GoAbsensi",
              style: extraWhiteFont.copyWith(fontSize: 28),
            ),
          ],
        ),
      ),
    );
  }
}
