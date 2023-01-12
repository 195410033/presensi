import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/app/routes/app_pages.dart';

class UpdatePasswordController extends GetxController {
  var isPasswordHideold = true.obs;
  var isPasswordHidenew = true.obs;
  var isPasswordHideconfirm = true.obs;
  RxBool isLoading = false.obs;

  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtnewPassword = TextEditingController();
  TextEditingController txtconfirmPassword = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updatePass() async {
    if (txtPassword.text.isNotEmpty &&
        txtnewPassword.text.isNotEmpty &&
        txtconfirmPassword.text.isNotEmpty) {
      if (txtnewPassword.text == txtconfirmPassword.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(
              email: emailUser, password: txtPassword.text);

          await auth.currentUser!.updatePassword(txtnewPassword.text);

          await auth.signOut();

          Get.offAllNamed(Routes.LOGIN);

          Get.snackbar(
            "Berhasil",
            "Berhasil update password",
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
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
            Get.snackbar(
              "Terjadi Kesalahan",
              "Password yang dimasukan salah. Tidak dapat update password.",
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
          } else {
            Get.snackbar(
              "Terjadi Kesalahan",
              "${e.code.toLowerCase()}",
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
          Get.snackbar(
            "Terjadi Kesalahan",
            "Tidak dapat update password",
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
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar(
          "Terjadi Kesalahan",
          "Confirm password tidak cocok.",
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
        "Semua input harus diisi",
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
