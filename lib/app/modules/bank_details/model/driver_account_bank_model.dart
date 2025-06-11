class DriverAccountModel {
  String? type;
  String? message;
  Data? data;
  bool? status;

  DriverAccountModel({this.type, this.message, this.data, this.status});

  DriverAccountModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  int? driverId;
  String? bankName;
  String? accountHolderName;
  String? accountNumber;
  String? retypeAccountNumber;
  String? accountType;
  String? ifscCode;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.driverId,
        this.bankName,
        this.accountHolderName,
        this.accountNumber,
        this.retypeAccountNumber,
        this.accountType,
        this.ifscCode,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverId = json['driver_id'];
    bankName = json['bank_name'];
    accountHolderName = json['account_holder_name'];
    accountNumber = json['account_number'];
    retypeAccountNumber = json['retype_account_number'];
    accountType = json['account_type'];
    ifscCode = json['ifsc_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['driver_id'] = this.driverId;
    data['bank_name'] = this.bankName;
    data['account_holder_name'] = this.accountHolderName;
    data['account_number'] = this.accountNumber;
    data['retype_account_number'] = this.retypeAccountNumber;
    data['account_type'] = this.accountType;
    data['ifsc_code'] = this.ifscCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
