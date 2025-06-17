class AccountStatusModel {
  bool? status;
  String? type;
  String? statusMessage;
  String? message;
  AccountStatusData? data;
  String? stage;

  AccountStatusModel(
      {this.status,
        this.type,
        this.statusMessage,
        this.message,
        this.data,
        this.stage});

  AccountStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    statusMessage = json['statusMessage'];
    message = json['message'];
    data = json['data'] != null ? new AccountStatusData.fromJson(json['data']) : null;
    stage = json['stage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    data['statusMessage'] = this.statusMessage;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['stage'] = this.stage;
    return data;
  }
}

class AccountStatusData {
  String? personalDocsStatus;
  String? accountStatus;
  bool? isComplete;
  String? vehicleDetails;

  AccountStatusData(
      {this.personalDocsStatus,
        this.accountStatus,
        this.isComplete,
        this.vehicleDetails});

  AccountStatusData.fromJson(Map<String, dynamic> json) {
    personalDocsStatus = json['Personal_docs_status'].toString();
    accountStatus = json['Account_status'].toString();
    isComplete = json['isComplete'];
    vehicleDetails = json['VehicleDetails'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Personal_docs_status'] = this.personalDocsStatus;
    data['Account_status'] = this.accountStatus;
    data['isComplete'] = this.isComplete;
    data['VehicleDetails'] = this.vehicleDetails;
    return data;
  }
}
