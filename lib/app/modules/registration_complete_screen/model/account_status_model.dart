class AccountStatusModel {
  bool? status;
  String? type;
  String? statusMessage;
  String? message;
  List<AccountStatusData>? data;
  bool? isComplete;
  String? stage;

  AccountStatusModel(
      {this.status,
        this.type,
        this.statusMessage,
        this.message,
        this.data,
        this.isComplete,
        this.stage});

  AccountStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'].toString();
    statusMessage = json['statusMessage'].toString();
    message = json['message'].toString();
    if (json['data'] != null) {
      data = <AccountStatusData>[];
      json['data'].forEach((v) {
        data!.add(new AccountStatusData.fromJson(v));
      });
    }
    isComplete = json['isComplete'];
    stage = json['stage'].toString();
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
    return data;
  }
}

class AccountStatusData {
  String? name;
  String? status;

  AccountStatusData({this.name, this.status});

  AccountStatusData.fromJson(Map<String, dynamic> json) {
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
