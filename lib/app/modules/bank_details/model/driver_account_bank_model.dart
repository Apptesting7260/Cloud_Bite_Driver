class DriverAccountDetailsModel {
  String? type;
  String? message;
  DriverBankAccountData? data;
  bool? status;
  String? stage;

  DriverAccountDetailsModel(
      {this.type, this.message, this.data, this.status, this.stage});

  DriverAccountDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    message = json['message'].toString();
    data = json['data'] != null ? DriverBankAccountData.fromJson(json['data']) : null;
    status = json['status'];
    stage = json['stage'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    data['stage'] = stage;
    return data;
  }
}

class DriverBankAccountData {
  String? id;
  String? driverId;
  String? bankName;
  String? accountHolderName;
  String? accountNumber;
  String? retypeAccountNumber;
  String? accountType;
  String? ifscCode;
  String? createdAt;
  String? updatedAt;

  DriverBankAccountData(
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

  DriverBankAccountData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    driverId = json['driver_id'].toString();
    bankName = json['bank_name'].toString();
    accountHolderName = json['account_holder_name'].toString();
    accountNumber = json['account_number'].toString();
    retypeAccountNumber = json['retype_account_number'].toString();
    accountType = json['account_type'].toString();
    ifscCode = json['ifsc_code'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['driver_id'] = driverId;
    data['bank_name'] = bankName;
    data['account_holder_name'] = accountHolderName;
    data['account_number'] = accountNumber;
    data['retype_account_number'] = retypeAccountNumber;
    data['account_type'] = accountType;
    data['ifsc_code'] = ifscCode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
