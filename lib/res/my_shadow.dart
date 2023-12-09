import 'package:flutter/material.dart';

class MyShadow {
  static List<BoxShadow> boxShadowNeuMorphism() {
    return const [
       BoxShadow(
        color: Color(0xFF060C18),
        blurRadius: 15,
        offset: Offset(5, 5),
      ),
      //lighter shadow on top left
       BoxShadow(
        color: Color.fromRGBO(58, 68, 93, 0.50),
        blurRadius: 15,
        offset: Offset(-5, -5),
      )
    ];
  }
}
