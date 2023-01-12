import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../data/models/presensi_model.dart';

class RiwayatController extends GetxController {
  DateTime? start;
  DateTime end = DateTime.now();

  List<Presensi> allPresensi = [];

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> streamPresensi() async {
    String uid = auth.currentUser!.uid;

    print(start);
    print(end);

    if (start == null) {
      return await firestore
          .collection("pegawai")
          .doc(uid)
          .collection("presensi")
          .where("date")
          .orderBy("date", descending: true)
          .get();
    } else {
      return await firestore
          .collection("pegawai")
          .doc(uid)
          .collection("presensi")
          .where("date", isGreaterThan: start!.toIso8601String())
          .where("date",
              isLessThan: end.add(Duration(days: 1)).toIso8601String())
          .orderBy("date", descending: true)
          .get();
    }
  }

  Future<void> getPDF() async {
    allPresensi = [];
    String uid = await auth.currentUser!.uid;

    QuerySnapshot<Presensi> colPresensi = await firestore
        .collection("pegawai")
        .doc(uid)
        .collection("presensi")
        .withConverter(
          fromFirestore: (snapshot, _) => Presensi.fromJson(snapshot.data()!),
          toFirestore: (presensi, _) => presensi.toJson(),
        )
        .orderBy("date")
        .get();

    colPresensi.docs.forEach((element) {
      Presensi data = element.data();
      allPresensi.add(data);
    });

    final pdf = pw.Document();

    // my font
    var dataFont = await rootBundle.load("assets/fonts/Poppins-Regular.ttf");
    var myFont = pw.Font.ttf(dataFont);

    // data list
    List<pw.TableRow> dataPresensi =
        List<pw.TableRow>.generate(allPresensi.length, (index) {
      Presensi data = allPresensi[index];
      print(data.date);
      return pw.TableRow(
        children: [
          pw.Text(
            "${index + 1}",
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 15,
              font: myFont,
            ),
          ),
          pw.Text(
            data.date == null
                ? "-"
                : "${DateFormat('dd MMMM yyyy').format(DateTime.parse(data.date!))}",
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 15,
              font: myFont,
            ),
          ),
          pw.Text(
            data.masuk == null
                ? "-"
                : "${DateFormat.Hms().format(DateTime.parse(data.masuk!.date!))}",
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 15,
              font: myFont,
            ),
          ),
          pw.Text(
            data.keluar == null
                ? "-"
                : "${DateFormat.Hms().format(DateTime.parse(data.keluar!.date!))}",
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 15,
              font: myFont,
            ),
          ),
          pw.Text(
            data.masuk != null || data.keluar != null
                ? "Hadir"
                : data.cuti != null
                    ? "Cuti"
                    : data.sakit != null
                        ? "Sakit"
                        : "-",
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 15,
              font: myFont,
            ),
          ),
        ],
      );
    });

    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          return [
            pw.Center(
              child: pw.Text(
                "Laporan Presensi Nazma Office",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 25,
                  font: myFont,
                ),
              ),
            ),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.black, width: 1),
              children: [
                pw.TableRow(
                  children: [
                    pw.Text(
                      "No",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 18,
                        font: myFont,
                      ),
                    ),
                    pw.Text(
                      "Tanggal",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 18,
                        font: myFont,
                      ),
                    ),
                    pw.Text(
                      "Masuk",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 18,
                        font: myFont,
                      ),
                    ),
                    pw.Text(
                      "Keluar",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 18,
                        font: myFont,
                      ),
                    ),
                    pw.Text(
                      "Keterangan",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 18,
                        font: myFont,
                      ),
                    ),
                  ],
                ),
                ...dataPresensi,
              ],
            ),
          ];
        },
      ),
    );

    // simpan
    Uint8List bytes = await pdf.save();

    // buat page baru di dir
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/laporan.pdf');

    await file.writeAsBytes(bytes);

    await OpenFile.open(file.path);
  }

  Future setHari(date) async {
    List<DateTime> days = [];

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
    days = getDaysInBeteween(dateRange.start, dateRange.end);

    print(days);
    update();
  }
}
