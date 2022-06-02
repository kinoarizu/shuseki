import 'package:flutter/material.dart';

import 'main_screen.dart';

class Wrapper extends StatelessWidget {
  static String routeName = '/wrapper';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MainScreen());
  }
}
