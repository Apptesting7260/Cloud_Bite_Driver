class TotalDeliveryModel {
  String? totalDeliveries;
  String? totalCharge;
  String? page;
  String? limit;
  String? currentPage;
  String? totalPages;
  List<TotalDeliveryData>? data;

  TotalDeliveryModel(
      {this.totalDeliveries,
        this.totalCharge,
        this.page,
        this.limit,
        this.currentPage,
        this.totalPages,
        this.data});

  TotalDeliveryModel.fromJson(Map<String, dynamic> json) {
    totalDeliveries = json['totalDeliveries']?.toString();
    totalCharge = json['totalCharge']?.toString();
    page = json['page']?.toString();
    limit = json['limit']?.toString();
    currentPage = json['currentPage']?.toString();
    totalPages = json['totalPages']?.toString();
    if (json['data'] != null) {
      data = <TotalDeliveryData>[];
      json['data'].forEach((v) {
        data!.add(TotalDeliveryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalDeliveries'] = totalDeliveries;
    data['totalCharge'] = totalCharge;
    data['page'] = page;
    data['limit'] = limit;
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TotalDeliveryData {
  String? date;
  String? deliveries;
  String? totalCharge;

  TotalDeliveryData({this.date, this.deliveries, this.totalCharge});

  TotalDeliveryData.fromJson(Map<String, dynamic> json) {
    date = json['date']?.toString();
    deliveries = json['deliveries']?.toString();
    totalCharge = json['total_charge']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['deliveries'] = deliveries;
    data['total_charge'] = totalCharge;
    return data;
  }
}
