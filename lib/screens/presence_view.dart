part of 'screens.dart';

class PresenceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: deviceWidth(context),
            height: 140 - statusBarHeight(context),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 32,
              ),
              _HeaderPresenceComponent(),
              SizedBox(
                height: 32,
              ),
              _ClockPresenceComponent(),
              SizedBox(
                height: 24,
              ),
              _PresenceActivityComponent(),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderPresenceComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: defaultMargin,
        ),
        Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.only(right: 14),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/secondary_logo.png'),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Aktivitas Kehadiran",
              style: boldWhiteFont.copyWith(fontSize: 22),
            ),
            Text(
              "Realtime Presence App",
              style: regularWhiteFont.copyWith(fontSize: 11),
            ),
          ],
        ),
      ],
    );
  }
}

class _ClockPresenceComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 40,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFEEEEEE),
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/clock.png',
            width: 31,
            height: 31,
          ),
          SizedBox(
            width: 16,
          ),
          TimerBuilder.periodic(
            Duration(seconds: 1),
            builder: (context) {
              return Text(
                getSystemTime(),
                style: boldBlackFont.copyWith(
                  color: primaryColor,
                  fontSize: 24,
                ),
              );
            },
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            "WIB",
            style: boldBlackFont.copyWith(
              color: primaryColor,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class _PresenceActivityComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int startTimeToday = DateTime.now().subtract(Duration(hours: 12)).millisecondsSinceEpoch;
    int endTimeToday = DateTime.now().add(Duration(hours: 12)).millisecondsSinceEpoch;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: defaultMargin),
          child: Text(
            "Kehadiran Hari Ini",
            textAlign: TextAlign.left,
            style: semiBlackFont.copyWith(fontSize: 14),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        StreamBuilder(
          stream: AbsentServices.absentDatabase.orderByChild('absentTime').startAt(startTimeToday).endAt(endTimeToday).onValue,
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
                    vertical: 140,
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
                  itemBuilder: (context, index) => _UserPresenceComponent(
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

class _UserPresenceComponent extends StatelessWidget {
  final String userName;
  final int absentTime;
  final String photoURL;

  _UserPresenceComponent({this.userName, this.absentTime, this.photoURL});
  
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
                    time + " WIB",
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