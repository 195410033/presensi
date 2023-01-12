import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/app/routes/app_pages.dart';

class LoginController extends GetxController {
  var isPasswordHide = true.obs;
  RxBool isLoading = false.obs;

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (txtEmail.text.isNotEmpty && txtPassword.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: txtEmail.text,
          password: txtPassword.text,
        );

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;

            Get.snackbar(
              "Berhasil",
              "Kamu berhasil login",
              icon: Icon(Icons.assignment_turned_in, color: Colors.white),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green[400],
              borderRadius: 20,
              margin: EdgeInsets.all(15),
              colorText: Colors.white,
              duration: Duration(seconds: 4),
              isDismissible: true,
              forwardAnimationCurve: Curves.easeOutBack,
            );
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.snackbar(
              "Belum verifikasi",
              "Kamu perlu verifikasi terlebih dahulu",
              icon: Icon(Icons.assignment_late, color: Colors.white),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.yellow[400],
              borderRadius: 20,
              margin: EdgeInsets.all(15),
              colorText: Colors.white,
              duration: Duration(seconds: 4),
              isDismissible: true,
              forwardAnimationCurve: Curves.easeOutBack,
            );
          }
        }
        isLoading.value = false;
        print(userCredential);
      } on FirebaseException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar(
            "Terjadi Kesalahan",
            "Email tidak terdaftar",
            icon: Icon(Icons.assignment_late, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red[400],
            borderRadius: 20,
            margin: EdgeInsets.all(15),
            colorText: Colors.white,
            duration: Duration(seconds: 4),
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
          );
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
            "Terjadi Kesalahan",
            "Password salah",
            icon: Icon(Icons.assignment_late, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red[400],
            borderRadius: 20,
            margin: EdgeInsets.all(15),
            colorText: Colors.white,
            duration: Duration(seconds: 4),
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
          );
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar(
          "Terjadi Kesalahan",
          "Tidak dapat login",
          icon: Icon(Icons.assignment_late, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[400],
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      }
    } else {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Email dan Password tidak boleh kosong",
        icon: Icon(Icons.assignment_late, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
  }
}
