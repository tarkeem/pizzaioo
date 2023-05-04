import 'package:flutter/animation.dart';

class ingredient {
  String image;
  List<Offset> ingredientsOffset;
  ingredient(this.image, this.ingredientsOffset);
}

List<ingredient> ingredientList = [
  ingredient('assets/images/ingredient/cheese.png', [
    Offset(0.3, 0.6),
    Offset(0.65, 0.3),
    Offset(0.45, 0.3),
    Offset(0.25, 0.25),
     Offset(0.6, 0.6),
  ]),
  ingredient('assets/images/ingredient/chili.png', [
    Offset(0.3, 0.6),
    Offset(0.65, 0.3),
    Offset(0.45, 0.3),
    Offset(0.25, 0.25),
     Offset(0.6, 0.25),
  ]),
  ingredient('assets/images/ingredient/olive.png', [
     Offset(0.3, 0.6),
    Offset(0.65, 0.3),
    Offset(0.45, 0.3),
    Offset(0.25, 0.25),
     Offset(0.6, 0.25),
  ]),
  ingredient('assets/images/ingredient/onion.png', [
     Offset(0.3, 0.6),
    Offset(0.65, 0.3),
    Offset(0.45, 0.3),
    Offset(0.25, 0.25),
     Offset(0.6, 0.25),
  ]),
  ingredient('assets/images/ingredient/pea.png', [
    Offset(0.3, 0.6),
    Offset(0.65, 0.3),
    Offset(0.45, 0.3),
    Offset(0.25, 0.25),
     Offset(0.6, 0.25),
  ]),
  ingredient('assets/images/ingredient/pickle.png', [
    Offset(0.3, 0.6),
    Offset(0.65, 0.3),
    Offset(0.45, 0.3),
    Offset(0.25, 0.25),
     Offset(0.6, 0.25),
  ]),
];
