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
        data!.add(DocumentVerificationData.fromJson(v));
      });
    }
    status = json['status'];
    allComplete = json['all_complete'];
    stage = json['stage'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['all_complete'] = allComplete;
    data['stage'] = stage;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['isComleted'] = isCompleted;
    return data;
  }
}
