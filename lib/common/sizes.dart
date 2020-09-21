part of 'common.dart';

const double defaultMargin = 24;

double defaultWidth(BuildContext context) => deviceWidth(context) - 2 * defaultMargin;
double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
double statusBarHeight(BuildContext context) => MediaQuery.of(context).padding.top;