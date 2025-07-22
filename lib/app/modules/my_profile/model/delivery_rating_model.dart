class DeliveryRatingModel {
  String? message;
  String? totalDeliveries;
  String? totalRatings;
  bool? status;

  DeliveryRatingModel(
      {this.message, this.totalDeliveries, this.totalRatings, this.status});

  DeliveryRatingModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    totalDeliveries = json['total_deliveries'].toString();
    totalRatings = json['total_ratings'].toString();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['total_deliveries'] = totalDeliveries;
    data['total_ratings'] = totalRatings;
    data['status'] = status;
    return data;
  }
}
