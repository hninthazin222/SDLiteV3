import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustListModel with ChangeNotifier {
  final int id;
  final String customersyskey;
  final String customercode;
  final String customername;
  final String currency;
  final String address;

  CustListModel({
    required this.id,
    required this.customersyskey,
    required this.customercode,
    required this.customername,
    required this.currency,
    required this.address,
  });

  factory CustListModel.fromJson(Map<String, dynamic> json) {
    return CustListModel(
      id: json['id'],
      customersyskey: json['customersyskey'],
      customercode: json['customercode'],
      customername: json['customername'],
      currency: json['currency'],
      address: json['address'],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "customersyskey": customersyskey,
        "customercode": customercode,
        "customername": customername,
        "currency": currency,
        "address": address,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
