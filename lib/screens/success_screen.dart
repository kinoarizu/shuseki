part of 'screens.dart';

class SuccessScreen extends StatelessWidget {
  static String routeName = '/success_screen';

  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      onWillPop: () async {
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: screenColor,
            ),
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      margin: EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(argument.success.illustrationImage),
                        ),
                      ),
                    ),
                    Text(
                      argument.success.title,
                      style: semiBlackFont.copyWith(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      argument.success.subtitle,
                      textAlign: TextAlign.center,
                      style: lightBlackFont.copyWith(fontSize: 14),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomRaisedButton(
                      "Dashboard Saya",
                      width: 200,
                      color: primaryColor,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, argument.success.nextRoute);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}