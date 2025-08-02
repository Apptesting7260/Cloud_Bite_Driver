class PaymentMethodModel {
  bool? status;
  String? message;
  List<PaymentData>? data;

  PaymentMethodModel({this.status, this.data});

  PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    if (json['data'] != null) {
      data = <PaymentData>[];
      json['data'].forEach((v) {
        data!.add(PaymentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentData {
  String? name;
  String? charge;
  String? paymentMethodId;

  PaymentData({this.name, this.charge, this.paymentMethodId});

  PaymentData.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    charge = json['charge']?.toString();
    paymentMethodId = json['payment_method_id']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['charge'] = charge;
    data['payment_method_id'] = paymentMethodId;
    return data;
  }
}
