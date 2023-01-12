import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as store;
import 'package:presensi/app/routes/app_pages.dart';

class UpdateController extends GetxController {
  var isPasswordHide = true.obs;
  RxBool isLoading = false.obs;

  TextEditingController txtNama = TextEditingController();
  TextEditingController txtJabatan = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  // TextEditingController txtPassword = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  store.FirebaseStorage storage = store.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();

  XFile? image;

  void pickImage() async {
    // Pick an image
    image = await picker.pickImage(source: ImageSource.gallery);
    // if (image != null) {
    //   print(image!.name);
    //   print(image!.name.split(".").last);
    //   print(image!.path);
    // } else {
    //   print(image);
    // }
    update();
  }

  void del_foto(String uid) async {
    try {
      await firestore
          .collection("pegawai")
          .doc(uid)
          .update({"foto": FieldValue.delete()});
      Get.back();
      Get.snackbar(
        "Berhasil",
        "Berhasil delete foto profile",
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
    } catch (e) {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Tidak dapat delete foto profile.",
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
      update();
    }
  }

  Future<void> updateProfile(String uid) async {
    if (txtNama.text.isNotEmpty &&
        txtEmail.text.isNotEmpty &&
        txtJabatan.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {
          "nama": txtNama.text,
          "jabatan": txtJabatan.text,
        };

        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;

          await storage.ref('$uid/profile.$ext').putFile(file);
          String urlImage =
              await storage.ref('$uid/profile.$ext').getDownloadURL();

          data.addAll({"foto": urlImage});
        }

        await firestore.collection("pegawai").doc(uid).update(data);

        Get.offAllNamed(Routes.HOME);

        Get.snackbar(
          "Berhasil",
          "Berhasil update profile",
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
      } catch (e) {
        Get.snackbar(
          "Terjadi Kesalahan",
          "Tidak dapat update profile.",
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
    }
  }
}
