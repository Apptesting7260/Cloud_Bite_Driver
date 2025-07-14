import 'package:get/get_rx/src/rx_types/rx_types.dart';

class FaqModel {
  bool? status;
  String? message;
  FaqData? data;

  FaqModel({this.status, this.message, this.data});

  FaqModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = json['data'] != null ? FaqData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class FaqData {
  RxList<CommonFaqData>? general;
  RxList<CommonFaqData>? account;
  RxList<CommonFaqData>? service;
  RxList<CommonFaqData>? payment;

  FaqData({this.general, this.account, this.service, this.payment});

  FaqData.fromJson(Map<String, dynamic> json) {
    if (json['general'] != null) {
      general = <CommonFaqData>[].obs;
      json['general'].forEach((v) {
        general!.add(CommonFaqData.fromJson(v));
      });
    }
    if (json['account'] != null) {
      account = <CommonFaqData>[].obs;
      json['account'].forEach((v) {
        account!.add(CommonFaqData.fromJson(v));
      });
    }
    if (json['service'] != null) {
      service = <CommonFaqData>[].obs;
      json['service'].forEach((v) {
        service!.add(CommonFaqData.fromJson(v));
      });
    }
    if (json['payment'] != null) {
      payment = <CommonFaqData>[].obs;
      json['payment'].forEach((v) {
        payment!.add(CommonFaqData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (general != null) {
      data['general'] = general!.map((v) => v.toJson()).toList();
    }
    if (account != null) {
      data['account'] = account!.map((v) => v.toJson()).toList();
    }
    if (service != null) {
      data['service'] = service!.map((v) => v.toJson()).toList();
    }
    if (payment != null) {
      data['payment'] = payment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommonFaqData {
  String? question;
  String? answer;

  CommonFaqData({this.question, this.answer});

  CommonFaqData.fromJson(Map<String, dynamic> json) {
    question = json['question']?.toString();
    answer = json['answer']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['answer'] = answer;
    return data;
  }
}

