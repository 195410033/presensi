import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:presensi/app/modules/new_password/views/background_password.dart';
import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.grey[300],
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.15,
            ),
            SvgPicture.asset(
              "assets/icons/nazma.svg",
              height: size.height * 0.35,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              'Lupa Password',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Text(
              'Silahkan Masukkan Email',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(
              height: 10,
            ),

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
            SizedBox(height: 15),

            // Button
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
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.new_password();
                  }
                },
                child: Text(
                  controller.isLoading.isFalse ? "SEND EMAIL" : "LOADING...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
