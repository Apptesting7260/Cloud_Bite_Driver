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
        data!.add(new DeliveryMethodsData.fromJson(v));
      });
    }
    status = json['status'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['type'] = this.type;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}
