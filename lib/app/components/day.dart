import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Day extends StatelessWidget {
  const Day({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var result = DateFormat('EEEE, dd MMMM yyyy').format(now);
    return Text(
      result,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontFamily: 'Poppins',
      ),
    );
  }
}
