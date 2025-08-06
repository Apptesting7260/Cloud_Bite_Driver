class EarningChartModel {
  bool? status;
  String? message;
  EarningData? data;

  EarningChartModel({this.status, this.data});

  EarningChartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? EarningData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class EarningData {
  String? totalEarning;
  List<WeeklyEarningChart>? earning;
  String? order;
  String? earningAmount;

  EarningData(
      {this.totalEarning,
        this.earning,
        this.order,
        this.earningAmount});

  EarningData.fromJson(Map<String, dynamic> json) {
    totalEarning = json['totalEarning']?.toString();
    if (json['Earning'] != null) {
      earning = <WeeklyEarningChart>[];
      json['Earning'].forEach((v) {
        earning!.add(WeeklyEarningChart.fromJson(v));
      });
    }
    order = json['Order']?.toString();
    earningAmount = json['EarningAmount']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalEarning'] = totalEarning;
    if (earning != null) {
      data['Earning'] =
          earning!.map((v) => v.toJson()).toList();
    }
    data['Order'] = order;
    data['EarningAmount'] = earningAmount;
    return data;
  }
}

class WeeklyEarningChart {
  String? day;
  String? totalDeliveryCharge;

  WeeklyEarningChart({this.day, this.totalDeliveryCharge});

  WeeklyEarningChart.fromJson(Map<String, dynamic> json) {
    day = json['day']?.toString();
    totalDeliveryCharge = json['total_delivery_charge']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['total_delivery_charge'] = totalDeliveryCharge;
    return data;
  }
}
