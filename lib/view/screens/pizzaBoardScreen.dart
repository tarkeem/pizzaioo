import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pizza/controller/provider/cart.dart';
import 'package:pizza/model/ingredient.dart';
import 'package:provider/provider.dart';

double totalPrice = 20;

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
          Expanded(child: _pizzaBoard()),
          SizedBox(
            height: 5,
          ),
          AnimatedSwitcher(
            key: Key('${Provider.of<cart>(context).totalPrice}'),
              duration: Duration(milliseconds: 800),
              transitionBuilder: (child, animation) {
                return SlideTransition(
                    child: child,
                    position: animation.drive(Tween(
                        begin: Offset(0, 1), end: Offset(0, animation.value))));
              },
              child: Text('${Provider.of<cart>(context).totalPrice}')),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
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
  @override
  Widget build(BuildContext context) {
    return DragTarget<ingredient>(
        onAccept: (data) {
          Provider.of<cart>(context, listen: false).increase();
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
                //color: Colors.red,
                duration: Duration(seconds: 1),
                height:
                    isFocused ? constrain.maxHeight : constrain.maxHeight - 250,
                width:
                    isFocused ? constrain.maxWidth : constrain.maxWidth - 250,
                child: Center(
                  child: Stack(
                    //fit: StackFit.loose,
                    children: [
                      Image.asset(
                        'assets/images/dish.png',
                      ),
                      Image.asset('assets/images/pizza-1.png'),
                    ],
                  ),
                ),
              ),
            ));
  }
}

class pizaaIngredient extends StatelessWidget {
  pizaaIngredient(ingredient this.ingr);
  ingredient ingr;

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Image.asset(ingr.image),
      ),
    );
    return Draggable<ingredient>(data: ingr, feedback: child, child: child);
  }
}
