import 'package:flutter/material.dart';
// ignore: must_be_immutable
class Dots extends StatelessWidget {
  bool isActive;
  Dots(this.isActive);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 210),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive?15:10,
      width: isActive?15:10,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: isActive?Colors.deepOrange[400]:Colors.grey,
      ),
      


    );
  }
}
