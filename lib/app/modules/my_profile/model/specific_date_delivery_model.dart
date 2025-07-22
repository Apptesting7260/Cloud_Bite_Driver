class SpecificDateDeliveryModel {
  bool? success;
  String? total;
  String? page;
  String? totalPages;
  String? limit;
  List<SpecificDateDeliveryData>? data;

  SpecificDateDeliveryModel(
      {this.success,
        this.total,
        this.page,
        this.totalPages,
        this.limit,
        this.data});

  SpecificDateDeliveryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    total = json['total']?.toString();
    page = json['page']?.toString();
    totalPages = json['totalPages']?.toString();
    limit = json['limit']?.toString();
    if (json['data'] != null) {
      data = <SpecificDateDeliveryData>[];
      json['data'].forEach((v) {
        data!.add(SpecificDateDeliveryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['total'] = total;
    data['page'] = page;
    data['totalPages'] = totalPages;
    data['limit'] = limit;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SpecificDateDeliveryData {
  String? orderId;
  String? deliveryCharge;
  String? pickupFrom;
  String? deliveryTo;
  String? pickupTime;
  String? deliveryTime;

  SpecificDateDeliveryData({this.orderId, this.deliveryCharge, this.pickupFrom, this.deliveryTo});

  SpecificDateDeliveryData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id']?.toString();
    deliveryCharge = json['delivery_charge']?.toString();
    pickupFrom = json['pickup_from']?.toString();
    deliveryTo = json['delivery_to']?.toString();
    deliveryTime = json['delivery_time']?.toString();
    pickupTime = json['pickup_time']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['delivery_charge'] = deliveryCharge;
    data['pickup_from'] = pickupFrom;
    data['delivery_to'] = deliveryTo;
    data['delivery_time'] = deliveryTime;
    data['pickup_time'] = pickupTime;
    return data;
  }
}
