import 'package:flutter/material.dart';
import 'package:pizza/model/ingredient.dart';

class pizzaProvider extends ChangeNotifier
{
  List<ingredient>pizzaIngredient=[];
  late AnimationController controller;
  late List currIngredients;
  void setAnimationCtr(AnimationController ctr,List ingredients)
  {
    this.controller=ctr;
    this.currIngredients=ingredients;
  }
  void startButtonAnimation()
  {
    
    controller.forward(from: 0.0)..whenComplete(() {
      controller.reset();
      currIngredients=[];
      pizzaIngredient=[];
      ingredientCost=60;
      increseOrder();
    });
  }

  setIngredient(List<ingredient> ing)
  {
      pizzaIngredient=ing;
      notifyListeners();
  }
  DeleteIngredient(ingredient ing)
  {
      pizzaIngredient.remove(ing);
      increseCost(-1);
      notifyListeners();
  }
AddIngredient(ingredient ing)
  {
      pizzaIngredient.add(ing);
      notifyListeners();
  }
  int numOfOeder=0;
  increseOrder()
  {
    numOfOeder++;
    notifyListeners();
  }
  int ingredientCost=60;

increseCost(int x)
  {
    ingredientCost+=x;
    notifyListeners();
  }
}