part of 'screens.dart';

class PermitLetterScreen extends StatelessWidget {
  static String routeName = '/permit_letter_screen';

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
                        _HeaderPermitComponent(),
                        SizedBox(
                          height: 24,
                        ),
                        _PermitListComponent(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
                bottom: 20,
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  backgroundColor: primaryColor,
                  child: FaIcon(
                    FontAwesomeIcons.solidEnvelope,
                    color: whiteColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, LetterFormScreen.routeName);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderPermitComponent extends StatelessWidget {
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
              "Perizinan",
              style: boldWhiteFont.copyWith(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _PermitListComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: defaultMargin),
          child: Text(
            "Bulan Ini",
            textAlign: TextAlign.left,
            style: semiBlackFont.copyWith(fontSize: 14),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        FutureBuilder(
          future: LetterServices.getLetters(),
          builder: (_, snapshot) { 
            if (snapshot.hasData) {
              List<Letter> letters = snapshot.data;

              if (letters.length == 0) {
                return Container(
                  width: deviceWidth(context),
                  margin: EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                    vertical: 180,
                  ),
                  child: Center(
                    child: Text(
                      "Belum Ada Surat Saat Ini",
                      style: semiBlackFont.copyWith(fontSize: 12),
                    ),
                  ),
                );
              }

              return Container(
                height: (letters.length * 75).toDouble(),
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
                  itemCount: letters.length,
                  itemBuilder: (context, index) => _PermitComponent(
                    userName: letters[index].sender,
                    letterTitle: letters[index].title,
                    letterTime: letters[index].timestamp,
                    onTap: () {
                      Navigator.pushNamed(context, LetterDetailScreen.routeName, 
                        arguments: RouteArgument(
                          letter: Letter(
                            title: letters[index].title,
                            type: letters[index].type,
                            startDate: letters[index].startDate,
                            endDate: letters[index].endDate,
                            sender: letters[index].sender,
                            body: letters[index].body,
                            timestamp: letters[index].timestamp,
                            attachmentURL: letters[index].attachmentURL,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return SpinKitFadingCircle(
                color: primaryColor,
                size: 50,
              );
            }
          },
        ),
      ],
    );
  }
}

class _PermitComponent extends StatelessWidget {
  final String userName;
  final String letterTitle;
  final int letterTime;
  final Function onTap;

  _PermitComponent({this.userName, this.letterTitle, this.letterTime, this.onTap});

  @override
  Widget build(BuildContext context) {
    String time =  DateFormat('dd/MM/yy').format(DateTime.fromMillisecondsSinceEpoch(letterTime));

    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: whiteColor,
        ),
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.black.withOpacity(0.1),
          child: Container(
            width: deviceWidth(context),
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFEBEBEF),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/message.png',
                  width: 42,
                  height: 42,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 18,
                ),
                SizedBox(
                  width: defaultWidth(context) - 2 * 24 - 42 - 18 - 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            userName,
                            style: boldBlackFont.copyWith(fontSize: 14),
                          ),
                          Text(
                            time,
                            style: semiBlackFont.copyWith(fontSize: 11),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        letterTitle,
                        style: semiGreyFont.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
