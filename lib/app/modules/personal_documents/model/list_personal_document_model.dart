class ListPersonalDocumentModel {
  String? message;
  String? type;
  List<ListPersonalDocData>? data;
  bool? status;
  bool? isComplete;

  ListPersonalDocumentModel(
      {this.message, this.type, this.data, this.status, this.isComplete});

  ListPersonalDocumentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    type = json['type'].toString();
    if (json['data'] != null) {
      data = <ListPersonalDocData>[];
      json['data'].forEach((v) {
        data!.add(new ListPersonalDocData.fromJson(v));
      });
    }
    status = json['status'];
    isComplete = json['isComplete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['isComplete'] = this.isComplete;
    return data;
  }
}

class ListPersonalDocData {
  String? id;
  String? name;
  bool? status;
  bool? isComplete;

  ListPersonalDocData({this.id, this.name, this.status, this.isComplete});

  ListPersonalDocData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    status = json['status'];
    isComplete = json['isComplete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['isComplete'] = this.isComplete;
    return data;
  }
}
