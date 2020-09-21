part of 'screens.dart';

class CheckInScreen extends StatelessWidget {
  static String routeName = '/check_in_screen';

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
              color: primaryColor,
            ),
            SafeArea(
              child: Stack(
                children: [
                  Container(
                    color: screenColor,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        _HeaderCheckInComponent(),
                        SizedBox(
                          height: 24,
                        ),
                        _MethodCheckInComponent(),
                        SizedBox(
                          height: 24,
                        ),
                        _ActivityCheckInComponent(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCheckInComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context),
      height: 88,
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 34,
              height: 34,
              child: RaisedButton(
                color: maroonColor,
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                padding: EdgeInsets.zero,
                splashColor: Colors.black.withOpacity(0.3),
                visualDensity: VisualDensity.comfortable,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: whiteColor,
                  size: 18,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Center(
            child: Text(
              "Absen Masuk",
              style: boldWhiteFont.copyWith(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _MethodCheckInComponent extends StatefulWidget {
  @override
  _MethodCheckInComponentState createState() => _MethodCheckInComponentState();
}

class _MethodCheckInComponentState extends State<_MethodCheckInComponent> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: defaultMargin),
          child: Text(
            "Pilih Metode Absen",
            style: semiBlackFont.copyWith(fontSize: 14),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        if (isClicked) Padding(
          padding: const EdgeInsets.symmetric(vertical: 53),
          child: SpinKitFadingCircle(
            color: primaryColor,
            size: 70,
          ),
        )
        else Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _MethodComponent(
              methodName: "One Click",
              iconPath: 'assets/images/one_click.png',
              onTap: () async {
                setState(() {
                  isClicked = true;
                });

                bool isWorkTime = await isCheckInTime();
                bool isFakeLocation = await isFakeGPS();
                bool onOfficeRadius = await onRadiusDistance();
                String absentStatus = await getAbsentStatus();

                if (absentStatus == "CHECK-IN") {
                  setState(() {
                    isClicked = false;
                  });

                  showAlert(
                    context,
                    alert: CustomAlertDialog(
                      title: "Sudah Absen Masuk",
                      description: "Kamu sudah melakukan absen masuk untuk hari ini...",
                      imagePath: 'assets/images/out_worktime.png',
                    ),
                  );
                } else if (!isWorkTime) {
                  setState(() {
                    isClicked = false;
                  });

                  showAlert(
                    context,
                    alert: CustomAlertDialog(
                      title: "Diluar Waktu Kerja",
                      description: "Lakukan absen masuk pada waktu yang ditentukan...",
                      imagePath: 'assets/images/out_worktime.png',
                    ),
                  );
                } else if (isFakeLocation) {
                  setState(() {
                    isClicked = false;
                  });

                  showAlert(
                    context,
                    alert: CustomAlertDialog(
                      title: "Fake GPS Terdeteksi",
                      description: "Hayoo... kamu menggunakan Fake GPS! Silahkan pakai GPS yang asli..",
                      imagePath: 'assets/images/fake_gps.png',
                    ),
                  );
                } else if (!onOfficeRadius) {
                  setState(() {
                    isClicked = false;
                  });

                  showAlert(
                    context,
                    alert: CustomAlertDialog(
                      title: "Belum Berada Di Kantor",
                      description: "Pastikan kamu sudah berada di kantor jika ingin absensi..",
                      imagePath: 'assets/images/radius_office.png',
                    ),
                  );
                } else {
                  User user = Provider.of<UserProvider>(context, listen: false).user;

                  await setAbsentStatus("CHECK-IN");

                  Absent absentData = Absent(
                    userID: user.id,
                    userName: user.name,
                    userPhoto: user.photoURL,
                    absentTime: DateTime.now(),
                    absentType: 'CHECK-IN',
                  );

                  History historyData = History(
                    userID: user.id,
                    userName: user.name,
                    userPhoto: user.photoURL,
                    absentCheckIn: DateTime.now().millisecondsSinceEpoch,
                  );

                  await AbsentServices.storeAbsentCollection(absentData);

                  await AbsentServices.storeAbsentDatabase(absentData);

                  Provider.of<HistoryProvider>(context, listen: false).storeHistory(historyData);

                  Navigator.pushReplacementNamed(context, SuccessScreen.routeName,
                    arguments: RouteArgument(
                      success: Success(
                        title: "Absensi Berhasil",
                        subtitle: "Berhasil melakukan absensi Check-In",
                        illustrationImage: 'assets/images/success_register.png',
                        nextRoute: MainScreen.routeName,
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              width: defaultMargin
            ),
            _MethodComponent(
              methodName: "Scan QR",
              iconPath: 'assets/images/scan_qr.png',
              onTap: () async {
                String absentStatus = await getAbsentStatus();
                String scanResult = await scanner.scan();

                if (absentStatus == "CHECK-IN") {
                  showAlert(
                    context,
                    alert: CustomAlertDialog(
                      title: "Sudah Absen Masuk",
                      description: "Kamu sudah melakukan absen masuk untuk hari ini...",
                      imagePath: 'assets/images/out_worktime.png',
                    ),
                  );
                } else if (scanResult != 'CHECK-IN') {
                  showAlert(
                    context,
                    alert: CustomAlertDialog(
                      title: "Barcode Tidak Valid",
                      description: "Lakukan scanning pada barcode bar di kantor kamu...",
                      imagePath: 'assets/images/access_denied.png',
                    ),
                  );
                } else {
                  if (scanResult != null) {
                    setState(() {
                      isClicked = true;
                    });
                  }

                  User user = Provider.of<UserProvider>(context, listen: false).user;

                  await setAbsentStatus("CHECK-IN");

                  Absent absentData = Absent(
                    userID: user.id,
                    userName: user.name,
                    userPhoto: user.photoURL,
                    absentTime: DateTime.now(),
                    absentType: 'CHECK-IN',
                  );

                  History historyData = History(
                    userID: user.id,
                    userName: user.name,
                    userPhoto: user.photoURL,
                    absentCheckIn: DateTime.now().millisecondsSinceEpoch,
                  );

                  await AbsentServices.storeAbsentCollection(absentData);

                  await AbsentServices.storeAbsentDatabase(absentData);

                  Provider.of<HistoryProvider>(context, listen: false).storeHistory(historyData);

                  Navigator.pushReplacementNamed(context, SuccessScreen.routeName,
                    arguments: RouteArgument(
                      success: Success(
                        title: "Absensi Berhasil",
                        subtitle: "Berhasil melakukan absensi Check-In",
                        illustrationImage: 'assets/images/success_register.png',
                        nextRoute: MainScreen.routeName,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _MethodComponent extends StatelessWidget {
  final String methodName;
  final String iconPath;
  final Function onTap;

  _MethodComponent({this.methodName, this.iconPath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context) / 2 - 1.5 * defaultMargin,
      height: 187,
      child: RaisedButton(
        onPressed: onTap,
        color: primaryColor,
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        splashColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              margin: EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    iconPath,
                  ),
                ),
              ),
            ),
            Text(
              methodName,
              style: boldWhiteFont.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityCheckInComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: defaultMargin),
          child: Text(
            "Aktivitas Kehadiran Terkini",
            textAlign: TextAlign.left,
            style: semiBlackFont.copyWith(fontSize: 14),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        StreamBuilder(
          stream: AbsentServices.absentDatabase.onValue,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              List items = [];

              DataSnapshot dataValues = snapshot.data.snapshot;
              Map<dynamic, dynamic> values = dataValues.value;

              if (values == null) {
                return Container(
                  width: deviceWidth(context),
                  margin: EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                    vertical: 84,
                  ),
                  child: Center(
                    child: Text(
                      "Tidak Ada Aktivitas Kehadiran",
                      style: semiBlackFont.copyWith(fontSize: 12),
                    ),
                  ),
                );
              }

              values.forEach((key, values) {
                items.add(values);
              });

              return Container(
                height: (items.length * 74).toDouble(),
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFEEEEEE),
                      width: 3,
                      style: BorderStyle.solid,
                    ),
                    left: BorderSide(
                      color: Color(0xFFEEEEEE),
                      width: 3,
                      style: BorderStyle.solid,
                    ),
                    right: BorderSide(
                      color: Color(0xFFEEEEEE),
                      width: 3,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: items.length,
                  itemBuilder: (context, index) => _UserCheckInComponent(
                    userName: items[index]['userName'],
                    absentTime: items[index]['absentTime'],
                    photoURL: items[index]['userPhoto'],
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 84),
                child: SpinKitFadingCircle(
                  color: primaryColor,
                  size: 50,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class _UserCheckInComponent extends StatelessWidget {
  final String userName;
  final int absentTime;
  final String photoURL;

  _UserCheckInComponent({this.userName, this.absentTime, this.photoURL});
  
  @override
  Widget build(BuildContext context) {
    String time =  DateFormat('hh : mm : ss').format(DateTime.fromMillisecondsSinceEpoch(absentTime));

    return Container(
      width: deviceWidth(context),
      height: 74,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEBEBEF),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (photoURL == null) ClipOval(
            child: Image.asset(
              'assets/images/avatar.png',
              width: 46,
              height: 46,
              fit: BoxFit.cover,
            ),
          )
          else ClipOval(
            child: Image.network(
              photoURL,
              width: 46,
              height: 46,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return SpinKitFadingCircle(
                  color: primaryColor,
                );
              },
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userName,
                style: semiBlackFont.copyWith(fontSize: 13),
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 42,
                    height: 14,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Center(
                      child: Text(
                        "Masuk",
                        style: boldWhiteFont.copyWith(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "$time WIB",
                    style: semiBlackFont.copyWith(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(
            flex: 1,
          ),
          Image.asset(
            'assets/images/entry.png',
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }
}