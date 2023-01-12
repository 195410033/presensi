import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presensi/app/modules/about/views/background_about.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  final Map<String, dynamic> data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print(data);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail View'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(200, 10, 31, 103),
      ),
      body: Background(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[200],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      // Hari
                      Text(
                        "${DateFormat.EEEE().format(DateTime.parse(data['date']))}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // Tanggal
                            "${DateFormat('dd').format(DateTime.parse(data['date']))}",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Color.fromRGBO(240, 128, 46, 1),
                            ),
                          ),
                          Text(
                            "${DateFormat(' MMMM yyyy').format(DateTime.parse(data['date']))}",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // masuk

                      Row(
                        children: [
                          Text(
                            "Presensi Masuk : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            data['masuk']?['date'] == null
                                ? "-"
                                : "${DateFormat.Hms().format(DateTime.parse(data['masuk']!['date']))}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: Color.fromRGBO(240, 128, 46, 1),
                            ),
                          ),
                          // jam
                        ],
                      ),
                      Container(
                        height: 20,
                        color: Colors.red[100],
                        child: Center(
                          child: Text(
                            data['masuk']?['date'] == null
                                ? "-"
                                : "${data['masuk']!['status']}",
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        height: 100,
                        color: Colors.grey[100],
                        child: Center(
                          child: Text(
                            data['masuk']?['date'] == null
                                ? "-"
                                : "${data['masuk']!['address']}",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // keluar

                      Row(
                        children: [
                          Text(
                            "Presensi Keluar : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            data['keluar']?['date'] == null
                                ? "-"
                                : "${DateFormat.Hms().format(DateTime.parse(data['keluar']!['date']))}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: Color.fromRGBO(240, 128, 46, 1),
                            ),
                          ),
                          // jam
                        ],
                      ),
                      Container(
                        height: 20,
                        color: Colors.red[100],
                        child: Center(
                            child: Text(
                          data['keluar']?['date'] == null
                              ? "-"
                              : "${data['keluar']!['status']}",
                        )),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        height: 100,
                        color: Colors.grey[100],
                        child: Center(
                          child: Text(
                            data['keluar']?['date'] == null
                                ? "-"
                                : "${data['keluar']!['address']}",
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      // izin cuti
                      Text(
                        "Izin Cuti",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        height: 20,
                        color: Colors.red[100],
                        child: Center(
                            child: Text(
                          data['cuti']?['date'] == null
                              ? "Tidak Cuti"
                              : "${data['cuti']!['status']}",
                        )),
                      ),
                      Container(
                        height: 50,
                        color: Colors.grey[100],
                        child: Center(
                          child: Text("Keterangan"),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      // izin sakit
                      Text(
                        "Izin Sakit",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        height: 20,
                        color: Colors.red[100],
                        child: Center(
                          child: Text(
                            data['sakit']?['date'] == null
                                ? "Tidak Sakit"
                                : "${data['sakit']!['status']}",
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        color: Colors.grey[100],
                        child: Center(
                          child: Text("Keterangan"),
                        ),
                      ),

                      // // bebas
                      // Column(
                      //   children: [
                      //     Row(
                      //       children: [Text("data")],
                      //     ),
                      //     Text("data :"),
                      //     Text("data"),
                      //   ],
                      // ),
                      // Text(
                      //   data['masuk']?['date'] == null
                      //       ? "Jam : -"
                      //       : "Jam : ${DateFormat.jms().format(DateTime.parse(data['masuk']!['date']))}",
                      // ),
                      // Text(
                      //   data['masuk']?['date'] == null
                      //       ? "Status : -"
                      //       : "Status : ${data['masuk']!['status']}",
                      // ),
                      // Text(
                      //   data['masuk']?['date'] == null
                      //       ? "Jarak : -"
                      //       : "Jarak : ${data['masuk']!['jarak'].toString().split(".").first} meter",
                      // ),
                      // Text(
                      //   data['masuk']?['date'] == null
                      //       ? "Alamat : -"
                      //       : "Alamat : ${data['masuk']!['address']}",
                      //),
                    ],
                  ),
                ),

                // SizedBox(height: 20),
                // Text(
                //   "Keluar",
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // Text(
                //   data['keluar']?['date'] == null
                //       ? "Jam : -"
                //       : "Jam : ${DateFormat.jms().format(DateTime.parse(data['keluar']!['date']))}",
                // ),
                // // Text(
                // //   data['keluar']?['lat'] == null &&
                // //           data['keluar']?['long'] == null
                // //       ? "Posisi : -"
                // //       : "Posisi : ${data['keluar']!['lat']} , ${data['keluar']!['long']}",
                // // ),
                // Text(
                //   data['keluar']?['status'] == null
                //       ? "Status : -"
                //       : "Status : ${data['keluar']!['status']}",
                // ),
                // Text(
                //   data['keluar']?['jarak'] == null
                //       ? "Jarak : -"
                //       : "Jarak : ${data['keluar']!['jarak'].toString().split(".").first} meter",
                // ),
                // Text(
                //   data['keluar']?['address'] == null
                //       ? "Alamat : -"
                //       : "Alamat : ${data['keluar']!['address']}",
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
