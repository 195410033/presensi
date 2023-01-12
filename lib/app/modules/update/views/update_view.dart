import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'background_update_profile.dart';

import '../controllers/update_controller.dart';

class UpdateView extends GetView<UpdateController> {
  final Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.txtNama.text = user["nama"];
    controller.txtEmail.text = user["email"];
    controller.txtJabatan.text = user["jabatan"];

    String avatar = "https://ui-avatars.com/api/?name=${user['nama']}";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Profile',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(200, 10, 31, 103),
      ),
      body: Background(
        child: Column(
          // padding: EdgeInsets.all(20),
          children: [
            SizedBox(
              height: 25,
            ),
            // foto
            Center(
              child: Stack(
                children: [
                  GetBuilder<UpdateController>(
                    builder: (c) {
                      if (c.image != null) {
                        return Container(
                          height: 200,
                          width: 200,
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
                              image: FileImage(
                                File(c.image!.path),
                              ),
                            ),
                          ),
                        );
                      } else {
                        if (user["foto"] != null) {
                          return Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
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
                                  user["foto"],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
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
                                image: NetworkImage(avatar),
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  Positioned(
                    bottom: 20,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        color: Color.fromARGB(200, 10, 31, 103),
                      ),
                      child: IconButton(
                        onPressed: () {
                          controller.pickImage();
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),

            // Nama
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Color.fromARGB(228, 4, 5, 79)),
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    autocorrect: false,
                    controller: controller.txtNama,
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.person,
                        color: Color.fromARGB(228, 4, 5, 79),
                      ),
                      border: InputBorder.none,
                      hintText: 'Nama',
                    ),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Color.fromARGB(228, 4, 5, 79)),
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    readOnly: true,
                    autocorrect: false,
                    controller: controller.txtEmail,
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.email,
                        color: Color.fromARGB(228, 4, 5, 79),
                      ),
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Jabatan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Color.fromARGB(228, 4, 5, 79)),
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    autocorrect: false,
                    controller: controller.txtJabatan,
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.work,
                        color: Color.fromARGB(228, 4, 5, 79),
                      ),
                      border: InputBorder.none,
                      hintText: 'Jabatan',
                    ),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 60),

            // simpan
            Obx(
              () => ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 4, 5, 79)),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(
                      horizontal: 70,
                      vertical: 15,
                    ),
                  ),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(29.0),
                    ),
                  ),
                ),
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.updateProfile(user["uid"]);
                  }
                },
                child: Text(
                  controller.isLoading.isFalse ? "Simpan" : "Loading...",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
