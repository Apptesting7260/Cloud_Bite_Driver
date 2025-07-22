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
        data!.add(ListPersonalDocData.fromJson(v));
      });
    }
    status = json['status'];
    isComplete = json['isComplete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['isComplete'] = isComplete;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['isComplete'] = isComplete;
    return data;
  }
}
