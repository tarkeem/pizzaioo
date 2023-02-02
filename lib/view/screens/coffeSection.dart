import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pizza/model/coffe.dart';

class coffeeSc extends StatefulWidget {
  const coffeeSc({super.key});

  @override
  State<coffeeSc> createState() => _coffeeScState();
}

class _coffeeScState extends State<coffeeSc> {
  PageController _pageController = PageController(viewportFraction: 0.35);

  double currentPage = 0.0;
  _coffeListener() {
    setState(() {
      currentPage = _pageController.page!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _pageController.addListener(_coffeListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.removeListener(_coffeListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned(
              top: 100,
              child: Container(
                color: Colors.red,
              )),
          Positioned(
            child: Container(
              color: Colors.red,
              child: Transform.scale(
                scale: 1.6,
                alignment: Alignment.bottomCenter,
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: coffees.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return SizedBox.shrink();
                    }
                    coffee coffeeItem = coffees[index - 1];
                    var res = currentPage - index + 1;
                    var val = -0.4 * res + 1;
                    var opacityVal = val.clamp(0.0, 1.0);
                    return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..translate(
                              0.0,
                              MediaQuery.of(context).size.height /
                                  2.6 *
                                  (1 - val).abs())
                          ..scale(val),
                        child: Opacity(
                            opacity: opacityVal,
                            child: Image.asset(coffeeItem.image)));
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
