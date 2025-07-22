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
        data!.add(AccountData.fromJson(v));
      });
    }
    isComplete = json['isComplete'];
    stage = json['stage'].toString();
    statusText = json['statusText'].toString();
    allRemarks = json['all_remarks'] != null
        ? AllRemarks.fromJson(json['all_remarks'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['type'] = type;
    data['statusMessage'] = statusMessage;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['isComplete'] = isComplete;
    data['stage'] = stage;
    data['statusText'] = statusText;
    if (allRemarks != null) {
      data['all_remarks'] = allRemarks!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['status'] = status;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_reject_remark'] = accountRejectRemark;
    data['personal_reject_remark'] = personalRejectRemark;
    return data;
  }
}
