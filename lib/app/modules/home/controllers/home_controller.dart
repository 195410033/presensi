import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as store;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  DateTime? start;
  DateTime end = DateTime.now();

  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  store.FirebaseStorage storage = store.FirebaseStorage.instance;

  PlatformFile? result;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("pegawai").doc(uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> stream5DataLast() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore
        .collection("pegawai")
        .doc(uid)
        .collection("presensi")
        .orderBy("date")
        .limitToLast(5)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamtodayPresensi() async* {
    String uid = auth.currentUser!.uid;

    String today = DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");

    yield* firestore
        .collection("pegawai")
        .doc(uid)
        .collection("presensi")
        .doc(today)
        .snapshots();
  }

  Future<void> izinSakit(String uid) async {
    FilePickerResult? picker = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf','jpg'],
    );

    if (picker != null) {
      picker.files.forEach(
        (element) async {
          String name = element.name;
          File file = File(element.path!);
          try {
            CollectionReference<Map<String, dynamic>> colPresensi =
                await firestore
                    .collection("pegawai")
                    .doc(uid)
                    .collection("presensi");

            String status = "Izin Sakit";
            DateTime now = DateTime.now();
            String izinSakit =
                DateFormat.yMd().format(now).replaceAll("/", "-");
            DocumentSnapshot<Map<String, dynamic>> todayDoc =
                await colPresensi.doc(izinSakit).get();

            Map<String, dynamic>? dataPresensi = todayDoc.data();

            if (dataPresensi?["masuk"] != null) {
              Get.snackbar(
                "Gagal",
                "Kamu telah melakukan presensi",
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
              print("gagal");
            } else if (dataPresensi?["keluar"] != null) {
              Get.snackbar(
                "Gagal",
                "Kamu telah melakukan presensi",
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
              print("gagal");
            } else {
              if (dataPresensi?["cuti"] != null) {
                Get.snackbar(
                  "Gagal",
                  "Kamu telah melakukan izin cuti di tanggal",
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
                await colPresensi.doc(izinSakit).set(
                  {
                    "date": now.toIso8601String(),
                    "sakit": {
                      "date": now.toIso8601String(),
                      "status": status,
                    },
                  },
                );
                await storage.ref('$uid/surat izin sakit/$name').putFile(file);
                Get.snackbar(
                  "Sukses",
                  "Kamu telah melakukan izin sakit",
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
                print("berhasil");
              }
            }

            // Get.snackbar("Berhasil", "Berhasil upload file");
            print("Berhasil");
          } on store.FirebaseException catch (e) {
            Get.snackbar(
              "Terjadi Kesalahan",
              "Gagal upload file.",
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
            print("gagal");
          }
        },
      );
      // print(files);
    } else {
      // User canceled the picker
      print("batal");
    }
  }

  Future izinCuti(date) async {
    List<DateTime> hari = [];

    List<DateTime> getDaysInBeteween(DateTime startDate, DateTime endDate) {
      List<DateTime> days = [];
      for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
        days.add(startDate.add(Duration(days: i)));
      }
      return days;
    }

    DateTimeRange dateRange =
        DateTimeRange(start: DateTime.now(), end: DateTime.now());
    dateRange = date;

    start = dateRange.start;
    end = dateRange.end;

    hari = getDaysInBeteween(dateRange.start, dateRange.end);
    //print(start);

    for (var day in hari) {
      // print(day);
      var izin = DateFormat.yMd().format(day).toString().replaceAll("/", "-");
      var tanggal = DateFormat('dd MMMM yyyy')
          .format(day)
          .toString()
          .replaceAll("/", "-");
      print(izin);
      String uid = await auth.currentUser!.uid;

      CollectionReference<Map<String, dynamic>> colPresensi =
          await firestore.collection("pegawai").doc(uid).collection("presensi");

      String status = "Izin Cuti";

      DocumentSnapshot<Map<String, dynamic>> todayDoc =
          await colPresensi.doc(izin).get();

      Map<String, dynamic>? dataPresensi = todayDoc.data();
      if (dataPresensi?["masuk"] != null) {
        Get.snackbar(
          "Gagal",
          "Kamu telah melakukan presensi di tanggal ${tanggal}",
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
        print("gagal");
      } else if (dataPresensi?["sakit"] != null) {
        Get.snackbar(
          "Gagal",
          "Kamu telah izin sakit di tanggal ${tanggal}",
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
        print("gagal");
      } else {
        if (dataPresensi?["cuti"] != null) {
          Get.snackbar(
            "Gagal",
            "Kamu telah melakukan izin cuti di tanggal ${tanggal}",
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
          await colPresensi.doc(izin).set(
            {
              "date": day.toIso8601String(),
              "cuti": {
                "date": day.toIso8601String(),
                "status": status,
              },
            },
          );
          Get.snackbar(
            "Sukses",
            "Kamu telah melakukan izin cuti",
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
          print("berhasil");
        }
      }
    }
  }
}
