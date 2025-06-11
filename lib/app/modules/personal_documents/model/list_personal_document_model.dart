import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ListPersonalDocumentModel {
  String? message;
  String? type;
  RxList<PersonalDocumentData>? data;
  bool? status;

  ListPersonalDocumentModel({this.message, this.type, this.data, this.status});

  ListPersonalDocumentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    type = json['type'];
    if (json['data'] != null) {
      data = <PersonalDocumentData>[].obs;
      json['data'].forEach((v) {
        data!.add(new PersonalDocumentData.fromJson(v));
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

class PersonalDocumentData {
  String? id;
  String? name;
  bool? status;

  PersonalDocumentData({this.id, this.name, this.status});

  PersonalDocumentData.fromJson(Map<String, dynamic> json) {
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
