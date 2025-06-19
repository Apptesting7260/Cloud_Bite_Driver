class FaqModel {
  String? type;
  String? subType;
  bool? success;
  String? message;
  List<FaqData>? data;
  String? count;
  String? timestamp;

  FaqModel(
      {this.type,
        this.subType,
        this.success,
        this.message,
        this.data,
        this.count,
        this.timestamp});

  FaqModel.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    subType = json['subType'].toString();
    success = json['success'];
    message = json['message'].toString();
    if (json['data'] != null) {
      data = <FaqData>[];
      json['data'].forEach((v) {
        data!.add(new FaqData.fromJson(v));
      });
    }
    count = json['count'].toString();
    timestamp = json['timestamp'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['subType'] = this.subType;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class FaqData {
  String? id;
  String? type;
  String? question;
  String? answer;

  FaqData({this.id, this.type, this.question, this.answer});

  FaqData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'].toString();
    question = json['question'].toString();
    answer = json['answer'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['question'] = this.question;
    data['answer'] = this.answer;
    return data;
  }
}
