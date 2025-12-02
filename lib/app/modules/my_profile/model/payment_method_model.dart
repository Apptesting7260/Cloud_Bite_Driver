// To parse this JSON data, do
//
//     final paymentMethodModel = paymentMethodModelFromJson(jsonString);

import 'dart:convert';

PaymentMethodModel paymentMethodModelFromJson(String str) => PaymentMethodModel.fromJson(json.decode(str));

String paymentMethodModelToJson(PaymentMethodModel data) => json.encode(data.toJson());

class PaymentMethodModel {
  bool? status;
  String? message;
  List<Datum>? data;
  BankAccountDetail? bankAccountDetail;

  PaymentMethodModel({
    this.status,
    this.message,
    this.data,
    this.bankAccountDetail,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) => PaymentMethodModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    bankAccountDetail: json["bankAccountDetail"] == null ? null : BankAccountDetail.fromJson(json["bankAccountDetail"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "bankAccountDetail": bankAccountDetail?.toJson(),
  };
}

class BankAccountDetail {
  int? id;
  String? name;
  String? bankName;
  String? accountNumber;
  String? accountType;
  String? ifscCode;
  String? status;
  String? pay2CellNumber;
  String? orangemoneyNumber;

  BankAccountDetail({
    this.id,
    this.name,
    this.bankName,
    this.accountNumber,
    this.accountType,
    this.ifscCode,
    this.status,
    this.pay2CellNumber,
    this.orangemoneyNumber,
  });

  factory BankAccountDetail.fromJson(Map<String, dynamic> json) => BankAccountDetail(
    id: json["id"],
    name: json["name"],
    bankName: json["bank_name"],
    accountNumber: json["account_number"],
    accountType: json["account_type"],
    ifscCode: json["ifsc_code"],
    status: json["status"],
    pay2CellNumber: json["pay2cell_number"],
    orangemoneyNumber: json["orangemoney_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "bank_name": bankName,
    "account_number": accountNumber,
    "account_type": accountType,
    "ifsc_code": ifscCode,
    "status": status,
    "pay2cell_number": pay2CellNumber,
    "orangemoney_number": orangemoneyNumber,
  };
}

class Datum {
  String? name;
  String? charge;
  int? paymentMethodId;

  Datum({
    this.name,
    this.charge,
    this.paymentMethodId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    charge: json["charge"],
    paymentMethodId: json["payment_method_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "charge": charge,
    "payment_method_id": paymentMethodId,
  };
}
