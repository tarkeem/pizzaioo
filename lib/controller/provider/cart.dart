import 'package:flutter/cupertino.dart';

class cart extends ChangeNotifier {
  double totalPrice = 20;
  increase() {
    totalPrice++;
    notifyListeners();
  }
}
