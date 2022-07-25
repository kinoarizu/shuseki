import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityChecker {
  static Future<bool> checkConnection() async {
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
}