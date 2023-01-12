import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController txtEmail = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> new_password() async {
    if (txtEmail.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: txtEmail.text);

        await auth.signOut();

        await Get.snackbar(
          "Berhasil",
          "Silahkan periksa inbox atau spambox untuk mengganti password anda",
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
        await Get.offAllNamed(Routes.LOGIN);
        isLoading.value = false;
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
        }
      }
    } else {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Email tidak boleh kosong",
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
