import 'package:flutter/foundation.dart';

class OrderInfo {
  String number;
  String address;
  String first;
  String last;
  String middle;
  String city;
  int pincode;
  bool seen;
  final String Category;
  String ConfirmOrderDate;
  String DeliveryDate;
  bool EnableItem;
  final int PaidAmmount;
  final String ItemName;
  final String color;
  final OrderDate;
  String paymentId;
  String paymenType;
  final int quantity;
  final String OrderId;
  String reasonForDenied;
  String status;
  String UserId;

  OrderInfo( {
    this.OrderId,
    this.quantity,
    this.Category,
    this.PaidAmmount,
    this.ItemName,
    this.color,
    this.OrderDate,
    this.number,
    this.address,
    this.first,
    this.middle,
    this.last,
    this.city,
    this.pincode,
    this.seen,
  });
}
