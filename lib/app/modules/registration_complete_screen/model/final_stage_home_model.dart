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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['type'] = type;
    data['stages'] = stages;
    return data;
  }
}
