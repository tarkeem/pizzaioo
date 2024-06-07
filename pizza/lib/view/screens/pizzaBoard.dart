import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pizza/controller/pizzaProvider.dart';
import 'package:pizza/model/ingredient.dart';
import 'package:pizza/view/widgets/ingredientItem.dart';
import 'package:pizza/view/widgets/piizzaBoardWid.dart';
import 'package:pizza/view/widgets/pizzaButton.dart';
import 'package:pizza/view/widgets/shakeTransition.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class pizzaBoardSc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          actions: [
            AnimatedSwitcher(
              key:Key(Provider.of<pizzaProvider>(context).numOfOeder.toString()),
              duration: Duration(milliseconds: 800),
              child: Container(
                child: Stack(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                      size: 50,
                    ),
                    CircleAvatar(
                      radius: 10,
                      child: Text('${Provider.of<pizzaProvider>(context).numOfOeder}'),
                      backgroundColor: Colors.green,
                    )
                  ],
                ),
              ),
              transitionBuilder:(child, animation) => ShakeTransition(
                offset: 50,
                child: Container(
                  child: Stack(
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                        size: 50,
                      ),
                      CircleAvatar(
                        radius: 10,
                        child: Text('${Provider.of<pizzaProvider>(context).numOfOeder}'),
                        backgroundColor: Colors.green,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
          backgroundColor: Colors.white,
          elevation: 50,
          centerTitle: true,
          title: Hero(
              tag: '5',
              child: Text('Pizzaioo',
                  style:
                      GoogleFonts.aboreto(fontSize: 30, color: Colors.black)))),
      body: Stack(
        children: [
          Positioned.fill(
            //without fill will be error
            left: 10,
            right: 10,
            bottom: 50,
            child: Card(
              elevation: 25,
              child: Column(
                children: [
                  Expanded(flex: 3, child: pizzaBoard()),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(flex: 1, child: ingredientListWid())
                ],
              ),
            ),
          ),
          Positioned(
              left: deviceSize.width / 2 - 40,
              right: deviceSize.width / 2 - 40,
              bottom: 15,
              child: GestureDetector(
                  onTap: () {
                    Provider.of<pizzaProvider>(context, listen: false)
                        .startButtonAnimation();

                        
                  },
                  child: pizzaButton()))
        ],
      ),
    );
  }
}

class ingredientListWid extends StatelessWidget {
  const ingredientListWid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ingredientList.length,
        itemBuilder: (context, index) {
          return pizaaIngredientItem(ingredientList[index]);
        },
      ),
    );
  }
}
