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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['total_deliveries'] = this.totalDeliveries;
    data['total_ratings'] = this.totalRatings;
    data['status'] = this.status;
    return data;
  }
}
