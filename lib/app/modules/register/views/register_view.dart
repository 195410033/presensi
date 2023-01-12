import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:presensi/app/modules/register/views/background_register.dart';
import 'package:presensi/app/routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Colors.grey[300],
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.08,
            ),
            SvgPicture.asset(
              "assets/icons/nazma.svg",
              height: size.height * 0.3,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'Daftar',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
            Text(
              'Daftarkan diri kamu disini.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
              ),
            ),
            SizedBox(height: 20),

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
            SizedBox(height: 15),

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
                    controller: controller.txtJabatan,
                    decoration: InputDecoration(
                      icon: Icon(
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
            SizedBox(height: 15),

            // Password
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
                  child: Column(
                    children: [
                      Obx(
                        () => TextField(
                          obscureText: controller.isPasswordHide.value,
                          controller: controller.txtPassword,
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.key,
                              color: Color.fromARGB(228, 4, 5, 79),
                              //Color(0xFFA80216),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.isPasswordHide.value =
                                    !controller.isPasswordHide.value;
                              },
                              icon: const Icon(
                                Icons.visibility,
                                size: 20,
                                color: Color.fromARGB(228, 4, 5, 79),
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'Password',
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
                    await controller.add();
                  }
                },
                child: Text(
                  controller.isLoading.isFalse ? "DAFTAR" : "LOADING...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),

            //register page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sudah punya akun ?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                  ),
                ),
                ButtonTheme(
                  child: TextButton(
                    onPressed: () => Get.toNamed(Routes.LOGIN),
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
