import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presensi/app/routes/app_pages.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class PageIndexController extends GetxController {
  DateTime? start;
  DateTime end = DateTime.now();

  RxInt pageIndex = 0.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void changePage(int i) async {
    // pageIndex.value = i;
    switch (i) {
      case 1:
        print("Presensi");
        Map<String, dynamic> dataResponse = await determinePosition();
        if (dataResponse["error"] != true) {
          Position position = dataResponse["position"];
          List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);
          String address =
              "${placemarks[2].thoroughfare}, ${placemarks[2].subAdministrativeArea}, ${placemarks[2].administrativeArea}";
          await updatePosition(position, address);

          print(placemarks);

          // cek jangkauan
          double jangkauan = Geolocator.distanceBetween(
              -7.76151, 110.372447, position.latitude, position.longitude);

          // presensi masuk / keluar
          await presensi(position, address, jangkauan);
        } else {
          Get.snackbar(
            "Terjadi Kesalahan",
            dataResponse["message"],
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
        break;
      case 2:
        pageIndex.value = i;
        Get.offAllNamed(Routes.RIWAYAT);
        break;
      default:
        pageIndex.value = i;
        Get.offAllNamed(Routes.HOME);
    }
  }

  Future<void> presensi(
      Position position, String address, double jangkauan) async {
    String uid = await auth.currentUser!.uid;

    CollectionReference<Map<String, dynamic>> colPresensi =
        await firestore.collection("pegawai").doc(uid).collection("presensi");

    QuerySnapshot<Map<String, dynamic>> snapPresensi = await colPresensi.get();

    //print(snapPresensi.docs.length);
    DateTime now = DateTime.now();
    String today = DateFormat.yMd().format(now).replaceAll("/", "-");
    print(today);

    String status = "Di Luar Area";

    // meter
    if (jangkauan <= 200) {
      status = "Di Dalam Area";
    }

    if (snapPresensi.docs.length == 0) {
      await colPresensi.doc(today).set({
        "date": now.toIso8601String(),
        "masuk": {
          "date": now.toIso8601String(),
          "lat": position.latitude,
          "long": position.longitude,
          "address": address,
          "status": status,
          "jarak": jangkauan,
        },
      });
      Get.snackbar(
        "Berhasil",
        "kamu telah melakukan absen masuk",
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
    } else {
      DocumentSnapshot<Map<String, dynamic>> todayDoc =
          await colPresensi.doc(today).get();

      if (todayDoc.exists == true) {
        // presensi keluar
        Map<String, dynamic>? dataPresensi = todayDoc.data();
        if (dataPresensi?["cuti"] != null) {
          Get.snackbar(
            "Gagal",
            "kamu telah melakukan izin cuti",
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
        } else if (dataPresensi?["sakit"] != null) {
          Get.snackbar(
            "Gagal",
            "kamu telah melakukan izin sakit",
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
        } else if (dataPresensi?["keluar"] != null) {
          Get.snackbar(
            "Gagal",
            "kamu telah melakukan absen masuk dan keluar",
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
          // absen keluar
          await colPresensi.doc(today).update({
            "date": now.toIso8601String(),
            "keluar": {
              "date": now.toIso8601String(),
              "lat": position.latitude,
              "long": position.longitude,
              "address": address,
              "status": status,
              "jarak": jangkauan,
            },
          });
          Get.snackbar(
            "Berhasil",
            "kamu telah melakukan absen keluar",
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
        }
      } else {
        await colPresensi.doc(today).set({
          "date": now.toIso8601String(),
          "masuk": {
            "date": now.toIso8601String(),
            "lat": position.latitude,
            "long": position.longitude,
            "address": address,
            "status": status,
            "jarak": jangkauan,
          },
        });
        Get.snackbar(
          "Berhasil",
          "kamu telah melakukan absen masuk",
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
      }
    }
  }

  Future<void> updatePosition(Position position, String address) async {
    String uid = await auth.currentUser!.uid;

    await firestore.collection("pegawai").doc(uid).update({
      "position": {
        "lat": position.latitude,
        "long": position.longitude,
      },
      "address": address,
    });
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return {
        "message": "Tidak dapat mengambil GPS dari device ini",
        "error": true,
      };
      //return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return {
          "message": "Izin menggunakan GPS ditolak",
          "error": true,
        };
        //return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        "message": "Settingan Hp tidak dapat memperbolehkan menggunakan GPS",
        "error": true,
      };
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    return {
      "position": position,
      "message": "Berhasil mendapatkan posisi device",
      "error": false,
    };
  }
}
