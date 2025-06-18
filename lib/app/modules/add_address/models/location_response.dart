// To parse this JSON data, do
//
//     final locationResponse = locationResponseFromJson(jsonString);

import 'dart:convert';

LocationResponse locationResponseFromJson(String str) => LocationResponse.fromJson(json.decode(str));

String locationResponseToJson(LocationResponse data) => json.encode(data.toJson());

class LocationResponse {
  bool? status;
  String? message;
  String? type;
  Addresses? address;

  LocationResponse({
    this.status,
    this.message,
    this.address,
    this.type,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) => LocationResponse(
    status: json["status"],
    message: json["message"].toString(),
    type: json["type"].toString(),
    address: json["address"] == null ? null : Addresses.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "type": type,
    "address": address?.toJson(),
  };
}

class Addresses {
  int? id;
  int? userId;
  String? type;
  bool? isDefault;
  String? completeAddress;
  String? coordinates;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? houseNo;

  Addresses({
    this.id,
    this.userId,
    this.type,
    this.isDefault,
    this.completeAddress,
    this.coordinates,
    this.createdAt,
    this.updatedAt,
    this.houseNo,
  });

  factory Addresses.fromJson(Map<String, dynamic> json) => Addresses(
    id: json["id"],
    userId: json["user_id"],
    type: json["type"],
    isDefault: json["is_default"],
    completeAddress: json["complete_address"],
    coordinates: json["coordinates"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    houseNo: json["house_no"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "type": type,
    "is_default": isDefault,
    "complete_address": completeAddress,
    "coordinates": coordinates,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "house_no": houseNo,
  };
}
