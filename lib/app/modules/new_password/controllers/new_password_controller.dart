import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_absensi/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPasswordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void newPassword() async {
    if (newPasswordC.text.isNotEmpty) {
      if (newPasswordC.text != "password") {
        try {
          String email = auth.currentUser!.email!;

          await auth.currentUser!.updatePassword(newPasswordC.text);

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
            email: email,
            password: newPasswordC.text,
          );

          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar(
              "Terjadi Kesalahan",
              "Password terlalu lemah, setidaknya 6 karakter.",
            );
          }
        } catch (e) {
          Get.snackbar(
            "Terjadi Kesalahan",
            "Tidak dapat membuat password baru. Hubungi admin atau customer service.",
          );
        }
      } else {
        Get.snackbar(
          "Terjadi Kesalahan",
          "Password baru harus diubah, jangan 'password' kembali.",
        );
      }
    } else {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Password baru wajib diisi.",
      );
    }
  }
}
