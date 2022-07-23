import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeView"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.ADD_EMPLOYEE),
            icon: Icon(Icons.person),
          )
        ],
      ),
      body: Center(
        child: Text(
          "HomeView is working",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
