// To parse this JSON data, do
//
//     final fetchPaymentMethodModel = fetchPaymentMethodModelFromJson(jsonString);

import 'dart:convert';

FetchPaymentMethodModel fetchPaymentMethodModelFromJson(String str) => FetchPaymentMethodModel.fromJson(json.decode(str));

String fetchPaymentMethodModelToJson(FetchPaymentMethodModel data) => json.encode(data.toJson());

class FetchPaymentMethodModel {
  bool? status;
  String? message;
  List<Datum>? data;

  FetchPaymentMethodModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchPaymentMethodModel.fromJson(Map<String, dynamic> json) => FetchPaymentMethodModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? methodId;
  String? methodName;
  int? driverId;
  String? number;

  Datum({
    this.methodId,
    this.methodName,
    this.driverId,
    this.number,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    methodId: json["method_id"],
    methodName: json["method_name"],
    driverId: json["driver_id"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "method_id": methodId,
    "method_name": methodName,
    "driver_id": driverId,
    "number": number,
  };
}
