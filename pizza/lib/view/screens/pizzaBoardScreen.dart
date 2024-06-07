import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pizza/controller/provider/cart.dart';
import 'package:pizza/model/pizza.dart';
import 'package:provider/provider.dart';

import '../../model/ingredient.dart';

class pizzaBoardSc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'your pizza',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Flexible(flex: 3, child: _pizzaBoard()),
          SizedBox(
            height: 5,
          ),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.purple.withOpacity(0.7)
                      ])),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ingredientList.length,
                    itemBuilder: (context, index) =>
                        pizaaIngredient(ingredientList[index]),
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: Text('Order Now'))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _pizzaBoard extends StatefulWidget {
  const _pizzaBoard({super.key});

  @override
  State<_pizzaBoard> createState() => __pizzaBoardState();
}

class __pizzaBoardState extends State<_pizzaBoard> {
  bool isFocused = false;
  int totalPrice = 25;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: DragTarget<ingredient>(
              onAccept: (data) {
                print('accept');
                setState(() {
                  totalPrice++;
                  print(totalPrice);
                  isFocused = false;
                });
              },
              onLeave: (data) {},
              onWillAccept: (data) {
                print('on will accept');
                setState(() {
                  isFocused = true;
                });
                return true;
              },
              builder: (context, candidateData, rejectedData) => LayoutBuilder(
                    builder: (cxt, constrain) => AnimatedContainer(
                      color: Colors.red,
                      duration: Duration(seconds: 1),
                      height: 10,
                      width: isFocused
                          ? constrain.maxWidth - 200
                          : constrain.maxWidth - 250,
                      child: Center(
                        child: Stack(
                          //fit: StackFit.loose,
                          children: [
                            Image.asset(
                              'assets/images/pizzaImages/dish.png',
                            ),
                            Image.asset('assets/images/pizzaImages/pizza-1.png'),
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 800),
          transitionBuilder: (child, animation) {
            return SlideTransition(
                child: child,
                position: animation.drive(Tween(
                    begin: Offset(0, 1), end: Offset(0, animation.value))));
          },
          child: Text(
            '$totalPrice\$',
            key: Key('$totalPrice'),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class pizaaIngredient extends StatelessWidget {
  pizaaIngredient(ingredient this.ingr);
  ingredient ingr;

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      height: 100,
      width: 100,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Image.asset(ingr.image),
      ),
    );
    return Draggable<ingredient>(data: ingr, feedback: child, child: child);
  }
}
