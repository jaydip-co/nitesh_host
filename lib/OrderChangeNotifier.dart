import 'package:flutter/material.dart';
class OrderChangeNotifier extends ChangeNotifier{
  String currentOrderStatus = "new Order";
  void setCurrentOrderStatus(String status){
    currentOrderStatus = status;
    notifyListeners();
  }
}