import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  var isPasswordHide = true.obs;
  RxBool isLoading = false.obs;

  TextEditingController txtNama = TextEditingController();
  TextEditingController txtJabatan = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> add() async {
    if (txtNama.text.isNotEmpty &&
        txtEmail.text.isNotEmpty &&
        txtJabatan.text.isNotEmpty &&
        txtPassword.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: txtEmail.text,
          password: txtPassword.text,
        );
        if (userCredential.user != null) {
          isLoading.value = false;
          String? uid = userCredential.user?.uid;

          firestore.collection("pegawai").doc(uid).set({
            "nama": txtNama.text,
            "email": txtEmail.text,
            "jabatan": txtJabatan.text,
            "foto": '',
            "uid": uid,
            "createdAt": DateTime.now().toIso8601String(),
          });
          Get.offAllNamed(Routes.LOGIN);
          await userCredential.user!.sendEmailVerification();
          await auth.signOut();
        }
        isLoading.value = false;
        print(userCredential);
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'weak-password') {
          Get.snackbar(
            "Terjadi Kesalahan",
            "Password yang digunakan terlalu singkat",
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
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar(
            "Terjadi Kesalahan",
            "Pegawai sudah ada, tidak dapat menambahkan pegawai menggunakan email ini",
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
          "Tidak dapat menambahkan pegawai.",
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
        "Data tidak boleh ada yang kosong",
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
