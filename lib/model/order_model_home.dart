// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));



class OrderModel {
  OrderModel({
    @required this.id,
    @required this.quantity,
    @required this.price,
    @required this.discount,
    @required this.vat,
    @required this.orderDateAndTime,
    @required this.user,
    @required this.payment,
    @required this.orderStatus,
  });

  final int? id;
  final int ?quantity;
  final int ?price;
  final dynamic discount;
  final dynamic vat;
  final DateTime? orderDateAndTime;
  final User ?user;
  final Payment ?payment;
  final OrderStatus? orderStatus;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    quantity: json["quantity"],
    price: json["price"],
    discount: json["discount"],
    vat: json["VAT"],
    orderDateAndTime: DateTime.parse(json["order_date_and_time"]),
    user: User.fromJson(json["user"]),
    payment: Payment.fromJson(json["payment"]),
    orderStatus: OrderStatus.fromJson(json["order_status"]),
  );


}

class OrderStatus {
  OrderStatus({
    @required this.orderStatusCategory,
  });

  final User ?orderStatusCategory;

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
    orderStatusCategory: User.fromJson(json["order_status_category"]),
  );


}

class User {
  User({
    @required this.id,
    @required this.name,
  });

  final int ?id;
  final String ?name;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
  );


}

class Payment {
  Payment({
    @required this.paymentStatus,
  });

  final int? paymentStatus;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    paymentStatus: json["payment_status"],
  );


}
