class DeliveryMethodModel {
  String? message;
  List<DeliveryMethodsData>? data;
  bool? status;
  String? type;

  DeliveryMethodModel({this.message, this.data, this.status, this.type});

  DeliveryMethodModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <DeliveryMethodsData>[];
      json['data'].forEach((v) {
        data!.add(DeliveryMethodsData.fromJson(v));
      });
    }
    status = json['status'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['type'] = type;
    return data;
  }
}

class DeliveryMethodsData {
  String? id;
  String? name;
  bool? status;

  DeliveryMethodsData({this.id, this.name, this.status});

  DeliveryMethodsData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    return data;
  }
}
