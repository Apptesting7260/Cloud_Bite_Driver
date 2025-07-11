class DocumentListModel {
  String? message;
  String? type;
  List<DocumentVerificationData>? data;
  bool? status;
  bool? allComplete;
  String? stage;

  DocumentListModel(
      {this.message,
        this.type,
        this.data,
        this.status,
        this.allComplete,
        this.stage});

  DocumentListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    type = json['type'].toString();
    if (json['data'] != null) {
      data = <DocumentVerificationData>[];
      json['data'].forEach((v) {
        data!.add(new DocumentVerificationData.fromJson(v));
      });
    }
    status = json['status'];
    allComplete = json['all_complete'];
    stage = json['stage'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['all_complete'] = this.allComplete;
    data['stage'] = this.stage;
    return data;
  }
}

class DocumentVerificationData {
  String? id;
  String? name;
  bool? status;
  bool? isCompleted;

  DocumentVerificationData({this.id, this.name, this.status, this.isCompleted});

  DocumentVerificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    status = json['status'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['isComleted'] = this.isCompleted;
    return data;
  }
}
