import 'package:flutter/material.dart';


class Slide {
  final String imageUrl;
  final String price;
  final String title;
  final String description ;

 Slide({
   @required this.imageUrl,
   @required this.price,
   @required this.title,
   @required this.description,
 });
}
final slideList = [
  Slide(imageUrl: "images/ponmo1.jpg",
        price: "#300",
          title: "Thick and Soft",
        description: "Pefect replacement for individual with excess fats, easily replace meat, and sure creates a new fantasy.",


        ),
  Slide(imageUrl: "images/ponmo2.jpg",
      price: "#200",
      title: "Round and Soft",
      description: "Specially design for individuals with great cook, gives more details about the stew, you know.",
  ),
  Slide(imageUrl: "images/ponmo3.jpg",
      price: "#100",
      title: "Normal",
      description:"Best use for spicing vegetables and other sorts, goes well with many other fast foods, e.g indomie. ",
  ),


];