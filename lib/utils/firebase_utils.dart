part of 'utils.dart';

AuthMessage generateAuthMessage(String errorCode) {
  switch (errorCode) {
    case 'email-already-in-use':
      return AuthMessage(
        "Email Sudah Terdaftar",
        "Silahkan gunakan akun email yang lain.",
        "assets/images/access_denied.png",
      );
      break;
    case 'invalid-email':
      return AuthMessage(
        "Email Tidak Valid",
        "Gunakan akun email yang benar..",
        "assets/images/access_denied.png",
      );
      break;
    case 'weak-password':
      return AuthMessage(
        "Password Lemah",
        "Gunakan Password yang Sulit Ditebak..",
        "assets/images/access_denied.png",
      );
      break;
    case 'imei-different':
      return AuthMessage(
        "Perangkat Berbeda",
        "Pastikan login di HP yang anda daftarkan..",
        "assets/images/other_devices.png",
      );
      break;
    case 'email-not-registered':
      return AuthMessage(
        "Email Tidak Terdaftar",
        "Gunakan email yang sudah anda daftarkan..",
        "assets/images/access_denied.png",
      );
      break;
    case 'user-not-found':
      return AuthMessage(
        "Email Tidak Terdaftar",
        "Gunakan email yang sudah anda daftarkan..",
        "assets/images/access_denied.png",
      );
      break;
    case 'wrong-password':
      return AuthMessage(
        "Password Salah",
        "Silahkan Masukan Password Dengan Mencoba Lagi..",
        "assets/images/access_denied.png",
      );
      break;
    default:
      return AuthMessage(
        "Email Tidak Diizinkan",
        "Silahkan Gunakan Akun Email..",
        "assets/images/access_denied.png",
      );
  }
}