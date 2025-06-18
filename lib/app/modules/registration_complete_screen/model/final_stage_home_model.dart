class HomeStageModel {
  String? message;
  bool? status;
  String? type;
  String? stages;

  HomeStageModel({this.message, this.status, this.type, this.stages});

  HomeStageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    status = json['status'];
    type = json['type'].toString();
    stages = json['stages'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['type'] = this.type;
    data['stages'] = this.stages;
    return data;
  }
}
