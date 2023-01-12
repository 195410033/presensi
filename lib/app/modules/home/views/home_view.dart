import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/app/components/day.dart';
import 'package:presensi/app/components/time.dart';
import 'package:presensi/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../../../controllers/page_index_controller.dart';
import 'package:intl/intl.dart';
import 'background_home.dart';

class HomeView extends GetView<HomeController> {
  final page = Get.find<PageIndexController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(200, 10, 31, 103),
        title: Image.asset(
          "assets/images/nazma.png",
          height: size.height * 0.05,
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.SETTING),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            Map<String, dynamic> user = snapshot.data!.data()!;
            String avatar = "https://ui-avatars.com/api/?name=${user['nama']}";

            return Background(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Pengajuan izin dan sakit
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        //color: Color.fromRGBO(240, 128, 46, 1),
                        color: Colors.blueGrey[100],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Selamat Datang",
                            style: TextStyle(
                              // color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: Color.fromARGB(200, 10, 31, 103),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(0.1),
                                          offset: Offset(0, 10),
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          user["foto"] != null
                                              ? user["foto"] != ""
                                                  ? user["foto"]
                                                  : avatar
                                              : avatar,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${user['nama'].toString().toUpperCase()}",
                                    style: TextStyle(
                                      // color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "${user['jabatan']}",
                                    style: TextStyle(
                                      // color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            user["address"] != null
                                ? "${user['address']}"
                                : "Belum ada lokasi",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              // color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // section waktu jam & tanggal
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromARGB(250, 10, 31, 103),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Time(),
                            Day(),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    // jam masuk & keluar
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromRGBO(240, 128, 46, 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child:
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                              stream: controller.streamtodayPresensi(),
                              builder: (context, snapToday) {
                                if (snapToday.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                Map<String, dynamic>? dataToday =
                                    snapToday.data?.data();
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Masuk",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          dataToday?["cuti"] != null
                                              ? "CUTI"
                                              : dataToday?["sakit"] != null
                                                  ? "SAKIT"
                                                  : dataToday?["masuk"] == null
                                                      ? "--:--:--"
                                                      : "${DateFormat.Hms().format(DateTime.parse(dataToday!['masuk']['date']))}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              fontFamily: 'Poppins'),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Keluar",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          dataToday?["cuti"] != null
                                              ? "CUTI"
                                              : dataToday?["sakit"] != null
                                                  ? "SAKIT"
                                                  : dataToday?["keluar"] == null
                                                      ? "--:--:--"
                                                      : "${DateFormat.Hms().format(DateTime.parse(dataToday!['keluar']['date']))}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              fontFamily: 'Poppins'),
                                        ),
                                        // Time(),
                                        // Text("${DateFormat.jms().format(DateTime.now())}"),
                                      ],
                                    )
                                  ],
                                );
                              }),
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    // Pengajuan izin dan sakit
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        //color: Colors.grey[200],
                        color: Color.fromARGB(250, 10, 31, 103),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Pengajuan Cuti / Izin Sakit",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Cuti
                                  TextButton(
                                    onPressed: () async {
                                      DateTimeRange? selectedDate =
                                          await showDateRangePicker(
                                        context: context,
                                        firstDate: DateTime(2022),
                                        lastDate: DateTime(2025),
                                        confirmText: "Cuti",
                                        cancelText: "Batal",
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: Color.fromRGBO(
                                                    80, 65, 112, 1),
                                                onPrimary: Colors.white,
                                                onSurface: Color.fromRGBO(
                                                    63, 40, 112, 1),
                                              ),
                                              textButtonTheme:
                                                  TextButtonThemeData(
                                                style: TextButton.styleFrom(
                                                  primary: Colors.red,
                                                ),
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );
                                      if (selectedDate != null) {
                                        await controller.izinCuti(selectedDate);
                                        print("dijalankan");
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey[200],
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.add_circle_outline,
                                            color:
                                                Color.fromRGBO(240, 128, 46, 1),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.01,
                                          ),
                                          const Text(
                                            "Izin Cuti",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  240, 128, 46, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Sakit
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text("Izin Sakit"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  "Silahkan unggah surat izin sakit"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                        Colors.red[700],
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "Batal",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Poppins',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                      await controller
                                                          .izinSakit(
                                                              user["uid"]);
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                        Colors.indigo[700],
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "Unggah",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Poppins',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey[200],
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.add_circle_outline,
                                            color:
                                                Color.fromRGBO(240, 128, 46, 1),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.01,
                                          ),
                                          const Text(
                                            "Izin Sakit",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  240, 128, 46, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Data 5 hari terakhir",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    // 5 data terakhir
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: controller.stream5DataLast(),
                      builder: (context, snapPresensi) {
                        if (snapPresensi.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapPresensi.data?.docs.length == 0 ||
                            snapPresensi.data == null) {
                          return SizedBox(
                            height: 150,
                            child: Center(
                              child: Text("Data Kosong !"),
                            ),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapPresensi.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data = snapPresensi
                                .data!.docs.reversed
                                .toList()[index]
                                .data();
                            return InkWell(
                              onTap: () => Get.toNamed(
                                Routes.DETAIL,
                                arguments: data,
                              ),
                              child: Container(
                                margin: EdgeInsets.only(bottom: 15),
                                padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[200],
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(
                                          0, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          // padding: EdgeInsets.symmetric(
                                          //   horizontal: 20,
                                          //   vertical: 10,
                                          // ),
                                          padding: EdgeInsets.all(10),
                                          width: 130,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Color.fromRGBO(
                                                240, 128, 46, 0.4),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // hari
                                              Text(
                                                "${DateFormat('dd').format(DateTime.parse(data['date']))}",
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 40,
                                                  color: Color.fromRGBO(
                                                      240, 128, 46, 1),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  //Text("Hari dan Bulan"),
                                                  Text(
                                                    "${DateFormat.E().format(DateTime.parse(data['date']))}",
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      // color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${DateFormat.LLL().format(DateTime.parse(data['date']))}",
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    // presensi masuk
                                    Column(
                                      children: [
                                        Text(
                                          "Masuk",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          data['cuti']?['date'] != null
                                              ? "cuti"
                                              : data['sakit']?['date'] != null
                                                  ? "sakit"
                                                  : data['masuk']?['date'] ==
                                                          null
                                                      ? "--:--:--"
                                                      : "${DateFormat.Hms().format(DateTime.parse(data['masuk']!['date']))}",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),

                                    // presensi keluar
                                    Column(
                                      children: [
                                        Text(
                                          "Keluar",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          data['cuti']?['date'] != null
                                              ? "cuti"
                                              : data['sakit']?['date'] != null
                                                  ? "sakit"
                                                  : data['keluar']?['date'] ==
                                                          null
                                                      ? '--:--:--'
                                                      : "${DateFormat.Hms().format(DateTime.parse(data['keluar']!['date']))}",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                //color: Colors.grey[200],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text("Tidak dapat memuat data pengguna."),
            );
          }
        },
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Color.fromARGB(200, 10, 31, 103),
        style: TabStyle.fixedCircle,
        cornerRadius: 20,
        items: [
          TabItem(icon: Icons.home),
          TabItem(icon: Icons.fingerprint),
          TabItem(icon: Icons.format_list_bulleted),
        ],
        initialActiveIndex: page.pageIndex.value,
        onTap: (int i) => page.changePage(i),
      ),
    );
  }
}
