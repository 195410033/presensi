import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'background_update_password.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Password',
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
            // Text(
            //   "Update Password",
            //   style: TextStyle(
            //     fontFamily: 'Poppins',
            //     color: Colors.white,
            //     fontSize: 30,
            //     fontWeight: FontWeight.bold,
            //   ),
            //   textAlign: TextAlign.right,
            // ),
            SizedBox(
              height: 257,
            ),
            // Password Old
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Color.fromARGB(228, 4, 5, 79)),
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    children: [
                      Obx(
                        () => TextField(
                          obscureText: controller.isPasswordHideold.value,
                          controller: controller.txtPassword,
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.key,
                              color: Color.fromARGB(228, 4, 5, 79),
                              //Color(0xFFA80216),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.isPasswordHideold.value =
                                    !controller.isPasswordHideold.value;
                              },
                              icon: const Icon(
                                Icons.visibility,
                                size: 20,
                                color: Color.fromARGB(228, 4, 5, 79),
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'Password Old',
                          ),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                          ),
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

            // New Password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Color.fromARGB(228, 4, 5, 79)),
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    children: [
                      Obx(
                        () => TextField(
                          obscureText: controller.isPasswordHidenew.value,
                          controller: controller.txtnewPassword,
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.key,
                              color: Color.fromARGB(228, 4, 5, 79),
                              //Color(0xFFA80216),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.isPasswordHidenew.value =
                                    !controller.isPasswordHidenew.value;
                              },
                              icon: const Icon(
                                Icons.visibility,
                                size: 20,
                                color: Color.fromARGB(228, 4, 5, 79),
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'New Password',
                          ),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                          ),
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

            // New Password Confirm
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Color.fromARGB(228, 4, 5, 79)),
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    children: [
                      Obx(
                        () => TextField(
                          obscureText: controller.isPasswordHideconfirm.value,
                          controller: controller.txtconfirmPassword,
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.key,
                              color: Color.fromARGB(228, 4, 5, 79),
                              //Color(0xFFA80216),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.isPasswordHideconfirm.value =
                                    !controller.isPasswordHideconfirm.value;
                              },
                              icon: const Icon(
                                Icons.visibility,
                                size: 20,
                                color: Color.fromARGB(228, 4, 5, 79),
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'Confirm Password',
                          ),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),

            Obx(
              () => ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 4, 5, 79)),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(
                      horizontal: 50,
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
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.updatePass();
                  }
                },
                child: Text(
                  (controller.isLoading.isFalse)
                      ? "Ubah Kata Sandi"
                      : "LOADING...",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
