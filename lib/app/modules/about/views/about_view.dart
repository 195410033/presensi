import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'background_about.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(200, 10, 31, 103),
      ),
      body: Background(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset(
                "assets/images/nazma.png",
                height: size.height * 0.25,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "NaZMa Office telah memiliki pengalaman kurang lebih sekitar 12 tahun dalam bidang Konsultan IT dan Konsultan Manajemen.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Dalam bidang Konsultan IT sendiri, NaZMa memiliki beberapa produk unggulan di antaranya : Penjualan Hardware, Pembuatan dan Pengembangan Software, Pelatihan IT, Pembuatan Video Profil, Pengembangan Website, dan seterusnya.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Di bidang Konsultan Manajemen, NaZMa juga memiliki produk unggulan seperti : Pelatihan InHouse, Public Course, Sertifikasi, Event Organisasi dan Kajian- kajian.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "NaZMa telah beberapa kali bekerja sama dengan instansi- instansi pemerintahan, komunitas, perusahaan dan lembaga- lembaga pendidikan.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Produk yang NaZMa berikan menghasilkan nilai- nilai tambah atau value dengan prinsip "Well finish it" dengan target kepuasan pelanggan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
