import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pizza/model/ingredient.dart';

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
                  Expanded(flex: 3, child: _pizzaBoard()),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(flex: 1, child: ingredientListWid())
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 25,
              child: ElevatedButton(onPressed: () {}, child: Text('Order Now')))
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
        itemBuilder: (context, index) =>
            pizaaIngredientItem(ingredientList[index]),
      ),
    );
  }
}

class _pizzaBoard extends StatefulWidget {
  const _pizzaBoard({super.key});

  @override
  State<_pizzaBoard> createState() => __pizzaBoardState();
}

class __pizzaBoardState extends State<_pizzaBoard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  List<Animation> _animationList = [];

  final List<ingredient> currIngredients = [];
  ValueNotifier isFocused = ValueNotifier(false);
  int totalPrice = 25;
  late BoxConstraints _pizzaSize;
  _buildIngredientAnimation() {
    _animationList.clear();
    _animationList.add(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.2, curve: Curves.decelerate)));
    _animationList.add(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.3, 0.4, curve: Curves.decelerate)));
    _animationList.add(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.5, 0.6, curve: Curves.decelerate)));
    _animationList.add(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.7, 0.8, curve: Curves.decelerate)));
    _animationList.add(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.9, 1.0, curve: Curves.decelerate)));
  }

  Widget _buildIngredientWidget() {

    //print(currIngredients.length);
    List<Widget> widgets = [];
    if (!_animationList.isEmpty) {
      for (int j=0;j<currIngredients.length;j++) {
        ingredient ingred=currIngredients[j];
        for (int i = 0; i < ingred.ingredientsOffset.length; i++) {
          final _animation = _animationList[i];
          final position = ingred.ingredientsOffset[i];
          final positionX = position.dx;
          final positionY = position.dy;
          double fromX = 0.0;
          double fromY = 0.0;

          if(j==currIngredients.length-1)
          {
          if (i < 1) {
            fromX = _pizzaSize.maxWidth * (1 - _animation.value);
          } else if (i < 2) {
            fromX = _pizzaSize.maxWidth * (1 - _animation.value);
          } else if (i < 4) {
            fromY = _pizzaSize.maxHeight * (1 - _animation.value);
          } else {
            fromY = _pizzaSize.maxHeight * (1 - _animation.value);
          }

          if(_animation.value>0)
          {
             widgets.add(
            Transform(
              transform: Matrix4.identity()..translate(fromX+_pizzaSize.maxWidth*positionX,
              fromY+_pizzaSize.maxHeight*positionY,
              ),
              child: Image.asset(
                ingred.image,
                height: 50,
              ),
            ),
          );
          }
          }
          else
          {
             widgets.add(
            Transform(
              transform: Matrix4.identity()..translate(fromX+_pizzaSize.maxWidth*positionX,
              fromY+_pizzaSize.maxHeight*positionY,
              ),
              child: Image.asset(
                ingred.image,
                height: 50,
              ),
            ),
          );
          }
         
        }
      } return Stack(
            children:widgets,
          );
    }
    return SizedBox();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
  }

  @override
  Widget build(BuildContext context) {
    
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DragTarget<ingredient>(
                        onAccept: (data) {
        
                          isFocused.value = false;
                          setState(() {
                            totalPrice++;

                          });
                          _buildIngredientAnimation();
                          _animationController.forward(from: 0.0);//to start the animation more than one time so we have to reset the begin to zero
                        },
                        onLeave: (data) {
                          isFocused.value = false;
                        },
                        onWillAccept: (data) {
        
                          for (ingredient i in currIngredients) {
                            if (i.image == data!.image) {
                              print('here');
                              return false;
                            }
                          }
        
                          isFocused.value = true;
        
                          currIngredients.add(data!);
                          print(currIngredients.length);
                          return true;
                        },
                        builder: (context, candidateData, rejectedData) =>
                            LayoutBuilder(
                              builder: (cxt, constrain) {
                                _pizzaSize = constrain;
                                return Center(
                                  //if we remove center the animated container will take max space
                                  child: ValueListenableBuilder(
                                    valueListenable: isFocused,
                                    builder: (context, value, child) =>
                                        AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      height: isFocused.value
                                          ? constrain.maxHeight
                                          : constrain.maxHeight - 10,
                                      child: Center(
                                        child: Stack(
                                          //fit: StackFit.loose,
                                          children: [
                                            Positioned.fill(
                                              child: Image.asset(
                                                'assets/images/pizza/dish.png',
                                              ),
                                            ),
                                            Positioned.fill(
                                              child: Image.asset(
                                                  'assets/images/pizza/pizza-1.png'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AnimatedSwitcher(
                    // layoutBuilder: (currentChild, previousChildren) => currentChild!,
                    duration: Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        child: child,
                        position: animation.drive(Tween(
                            begin: Offset(0, 0), end: Offset(0, animation.value))),
                      ),
                    ),
                    child: Text(
                      '$totalPrice\$',
                      key:
                          UniqueKey(), //if i use valueKey the text will move before aanimation of switcher
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              AnimatedBuilder(
                animation: _animationController,
                builder:(context, child) => _buildIngredientWidget())
            ],
          );
        
  }
}

class pizaaIngredientItem extends StatelessWidget {
  pizaaIngredientItem(ingredient this.ingr);
  ingredient ingr;

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      height: 50,
      width: 50,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Image.asset(ingr.image),
      ),
    );
    return Draggable<ingredient>(data: ingr, feedback: child, child: child);
  }
}
