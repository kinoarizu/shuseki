import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEmployeeController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addEmployee() async {
    if (nameC.text.isNotEmpty && nipC.text.isNotEmpty && nipC.text.isNotEmpty) {
      try {
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "password"
        );

        if (userCredential.user != null) {
          String? uid = userCredential.user?.uid;

          await firestore.collection("pegawai").doc(uid).set({
            "nip":nipC.text,
            "name":nameC.text,
            "email":emailC.text,
            "uid":uid,
            "createdAt":DateTime.now().toIso8601String(),
          });
      
          await userCredential.user!.sendEmailVerification();

          print(userCredential);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar(
            "Terjadi Kesalahan", 
            "Password yang digunakan terlalu lemah.",
          );
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar(
            "Terjadi Kesalahan", 
            "Pegawai sudah ada. Kamu tidak dapat menambahkan pegawai dengan email yang sudah terdaftar",
          );
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat menambahkan pegawai.");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "NIP, Nama, dan Email harus diisi.");
    }
  }
}
