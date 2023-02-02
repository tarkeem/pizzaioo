import 'package:flutter/material.dart';
import 'package:pizza/controller/provider/cart.dart';
import 'package:pizza/view/screens/coffeSection.dart';
import 'package:pizza/view/screens/pizzaBoardScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:coffeeSc()
    );
  }
}
