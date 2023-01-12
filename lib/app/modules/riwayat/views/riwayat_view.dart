import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'background_riwayat.dart';
import 'package:presensi/app/routes/app_pages.dart';
import '../../../controllers/page_index_controller.dart';
import 'package:get/get.dart';
import '../controllers/riwayat_controller.dart';

class RiwayatView extends GetView<RiwayatController> {
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
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Background(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            children: [
              // filter bulan
              InkWell(
                onTap: () async {
                  DateTimeRange? selectedDate = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2023),
                    confirmText: "Filter",
                    cancelText: "Batal",
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Color.fromRGBO(80, 65, 112, 1),
                            onPrimary: Colors.white,
                            onSurface: Color.fromRGBO(63, 40, 112, 1),
                          ),
                          textButtonTheme: TextButtonThemeData(
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
                    await controller.setHari(selectedDate);
                    print("dijalankan");
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Icon(
                          Icons.date_range,
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Text(
                          "Pilih Tanggal",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              InkWell(
                onTap: () {
                  controller.getPDF();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Icon(
                          Icons.cloud_download_outlined,
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Text(
                          "Download PDF",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Data Laporan",
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

              // data presensi
              GetBuilder<RiwayatController>(
                builder: (c) =>
                    FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  future: controller.streamPresensi(),
                  builder: (context, snapPresensi) {
                    if (snapPresensi.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapPresensi.data?.docs.length == 0 ||
                        snapPresensi.data == null) {
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Data Kosong !",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapPresensi.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data =
                            snapPresensi.data!.docs[index].data();
                        return InkWell(
                          onTap: () => Get.toNamed(
                            Routes.DETAIL,
                            arguments: data,
                          ),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            padding: EdgeInsets.all(20),
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
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      width: 105,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(240, 128, 46, 1),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          data['cuti']?['date'] != null
                                              ? "${DateFormat.EEEE().format(DateTime.parse(data['cuti']!['date']))}"
                                              : data['sakit']?['date'] != null
                                                  ? "${DateFormat.EEEE().format(DateTime.parse(data['sakit']!['date']))}"
                                                  : data['masuk']?['date'] ==
                                                          null
                                                      ? "--:--:--"
                                                      : "${DateFormat.EEEE().format(DateTime.parse(data['masuk']!['date']))}",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          color:
                                              Color.fromRGBO(240, 128, 46, 0.4),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ),
                                        ),
                                        child: Text(
                                          data['cuti']?['date'] != null
                                              ? "${DateFormat('dd MMMM yyyy').format(DateTime.parse(data['cuti']!['date']))}"
                                              : data['sakit']?['date'] != null
                                                  ? "${DateFormat('dd MMMM yyyy').format(DateTime.parse(data['sakit']!['date']))}"
                                                  : data['masuk']?['date'] ==
                                                          null
                                                      ? "--:--:--"
                                                      : "${DateFormat('dd MMMM yyyy').format(DateTime.parse(data['masuk']!['date']))}",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            // color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.av_timer_rounded),
                                    SizedBox(
                                      width: size.width * 0.04,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Masuk"),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              data['cuti']?['date'] != null
                                                  ? "CUTI"
                                                  : data['sakit']?['date'] !=
                                                          null
                                                      ? "SAKIT"
                                                      : data['masuk']
                                                                  ?['date'] ==
                                                              null
                                                          ? "--:--:--"
                                                          : "${DateFormat.Hms().format(DateTime.parse(data['masuk']!['date']))}",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: size.width * 0.3,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Keluar"),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              data['cuti']?['date'] != null
                                                  ? "CUTI"
                                                  : data['sakit']?['date'] !=
                                                          null
                                                      ? "SAKIT"
                                                      : data['keluar']
                                                                  ?['date'] ==
                                                              null
                                                          ? "--:--:--"
                                                          : "${DateFormat.Hms().format(DateTime.parse(data['keluar']!['date']))}",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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
