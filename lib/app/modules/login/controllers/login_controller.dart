import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void login() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passwordC.text,
        );

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified) {
            if (passwordC.text == "password") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
              title: "Belum Verfikasi",
              middleText: "Kamu belum verifikasi akun ini. Lakukan verfikasi di email kamu.",
              actions: [
                OutlinedButton(
                  onPressed: () => Get.back(), 
                  child: Text("CANCEL"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await userCredential.user!.sendEmailVerification();
                      Get.back();
                      Get.snackbar(
                        "Berhasil", 
                        "Kami telah berhasil mengirim email verfikasi ke akun kamu.",
                      );
                    } catch (e) {
                      Get.snackbar(
                        "Terjadi Kesalahan", 
                        "Tidak dapat mengirim email verifikasi. Hubungi admin atau customer service.",
                      );
                    }
                  }, 
                  child: Text("KIRIM ULANG"),
                ),
              ],
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar(
            "Terjadi Kesalahan",
            "Email tidak terdaftar",
          );
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
            "Terjadi Kesalahan",
            "Password salah",
          );
        }
      } catch (e) {
        Get.snackbar(
          "Terjadi Kesalahan",
          "Tidak dapat login",
        );
      }
    } else {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Email dan Password wajib diisi.",
      );
    }
  }
}
