part of 'screens.dart';

class LetterDetailScreen extends StatelessWidget {
  static String routeName = '/letter_detail_screen';

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
                        _HeaderDetailComponent(),
                        SizedBox(
                          height: 24,
                        ),
                        _LetterDetailComponent(),
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

class _HeaderDetailComponent extends StatelessWidget {
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
              "Surat Izin",
              style: boldWhiteFont.copyWith(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _LetterDetailComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RouteArgument argument = ModalRoute.of(context).settings.arguments;

    return Container(
      width: deviceWidth(context),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            argument.letter.title,
            style: boldBlackFont.copyWith(fontSize: 18),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            argument.letter.type,
            style: semiBlackFont.copyWith(
              fontSize: 14,
              color: Color(0xFFC6C6C6),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Row(
            children: [
              Text(
                "Dari, ",
                style: semiBlackFont.copyWith(fontSize: 14),
              ),
              Text(
                argument.letter.sender,
                style: boldBlackFont.copyWith(fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                "Tanggal Mulai:",
                style: semiBlackFont.copyWith(fontSize: 14),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                argument.letter.startDate,
                style: boldBlackFont.copyWith(fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            height: 9,
          ),
          Row(
            children: [
              Text(
                "Tanggal Akhir:",
                style: semiBlackFont.copyWith(fontSize: 14),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                argument.letter.endDate,
                style: boldBlackFont.copyWith(fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            argument.letter.body,
            style: semiBlackFont.copyWith(
              fontSize: 14,
              color: Color(0xFF555555),
              height: 1.6,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          if (argument.letter.attachmentURL != null) Material(
            child: Ink(
              decoration: BoxDecoration(
                color: Color(0xFFEBEBEF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () async {
                  await launch(argument.letter.attachmentURL);
                },
                splashColor: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: deviceWidth(context) - 2 * 40,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidFile,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Text(
                        "Lampiran File",
                        style: semiBlackFont.copyWith(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      FaIcon(
                        FontAwesomeIcons.solidEnvelopeOpen,
                        color: primaryColor,
                        size: 23,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}