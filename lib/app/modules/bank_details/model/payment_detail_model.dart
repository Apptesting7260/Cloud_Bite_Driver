// To parse this JSON data, do
//
//     final paymentDetailsModel = paymentDetailsModelFromJson(jsonString);

import 'dart:convert';

PaymentDetailsModel paymentDetailsModelFromJson(String str) => PaymentDetailsModel.fromJson(json.decode(str));

String paymentDetailsModelToJson(PaymentDetailsModel data) => json.encode(data.toJson());

class PaymentDetailsModel {
  bool? status;
  List<Datum>? data;

  PaymentDetailsModel({
    this.status,
    this.data,
  });

  factory PaymentDetailsModel.fromJson(Map<String, dynamic> json) => PaymentDetailsModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? name;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
