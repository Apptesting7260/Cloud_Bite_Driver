/*
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
*/
class PaymentMethodModel {
  bool? status;
  List<Data>? data;
  String? message;
  BankAccountDetail? bankAccountDetail;

  PaymentMethodModel({this.status, this.data, this.bankAccountDetail});

  PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    bankAccountDetail = json['bankAccountDetail'] != null
        ? new BankAccountDetail.fromJson(json['bankAccountDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.bankAccountDetail != null) {
      data['bankAccountDetail'] = this.bankAccountDetail!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? charge;
  String? paymentMethodId;

  Data({this.name, this.charge, this.paymentMethodId});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    charge = json['charge'].toString();
    paymentMethodId = json['payment_method_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['charge'] = this.charge;
    data['payment_method_id'] = this.paymentMethodId;
    return data;
  }
}

class BankAccountDetail {
  String? id;
  String? name;
  String? bankName;
  String? accountNumber;
  String? accountType;
  String? ifscCode;
  String? status;

  BankAccountDetail(
      {this.id,
        this.name,
        this.bankName,
        this.accountNumber,
        this.accountType,
        this.ifscCode,
        this.status});

  BankAccountDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    bankName = json['bank_name'].toString();
    accountNumber = json['account_number'].toString();
    accountType = json['account_type'].toString();
    ifscCode = json['ifsc_code'].toString();
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['bank_name'] = this.bankName;
    data['account_number'] = this.accountNumber;
    data['account_type'] = this.accountType;
    data['ifsc_code'] = this.ifscCode;
    data['status'] = this.status;
    return data;
  }
}
