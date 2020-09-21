part of 'screens.dart';

class HistoryScreen extends StatelessWidget {
  static String routeName = '/history_screen';

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
                        _HeaderHistoryComponent(),
                        SizedBox(
                          height: 24,
                        ),
                        _HistoryListComponent(),
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

class _HeaderHistoryComponent extends StatelessWidget {
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
              "Riwayat Absensi",
              style: boldWhiteFont.copyWith(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryListComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (context, historyProvider, _) {
        if (historyProvider.histories.length == 0) {
          return Container(
            width: deviceWidth(context),
            margin: EdgeInsets.symmetric(
              horizontal: defaultMargin,
              vertical: 220,
            ),
            child: Center(
              child: Text(
                "Tidak Ada Riwayat Kehadiran",
                style: semiBlackFont.copyWith(fontSize: 12),
              ),
            ),
          );
        }
        
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
            Container(
              height: (historyProvider.histories.length * 90).toDouble(),
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
                itemCount: historyProvider.histories.length,
                itemBuilder: (context, index) => _HistoryComponent(
                  userName: historyProvider.histories[index].userName,
                  userPhoto: historyProvider.histories[index].userPhoto,
                  absentCheckIn: historyProvider.histories[index].absentCheckIn,
                  absentCheckOut: historyProvider.histories[index].absentCheckOut ?? 0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _HistoryComponent extends StatelessWidget {
  final String userName;
  final String userPhoto;
  final int absentCheckIn;
  final int absentCheckOut;

  _HistoryComponent({this.userName, this.userPhoto, this.absentCheckIn, this.absentCheckOut});

  @override
  Widget build(BuildContext context) {
    String checkInTime =  DateFormat('hh : mm WIB').format(DateTime.fromMillisecondsSinceEpoch(absentCheckIn));
    String checkOutTime =  DateFormat('hh : mm WIB').format(DateTime.fromMillisecondsSinceEpoch(absentCheckOut));
    DateTime dateCheckIn = DateTime.fromMillisecondsSinceEpoch(absentCheckIn);
    DateTime dateCheckOut = DateTime.fromMillisecondsSinceEpoch(absentCheckOut);

    return Container(
      width: deviceWidth(context),
      padding: EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 16,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (userPhoto == null) ClipOval(
            child: Image.asset(
              'assets/images/avatar.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          )
          else ClipOval(
            child: Image.network(
              userPhoto,
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
                    "$checkInTime, ${dateCheckIn.day} ${dateCheckIn.monthName} ${dateCheckIn.year}",
                    style: semiBlackFont.copyWith(
                      fontSize: 11,
                    ),
                  ),
                ],
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
                        "Pulang",
                        style: boldWhiteFont.copyWith(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    (absentCheckOut == 0) ? '-' : "$checkOutTime, ${dateCheckOut.day} ${dateCheckOut.monthName} ${dateCheckOut.year}",
                    style: semiBlackFont.copyWith(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
