import 'package:flutter/material.dart';
import 'package:pizza/controller/pizzaProvider.dart';
import 'package:pizza/model/ingredient.dart';
import 'package:provider/provider.dart';
class pizaaIngredientItem extends StatelessWidget {
  pizaaIngredientItem(ingredient this.ingr);
  ingredient ingr;

  @override
  Widget build(BuildContext context) {
    List<ingredient> currIngredients=Provider.of<pizzaProvider>(context).pizzaIngredient;
    Widget child = Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:currIngredients.contains(ingr)? Colors.red:Colors.transparent,
        ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Image.asset(ingr.image),
      ),
    );
    return currIngredients.contains(ingr)?GestureDetector(
      onTap: () {
        Provider.of<pizzaProvider>(context,listen: false).DeleteIngredient(ingr);
      },
      child: child,
    ): Draggable<ingredient>(data: ingr, feedback: child, child: child);
  }
}