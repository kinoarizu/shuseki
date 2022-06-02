import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../shared/common/colors.dart';
import '../../../shared/common/fonts.dart';
import '../../../shared/common/sizes.dart';
import '../widgets/custom_raised_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();

  static String routeName = '/login_screen';
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isHidePassword = false;
  bool isLogining = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    
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
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 120,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            margin: EdgeInsets.only(right: 14),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/primary_logo.png"),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "GoAbsensi",
                                style: boldBlackFont.copyWith(fontSize: 24),
                              ),
                              Text(
                                "Modern Presence App",
                                style: regularGreyFont.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      CustomTextField(
                        labelText: "Email Address",
                        hintText: "Masukan Email",
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        obscureText: !isHidePassword,
                        labelText: "Password",
                        hintText: "Masukan Password",
                        controller: passwordController,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isHidePassword = !isHidePassword;
                            });
                          },
                          child: Theme(
                            data: Theme.of(context).copyWith(primaryColor: null),
                            child: (!isHidePassword) ? Icon(
                              Icons.visibility_off,
                              size: 20,
                              color: Color(0xFFC6C6C6),
                            ) : Icon(
                              Icons.visibility,
                              size: 20,
                              color: Color(0xFFC6C6C6),
                            ),
                          )
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      if (isLogining) SpinKitWave(
                        color: primaryColor,
                        size: 50,
                      )
                      else CustomRaisedButton(
                        "Login",
                        textColor: whiteColor,
                        color: primaryColor,
                        onPressed: () async {},
                      ),
                      SizedBox(
                        height: 110,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            child: InkWell(
                              splashColor: Colors.black.withOpacity(0.3),
                              child: Text(
                                "Ganti Password",
                                style: semiGreyFont.copyWith(
                                  fontSize: 14,
                                  color: primaryColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              onTap: () async {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Secured Authentication GoAbsensi",
                        style: regularGreyFont.copyWith(fontSize: 12),
                      ),
                      SizedBox(
                        height: 35,
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
