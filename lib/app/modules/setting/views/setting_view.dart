import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'background_setting.dart';
import 'package:presensi/app/routes/app_pages.dart';
import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(200, 10, 31, 103),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            Center(child: CircularProgressIndicator());
          }
          if (snap.hasData) {
            Map<String, dynamic> user = snap.data!.data()!;
            String avatar = "https://ui-avatars.com/api/?name=${user['nama']}";
            return Background(
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10),
                              ),
                            ],
                            color: Colors.white,
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
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "${user['nama'].toString().toUpperCase()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${user['email']}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    onTap: () => Get.toNamed(
                      Routes.UPDATE,
                      arguments: user,
                    ),
                    leading: Icon(Icons.person_outline),
                    title: Text(
                      "Update Profile",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () => Get.toNamed(
                      Routes.UPDATE_PASSWORD,
                    ),
                    leading: Icon(Icons.key_outlined),
                    title: Text(
                      "Update Password",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () => Get.toNamed(
                      Routes.ABOUT,
                    ),
                    leading: Icon(Icons.info_outline),
                    title: Text(
                      "About",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  // if (user["role"] == "admin")
                  //   ListTile(
                  //     //onTap: () => Get.toNamed(Routes.ADD_PEGAWAI),
                  //     leading: Icon(Icons.person_add),
                  //     title: Text("Add Pegawai"),
                  //   ),
                  ListTile(
                    onTap: () => controller.logout(),
                    leading: Icon(Icons.logout),
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text("Tidak dapat memuat data user."),
            );
          }
        },
      ),
    );
  }
}
