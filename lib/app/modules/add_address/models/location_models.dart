import 'dart:convert';

AllLocationResponse allLocationResponseFromJson(String str) => AllLocationResponse.fromJson(json.decode(str));

String allLocationResponseToJson(AllLocationResponse data) => json.encode(data.toJson());

class AllLocationResponse {
  bool? status;
  String? message;
  List<Address>? addresses;

  AllLocationResponse({
    this.status,
    this.message,
    this.addresses,
  });

  factory AllLocationResponse.fromJson(Map<String, dynamic> json) => AllLocationResponse(
    status: json["status"],
    message: json["message"],
    addresses: json["addresses"] == null ? [] : List<Address>.from(json["addresses"]!.map((x) => Address.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "addresses": addresses == null ? [] : List<dynamic>.from(addresses!.map((x) => x.toJson())),
  };
}

class Address {
  int? id;
  String? type;
  bool? isDefault;
  String? completeAddress;
  double? latitude;
  double? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? saveAs;

  Address({
    this.id,
    this.type,
    this.isDefault,
    this.completeAddress,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.saveAs,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    type: json["type"],
    isDefault: json["is_default"],
    completeAddress: json["complete_address"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    saveAs: json["save_as"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "is_default": isDefault,
    "complete_address": completeAddress,
    "latitude": latitude,
    "longitude": longitude,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "save_as": saveAs,
  };
}
