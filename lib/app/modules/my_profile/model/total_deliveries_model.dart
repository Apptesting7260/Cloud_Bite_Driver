class TotalDeliveriesModel {
  String? totalDeliveries;
  String? totalCharge;
  String? page;
  String? limit;
  String? currentPage;
  String? totalPages;
  List<Data>? data;

  TotalDeliveriesModel(
      {this.totalDeliveries,
        this.totalCharge,
        this.page,
        this.limit,
        this.currentPage,
        this.totalPages,
        this.data});

  TotalDeliveriesModel.fromJson(Map<String, dynamic> json) {
    totalDeliveries = json['totalDeliveries'].toString();
    totalCharge = json['totalCharge'].toString();
    page = json['page'].toString();
    limit = json['limit'].toString();
    currentPage = json['currentPage'].toString();
    totalPages = json['totalPages'].toString();
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalDeliveries'] = this.totalDeliveries;
    data['totalCharge'] = this.totalCharge;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? date;
  String? deliveries;
  String? totalCharge;

  Data({this.date, this.deliveries, this.totalCharge});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'].toString();
    deliveries = json['deliveries'].toString();
    totalCharge = json['total_charge'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['deliveries'] = this.deliveries;
    data['total_charge'] = this.totalCharge;
    return data;
  }
}
