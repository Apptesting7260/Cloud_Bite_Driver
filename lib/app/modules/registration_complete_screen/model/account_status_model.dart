class AccountStatusModel {
  bool? status;
  String? type;
  String? statusMessage;
  String? message;
  List<AccountData>? data;
  bool? isComplete;
  String? stage;
  String? statusText;
  AllRemarks? allRemarks;

  AccountStatusModel(
      {this.status,
        this.type,
        this.statusMessage,
        this.message,
        this.data,
        this.isComplete,
        this.stage,
        this.statusText,
        this.allRemarks});

  AccountStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'].toString();
    statusMessage = json['statusMessage'].toString();
    message = json['message'].toString();
    if (json['data'] != null) {
      data = <AccountData>[];
      json['data'].forEach((v) {
        data!.add(new AccountData.fromJson(v));
      });
    }
    isComplete = json['isComplete'];
    stage = json['stage'].toString();
    statusText = json['statusText'].toString();
    allRemarks = json['all_remarks'] != null
        ? new AllRemarks.fromJson(json['all_remarks'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    data['statusMessage'] = this.statusMessage;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['isComplete'] = this.isComplete;
    data['stage'] = this.stage;
    data['statusText'] = this.statusText;
    if (this.allRemarks != null) {
      data['all_remarks'] = this.allRemarks!.toJson();
    }
    return data;
  }
}

class AccountData {
  String? name;
  String? status;

  AccountData({this.name, this.status});

  AccountData.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}

class AllRemarks {
  String? accountRejectRemark;
  String? personalRejectRemark;

  AllRemarks({this.accountRejectRemark, this.personalRejectRemark});

  AllRemarks.fromJson(Map<String, dynamic> json) {
    accountRejectRemark = json['account_reject_remark'].toString();
    personalRejectRemark = json['personal_reject_remark'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_reject_remark'] = this.accountRejectRemark;
    data['personal_reject_remark'] = this.personalRejectRemark;
    return data;
  }
}
