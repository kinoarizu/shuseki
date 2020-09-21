part of 'screens.dart';

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

    final isValidEmail = Provider.of<ValidationProvider>(context).errorEmail == "";
    final isValidPassword = Provider.of<ValidationProvider>(context).errorPassword == "";

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
                child: Consumer<ValidationProvider>(
                  builder: (context, validation, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 70,
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
                        height: 40,
                      ),
                      CustomTextField(
                        labelText: "Email Address",
                        hintText: "Masukan Email",
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        errorValidation: validation.errorEmail,
                        onChanged: (text) {
                          validation.changeEmail(text);
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        obscureText: !isHidePassword,
                        labelText: "Password",
                        hintText: "Masukan Password",
                        controller: passwordController,
                        errorValidation: validation.errorPassword,
                        onChanged: (text) {
                          validation.changePassword(text);
                        },
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
                        color: (isValidEmail && isValidPassword) ? primaryColor : Color(0xFFCDCBCB),
                        onPressed: (isValidEmail && isValidPassword) ? () async {
                          
                          /// Set isLogining be 'true' to show loading wave
                          setState(() {
                            isLogining = true;
                          });

                          /// Call auth services to check auth data
                          ResponseHandler result = await AuthServices.logIn(
                            Auth(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );

                          /// Checking if user failed or success to check 
                          /// (it will receive response message if failed)
                          if (result.user == null) {
                            setState(() {
                              isLogining = false;
                            });

                            showAlert(
                              context,
                              alert: CustomAlertDialog(
                                title: generateAuthMessage(result.message).title,
                                description: generateAuthMessage(result.message).message,
                                imagePath: generateAuthMessage(result.message).illustration,
                              ),
                            );
                          } else {
                            /// Reset validation state
                            validation.resetChange();
                          }
                          
                        } : null,
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
                                "Buat Akun",
                                style: semiGreyFont.copyWith(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                              onTap: () {
                                validation.resetChange();
                                Navigator.pushNamed(context, RegisterScreen.routeName, 
                                  arguments: RouteArgument(auth: Auth()),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Material(
                            child: InkWell(
                              splashColor: Colors.black.withOpacity(0.3),
                              child: Text(
                                "Ganti Password",
                                style: semiGreyFont.copyWith(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                              onTap: () async {
                                if (emailController.text == "") {
                                  Fluttertoast.showToast(
                                    msg: "Masukan Email Anda Terlebih Dahulu",
                                  );
                                } else {
                                  ResponseHandler result = await AuthServices.resetPassword(emailController.text);

                                  if (result.message != null) {
                                    showAlert(
                                      context,
                                      alert: CustomAlertDialog(
                                        title: generateAuthMessage(result.message).title,
                                        description: generateAuthMessage(result.message).message,
                                        imagePath: generateAuthMessage(result.message).illustration,
                                      ),
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Silahkan Periksa Inbox Email Anda",
                                    );
                                  }
                                }
                              },
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
            ),
          ],
        ),
      ),
    );
  }
}
