part of 'screens.dart';

class LetterFormScreen extends StatelessWidget {
  static String routeName = '/letter_form_screen';

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
                        _HeaderFormComponent(),
                        SizedBox(
                          height: 24,
                        ),
                        _InputFieldComponent(),
                        SizedBox(
                          height: 32,
                        ),
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

class _HeaderFormComponent extends StatelessWidget {
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
              "Buat Surat Izin",
              style: boldWhiteFont.copyWith(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _InputFieldComponent extends StatefulWidget {
  @override
  __InputFieldComponentState createState() => __InputFieldComponentState();
}

class __InputFieldComponentState extends State<_InputFieldComponent> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  DateTime startDate;
  DateTime endDate;
  String startDateParse;
  String endDateParse;
  String permitType;
  File letterFile;

  bool isSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: titleController,
            labelText: "Judul",
            hintText: "Masukan Judul",
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 16,
          ),
          CustomDatePicker(
            labelText: "Tanggal Mulai",
            hintText: (startDate == null) ? "Pilih Tanggal Mulai" : startDateParse,
            hintColor: (startDate == null) ? Color(0xFFC6C6C6) : darkColor,
            iconColor: (startDate == null) ? Color(0xFFC6C6C6) : darkColor,
            onTap: () async {
              startDate = await pickDate(context);
              startDateParse = startDate.dayName + ", " + DateFormat('dd/MM/yy').format(startDate);
              setState(() {});
            },
          ),
          SizedBox(
            height: 16,
          ),
          CustomDatePicker(
            labelText: "Tanggal Akhir",
            hintText: (endDate == null) ? "Pilih Tanggal Akhir" : endDateParse,
            hintColor: (endDate == null) ? Color(0xFFC6C6C6) : darkColor,
            iconColor: (endDate == null) ? Color(0xFFC6C6C6) : darkColor,
            onTap: () async {
              endDate = await pickDate(context);
              endDateParse = endDate.dayName + ", " + DateFormat('dd/MM/yy').format(endDate);
              setState(() {});
            },
          ),
          SizedBox(
            height: 16,
          ),
          CustomDropdownField(
            onChanged: (String permit) {
              setState(() {
                permitType = permit;
              });
            },
          ),
          SizedBox(
            height: 16,
          ),
          CustomTextField(
            controller: noteController,
            labelText: "Isi",
            hintText: "Masukan Isi",
            maxLines: 7,
            keyboardType: TextInputType.text,
            onChanged: (text) {
              setState(() {});
            },
          ),
          SizedBox(
            height: 16,
          ),
          CustomFilePicker(
            hintText: (letterFile == null) ? "Pilih File" : letterFile.path.split('/').last,
            hintColor: (letterFile == null) ? Color(0xFFC6C6C6) : darkColor,
            onTap: () async {
              if (letterFile == null) {
                letterFile = await pickFile();
              } else {
                letterFile = null;
              }
              setState(() {});
            },
          ),
          SizedBox(
            height: 24,
          ),
          if (noteController.text.trim() == "") CustomRaisedButton(
            "Publish Surat",
            color: primaryColor,
            onPressed: null,
          )
          else (isSubmit) ? SpinKitWave(color: primaryColor, size: 40) : CustomRaisedButton(
            "Publish Surat",
            color: primaryColor,
            onPressed: () async {
              /// Set to show loading bar wave
              setState(() {
                isSubmit = true;
              });

              /// Get current from user provider
              User user = Provider.of<UserProvider>(context, listen: false).user;

              /// Update presence quantity
              switch (permitType) {
                case 'Sakit':
                  Provider.of<PresenceProvider>(context, listen: false).updateSick(user.id);
                  break;
                case 'Izin':
                  Provider.of<PresenceProvider>(context, listen: false).updatePermit(user.id);
                  break;
                default:
                  Provider.of<PresenceProvider>(context, listen: false).updateAlpha(user.id);
              }

              /// Check if has letter file
              if (letterFile != null) {
                letterFileToUpload = letterFile;
                String downloadURL = await uploadFile(letterFileToUpload);

                /// Set letter model data to stored
                Letter letter = Letter(
                  title: titleController.text ?? "-",
                  type: permitType ?? "-",
                  startDate: startDateParse ?? "-",
                  endDate: endDateParse ?? "-",
                  sender: user.name,
                  body: noteController.text,
                  timestamp: DateTime.now().millisecondsSinceEpoch,
                  attachmentURL: downloadURL,
                );
                
                /// Call service function to firestore
                await LetterServices.storeLetter(letter);
              } 
              else {
                /// Set letter model data to stored
                Letter letter = Letter(
                  title: titleController.text ?? "-",
                  type: permitType ?? "-",
                  startDate: startDateParse ?? "-",
                  endDate: endDateParse ?? "-",
                  sender: user.name,
                  body: noteController.text,
                  timestamp: DateTime.now().millisecondsSinceEpoch,
                );

                /// Call service function to firestore
                await LetterServices.storeLetter(letter);
              }

              /// Push notification about new letter to all users
              pushNotification(
                heading: "1 Surat Baru Belum Dibaca",
                content: "Dikirim oleh ${user.name}",
              );

              /// Push screen to success state
              Navigator.pushReplacementNamed(context, SuccessScreen.routeName,
                arguments: RouteArgument(
                  success: Success(
                    title: "Berhasil Publish",
                    subtitle: "Selamat, Surat anda berhasil dipublish...",
                    illustrationImage: 'assets/images/success_register.png',
                    nextRoute: PermitLetterScreen.routeName,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}