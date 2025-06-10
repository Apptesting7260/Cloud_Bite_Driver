import '../../../core/app_exports.dart';

class DocumentListModel {
  String? message;
  String? type;
  RxList<DocumentListData>? data;
  bool? status;

  DocumentListModel({this.message, this.type, this.data, this.status});

  DocumentListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    type = json['type'];
    if (json['data'] != null) {
      data = <DocumentListData>[].obs;
      json['data'].forEach((v) {
        data!.add(new DocumentListData.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class DocumentListData {
  String? id;
  String? name;
  bool? status;

  DocumentListData({this.id, this.name, this.status});

  DocumentListData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}
