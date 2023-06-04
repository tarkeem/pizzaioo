import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pizza/model/pizza.dart';
import 'package:pizza/view/screens/pizzaBoard.dart';

class pizzaChoicePage extends StatefulWidget {
  const pizzaChoicePage({super.key});

  @override
  State<pizzaChoicePage> createState() => _pizzaChoicePageState();
}

class _pizzaChoicePageState extends State<pizzaChoicePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _animation1 = CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.bounceOut));
    _animation2 = CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.decelerate));
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Color> cols = [Colors.yellow, Colors.blue, Colors.green];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => Column(
                children: [
                  Transform.translate(
                      offset: Offset(0, 250 * (1 - _animation1.value)),
                      child: Hero(
                          tag: '1',
                          child: Text('Pizzaioo',
                              style: GoogleFonts.aboreto(fontSize: 30)))),
                  Expanded(
                    child: Opacity(
                      opacity: _animation2.value,
                      child: Transform.scale(
                        scale: 2,
                        child: Lottie.network(
                            'https://assets9.lottiefiles.com/packages/lf20_jBvjF3.json',
                            repeat: false,
                            controller: _animation2),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: CardSwiper(
                cardsCount: pizzes.length,
                cardBuilder: (context, index) {
                  Color col = cols[index % 3];
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  FadeTransition(
                                      opacity: animation,
                                      child: pizzaBoardSc()),
                        ));
                      },
                      child: pizzaCard(pizzes[index], col,index));
                }),
          )
        ],
      ),
    );
  }
}

Widget pizzaCard(pizza piz, Color col,int ind) {
  return Container(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(20), color: col),
    child: Center(
      child: Column(
        children: [
          Expanded(flex: 10, child: Hero(
            tag: '${ind+1}',
            child: Image.asset(piz.img))),
          Expanded(
              flex: 3,
              child: Column(
                children: [
                  Text(piz.name, style: GoogleFonts.aBeeZee(fontSize: 30)),
                  Text('${piz.price}\$', style: GoogleFonts.abel(fontSize: 30)),
                ],
              ))
        ],
      ),
    ),
  );
}
