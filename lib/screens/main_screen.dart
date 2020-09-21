part of 'screens.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();

  static String routeName = '/main_screen';
}

class _MainScreenState extends State<MainScreen> {
  int bottomNavBarIndex;
  PageController pageController;

  @override
  void initState() { 
    super.initState();
    
    bottomNavBarIndex = 0;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
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
                PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      bottomNavBarIndex = index;
                    });
                  },
                  children: [
                    DashboardView(),
                    PresenceView(),
                  ],
                ),
                bottomNavBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomNavBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          unselectedItemColor: Color(0xFFE5E5E5),
          currentIndex: bottomNavBarIndex,
          onTap: (index) {
            setState(() {
              bottomNavBarIndex = index;
              pageController.jumpToPage(index);
            });
          },
          items: [
            BottomNavigationBarItem(
              title: Text(
                "Dashboard",
                style: (bottomNavBarIndex == 0) ? boldBlackFont.copyWith(
                  color: primaryColor,
                  fontSize: 12,
                ) : semiBlackFont.copyWith(
                  color: Color(0xFFCDCBCB),
                  fontSize: 12,
                ),
              ),
              icon: Container(
                margin: EdgeInsets.only(bottom: 4),
                height: 24,
                child: Image.asset(
                  (bottomNavBarIndex == 0) 
                  ? "assets/images/dashboard_active.png" 
                  : "assets/images/dashboard_inactive.png",
                ),
              ),
            ),
            BottomNavigationBarItem(
              title: Text(
                "Kehadiran",
                style: (bottomNavBarIndex == 1) ? boldBlackFont.copyWith(
                  color: primaryColor,
                  fontSize: 12,
                ) : semiBlackFont.copyWith(
                  color: Color(0xFFCDCBCB),
                  fontSize: 12,
                ),
              ),
              icon: Container(
                margin: EdgeInsets.only(bottom: 4),
                height: 24,
                child: Image.asset(
                  (bottomNavBarIndex == 1) 
                  ? "assets/images/list_active.png" 
                  : "assets/images/list_inactive.png",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}