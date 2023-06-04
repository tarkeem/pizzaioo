import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pizza/controller/pizzaProvider.dart';
import 'package:pizza/model/ingredient.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math.dart' as math;

class pizzaBoard extends StatefulWidget {
  const pizzaBoard({super.key});

  @override
  State<pizzaBoard> createState() => _pizzaBoardState();
}

class _pizzaBoardState extends State<pizzaBoard> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _RotationAnimationController;
  late AnimationController _boxAnimation;
  late Animation _boxCloseAnimation;
  late Animation _pizzaOpacityAnimation;
  late Animation _pizzaScaleAnimation;
  late Animation _boxScaleAnimation;
  late Animation _boxTranslateAnimation;

  
   List<ingredient> currIngredients = [];
  ValueNotifier isFocused = ValueNotifier(false);
 
  late BoxConstraints _pizzaSize;
List<Animation> _animationList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _RotationAnimationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
        lowerBound: 0,
        upperBound: 1);

    //***************************

    _boxAnimation = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _boxScaleAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _boxAnimation, curve: Interval(0.0, 0.2)));
    _pizzaScaleAnimation =
        CurvedAnimation(parent: _boxAnimation, curve: Interval(0.3, 0.5));
    _boxCloseAnimation =
        CurvedAnimation(parent: _boxAnimation, curve: Interval(0.5, 0.7));
    _pizzaOpacityAnimation =
        CurvedAnimation(parent: _boxAnimation, curve: Interval(0.5, 0.69));
        _boxTranslateAnimation =
        CurvedAnimation(parent: _boxAnimation, curve: Interval(0.75, 0.9));
      
      

    Provider.of<pizzaProvider>(context, listen: false)
        .setAnimationCtr(_boxAnimation,currIngredients);

        _boxAnimation.addListener(() {

          if(_boxAnimation.isCompleted)
          {
            setState(() {
              currIngredients=[];
            });
            
          }
         });
  }

  String ChoosenpizzaSize = 'S';
  double get ChoosenpizzaSizeAsdouble {
    if (ChoosenpizzaSize == 'S') {
      return 60;
    } else if (ChoosenpizzaSize == 'M') {
      return 40;
    } else {
      return 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    currIngredients = Provider.of<pizzaProvider>(context,).pizzaIngredient;

     //Provider.of<pizzaProvider>(context,listen: false).setIngredient(currIngredients); wrong place
    var deviceSize=MediaQuery.of(context).size;
    return Stack(
      children: [
        AnimatedBuilder(
            animation: _boxScaleAnimation,
            builder: (context, child) => Transform.scale(
                scale: _boxScaleAnimation.value, child: Transform.translate(
                  offset:Offset(deviceSize.width*0.5*_boxTranslateAnimation.value,-deviceSize.height*0.5*_boxTranslateAnimation.value) ,
                  child: pizzaBox()))),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AnimatedBuilder(
                  animation: _boxAnimation,
                  builder: (context, child) => Opacity(
                      opacity: 1 - _pizzaOpacityAnimation.value as double,
                      child: Transform.scale(
                          scale: lerpDouble(1, 0.5, _pizzaScaleAnimation.value),
                          child: Transform.translate(
                            offset: Offset(0,50*_pizzaScaleAnimation.value as double),
                            child: pizzaPlateWid())))),
            ),
            SizedBox(
              height: 3,
            ),
            pizzaSizeWid(),
            SizedBox(
              height: 5,
            ),
            pizzaPriceWid(),
          ],
        ),
      ],
    );
  }

  Row pizzaSizeWid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        pizzaSize('S', () {
          setState(() {
            ChoosenpizzaSize = 'S';
          });
          _RotationAnimationController.forward(from: 0);
        }),
        pizzaSize('M', () {
          setState(() {
            ChoosenpizzaSize = 'M';
          });
          _RotationAnimationController.forward(from: 0);
        }),
        pizzaSize('L', () {
          setState(() {
            ChoosenpizzaSize = 'L';
          });
          _RotationAnimationController.forward(from: 0);
        }),
      ],
    );
  }

  Widget pizzaBox() {
    return LayoutBuilder(builder: (p0, p1) {
      double maxHeight = p1.maxHeight / 3;
      double maxWidth = p1.maxWidth / 3;

      return AnimatedBuilder(
        animation: _boxAnimation,
        builder: (context, child) => Stack(
          children: [
            Center(
              child: Transform(
                  alignment: Alignment.topCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.003)
                    ..rotateX(math.radians(-45)),
                  child: Image.asset(
                    'assets/images/pizza/box_inside.png',
                    width: maxWidth,
                    height: maxHeight,
                  )),
            ),
            Center(
              child: AnimatedBuilder(
                animation: _boxAnimation,
                builder: (context, child) => Transform(
                    alignment: Alignment.topCenter,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.003)
                      ..rotateX(math.radians(
                          lerpDouble(-140, -45, _boxCloseAnimation.value)!)),
                    child: Image.asset(
                      'assets/images/pizza/box_inside.png',
                      width: maxWidth,
                      height: maxHeight,
                    )),
              ),
            ),
            if (_boxAnimation.value > 0.6)
              Center(
                child: AnimatedBuilder(
                  animation: _boxAnimation,
                  builder: (context, child) => Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.003)
                        ..rotateX(math.radians(
                            lerpDouble(-140, -45, _boxCloseAnimation.value)!)),
                      child: Image.asset(
                        'assets/images/pizza/box_front.png',
                        width: maxWidth,
                        height: maxHeight,
                      )),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget pizzaSize(String siz, Function onTap) => GestureDetector(
        onTap: () {
          onTap();
        },
        child: AnimatedContainer(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(0),
          duration: Duration(milliseconds: 500),
          width: ChoosenpizzaSize == siz ? 30 : 20,
          height: ChoosenpizzaSize == siz ? 30 : 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
          child: Center(
            child: Text(
              siz,
              style: TextStyle(color: Colors.yellow),
            ),
          ),
        ),
      );

  AnimatedSwitcher pizzaPriceWid() {
    return AnimatedSwitcher(
      // layoutBuilder: (currentChild, previousChildren) => currentChild!,
      duration: Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          child: child,
          position: animation.drive(
              Tween(begin: Offset(0, 0), end: Offset(0, animation.value))),
        ),
      ),
      child: Text(
        '${Provider.of<pizzaProvider>(context).ingredientCost}',
        key:
            UniqueKey(), //if i use valueKey the text will move before aanimation of switcher.this key take diffrent value every setState
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  DragTarget<ingredient> pizzaPlateWid() {
    return DragTarget<ingredient>(
        onAccept: (data) {
          currIngredients.add(data);
          isFocused.value = false;

   Provider.of<pizzaProvider>(context,listen: false).setIngredient(currIngredients);
          setState(() {
           Provider.of<pizzaProvider>(context,listen: false).increseCost(1);
          });
          _buildIngredientAnimation();
          _animationController.forward(
              from:
                  0.0); //to start the animation more than one time so we have to reset the begin to zero
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

          print(currIngredients.length);
          return true;
        },
        builder: (context, candidateData, rejectedData) => LayoutBuilder(
              builder: (cxt, constrain) {
                _pizzaSize = constrain;
                return Center(
                  //if we remove center the animated container will take max space
                  child: ValueListenableBuilder(
                    valueListenable: isFocused,
                    builder: (context, value, child) => AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      height: isFocused.value
                          ? constrain.maxHeight
                          : constrain.maxHeight - ChoosenpizzaSizeAsdouble,
                      child: Center(
                        child: RotationTransition(
                          turns: CurvedAnimation(
                              parent: _RotationAnimationController,
                              curve: Curves.elasticOut),
                          child: Stack(
                            //fit: StackFit.loose,
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  'assets/images/pizza/dish.png',
                                ),
                              ),
                              Positioned.fill(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Hero(
                                    tag: '2',
                                    child: Image.asset(
                                        'assets/images/pizza/pizza-1.png'),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: AnimatedBuilder(
                                    animation: _animationController,
                                    builder: (context, child) =>
                                        _buildIngredientWidget()),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ));
  }

  Widget _buildIngredientWidget() {
    //print(currIngredients.length);
    
    List<Widget> widgets = [];
    if (!_animationList.isEmpty) {
      for (int j = 0; j < Provider.of<pizzaProvider>(context).pizzaIngredient.length; j++) {
        ingredient ingred =Provider.of<pizzaProvider>(context).pizzaIngredient[j];
        for (int i = 0; i < ingred.ingredientsOffset.length; i++) {
          final _animation = _animationList[i];
          final position = ingred.ingredientsOffset[i];
          final positionX = position.dx;
          final positionY = position.dy;
          double fromX = 0.0;
          double fromY = 0.0;

          if (j == Provider.of<pizzaProvider>(context).pizzaIngredient.length - 1) {
            if (i < 1) {
              fromX = _pizzaSize.maxWidth * (1 - _animation.value);
            } else if (i < 2) {
              fromX = _pizzaSize.maxWidth * (1 - _animation.value);
            } else if (i < 4) {
              fromY = _pizzaSize.maxHeight * (1 - _animation.value);
            } else {
              fromY = _pizzaSize.maxHeight * (1 - _animation.value);
            }

            if (_animation.value > 0) {
              widgets.add(
                Transform(
                  transform: Matrix4.identity()
                    ..translate(
                      fromX + _pizzaSize.maxWidth * positionX,
                      fromY + _pizzaSize.maxHeight * positionY,
                    ),
                  child: Image.asset(
                    ingred.image,
                    height: 30,
                  ),
                ),
              );
            }
          } else {
            widgets.add(
              Transform(
                transform: Matrix4.identity()
                  ..translate(
                    fromX + _pizzaSize.maxWidth * positionX,
                    fromY + _pizzaSize.maxHeight * positionY,
                  ),
                child: Image.asset(
                  ingred.image,
                  height: 30,
                ),
              ),
            );
          }
        }
      }
      return Stack(
        children: widgets,
      );
    }
    return SizedBox();
  }

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
}
