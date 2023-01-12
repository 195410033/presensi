import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            //height: size.height * 0.2,
            child: Image.asset(
              "assets/images/Illustration-background_3.png",
              fit: BoxFit.fill,
              color: Color.fromARGB(70, 10, 31, 103),
            ),
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            //height: size.height * 0.37,
            child: Image.asset(
              "assets/images/nazma_1.png",
              fit: BoxFit.fill,
              //color: Color.fromARGB(129, 10, 31, 103),
            ),
          ),
          child
        ],
      ),
    );
  }
}