import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
class pizzaButton extends StatefulWidget {
  const pizzaButton({super.key});

  @override
  State<pizzaButton> createState() => _pizzaButtonState();
}

class _pizzaButtonState extends State<pizzaButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
                padding: EdgeInsets.all(10),
                width: 80,
                height: 80,
                child: Center(child: Image.asset('assets/images/icons/pizza.png'),),
                decoration: BoxDecoration(
                  color:Colors.transparent,
                  shape: BoxShape.circle
                ),
              );
  }
}