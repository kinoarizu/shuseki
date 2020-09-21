part of 'screens.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();

  static String routeName = '/register_screen';
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController nidkController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();

  bool isHidePassword = false;
  bool isHidePasswordConfirmation = false;

  @override
  void initState() { 
    super.initState();

    Future.delayed(Duration.zero, () {
      final RouteArgument argument = ModalRoute.of(context).settings.arguments;

      nidkController.text = argument.auth.nidk;
      nameController.text = argument.auth.name;
      emailController.text = argument.auth.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
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
                        height: 30,
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Material(
                              child: InkWell(
                                splashColor: Colors.black.withOpacity(0.3),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.arrowLeft,
                                    color: darkColor,
                                    size: 22,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);  
                                  validation.resetChange();                      
                                },
                              )
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 6,
                              ),
                              child: Text(
                                "Buat Akun",
                                style: boldBlackFont.copyWith(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      CustomTextField(
                        labelText: "NIDK",
                        hintText: "Masukan NIDK",
                        keyboardType: TextInputType.number,
                        controller: nidkController,
                        errorValidation: validation.errorNIDK,
                        onChanged: (value) {
                          validation.changeNIDK(value);
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        labelText: "Nama Lengkap",
                        hintText: "Masukan Nama Lengkap",
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        errorValidation: validation.errorName,
                        onChanged: (value) {
                          validation.changeName(value);
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        labelText: "Email Address",
                        hintText: "Masukan Email",
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        errorValidation: validation.errorEmail,
                        onChanged: (value) {
                          validation.changeEmail(value);
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
                        onChanged: (value) {
                          validation.changePassword(value);
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
                        height: 16,
                      ),
                      CustomTextField(
                        obscureText: !isHidePasswordConfirmation,
                        labelText: "Konfirmasi Password",
                        hintText: "Masukan Konfirmasi Password",
                        controller: passwordConfirmationController,
                        errorValidation: validation.errorPasswordConfirmation,
                        onChanged: (value) {
                          validation.changePasswordConfirmation(value, passwordController.text);
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isHidePasswordConfirmation = !isHidePasswordConfirmation;
                            });
                          },
                          child: Theme(
                            data: Theme.of(context).copyWith(primaryColor: null),
                            child: (!isHidePasswordConfirmation) ? Icon(
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
                      CustomRaisedButton(
                        "Selanjutnya",
                        color: (validation.isAllValidate()) ? primaryColor : Color(0xFFCDCBCB),
                        onPressed: (validation.isAllValidate()) ? () async {
                          Navigator.pushNamed(context, UploadPhotoScreen.routeName,
                            arguments: RouteArgument(
                              auth: Auth(
                                nidk: nidkController.text,
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            ),
                          );
                        } : null,
                      ),
                      SizedBox(
                        height: 30,
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