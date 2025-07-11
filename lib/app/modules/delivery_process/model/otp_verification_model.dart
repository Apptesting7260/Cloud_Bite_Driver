class OtpVerificationModel {
  bool? status;
  String? message;

  OtpVerificationModel({
    this.status,
    this.message,
  });

  factory OtpVerificationModel.fromJson(Map<String, dynamic> json) {
    return OtpVerificationModel(
      status: json['status'],
      message: json['message']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}