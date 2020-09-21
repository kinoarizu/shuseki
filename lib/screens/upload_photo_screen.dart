part of 'screens.dart';

class UploadPhotoScreen extends StatefulWidget {
  @override
  _UploadPhotoScreenState createState() => _UploadPhotoScreenState();

  static String routeName = '/upload_photo_screen';
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  bool isRegistering = false;

  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;

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
                child: Column(
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
                              "Upload Foto",
                              style: boldBlackFont.copyWith(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 90,
                    ),
                    Container(
                      width: 150,
                      height: 170,
                      margin: EdgeInsets.only(bottom: 20),
                      child: Stack(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: (argument.auth.photo == null) ? 15 : 0,
                                color: primaryColor,
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: (argument.auth.photo == null) ? AssetImage("assets/images/user_pic.png") : FileImage(argument.auth.photo),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                                if (argument.auth.photo == null) {
                                  argument.auth.photo = await getImage();
                                } else {
                                  argument.auth.photo = null;
                                }
                                setState(() {});
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      (argument.auth.photo == null) ? "assets/images/btn_add_photo.png" : "assets/images/btn_del_photo.png",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Selamat Datang",
                      style: semiBlackFont.copyWith(fontSize: 18),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      argument.auth.name,
                      style: boldBlackFont.copyWith(fontSize: 18),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    if (isRegistering) SpinKitWave(
                      size: 50,
                      color: primaryColor,
                    )
                    else CustomRaisedButton(
                      "Register Sekarang",
                      color: primaryColor,
                      onPressed: () async {

                        /// Set isRegistering be 'true' to display loading wave
                        setState(() {
                          isRegistering = true;
                        });
                        
                        /// Set variable upload image from route argument
                        imageFileToUpload = argument.auth.photo;
                        
                        /// Get single/multi imei devices in array list
                        List<String> multiImei = await ImeiPlugin.getImeiMulti(
                          shouldShowRequestPermissionRationale: false,
                        );
                        
                        /// Get current device position data (GPS required)
                        List<String> coordinate = await getPosition();

                        /// Call auth services to storing auth data
                        ResponseHandler result = await AuthServices.register(
                          Auth(
                            nidk: argument.auth.nidk,
                            name: argument.auth.name,
                            email: argument.auth.email,
                            password: argument.auth.password,
                            imei: multiImei,
                            coordinate: coordinate,
                          ),
                        );

                        /// Checking if user failed or success to store 
                        /// (it will receive response message if failed)
                        if (result.user == null) {
                          setState(() {
                            isRegistering = false;
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
                          Provider.of<ValidationProvider>(context, listen: false).resetChange();

                          /// Set presence data
                          await PresenceServices.updatePresence(result.user.id, Presence(0, 0, 0, 0));

                          /// Redirect to main screen
                          Navigator.pushReplacementNamed(context, Wrapper.routeName);
                        }

                      },
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
          ],
        ),
      ),
    );
  }
}