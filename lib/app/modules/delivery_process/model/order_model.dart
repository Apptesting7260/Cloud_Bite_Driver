class OrderModel {
  final String? orderId;
  final String? vendorId;
  final String? orderNumber;
  final String? quantity;
  final String? totalAmount;
  final String? deliveryTime;
  final String? restaurantName;
  final String? vendorAddress;
  final String? vendorLatitude;
  final String? vendorLongitude;
  final String userAddress;
  final String userLatitude;
  final String userLongitude;
  final String pickupDistance;
  final String pickupDuration;
  final String deliveryDistance;
  final String deliveryDuration;

  OrderModel({
    required this.orderId,
    required this.vendorId,
    required this.orderNumber,
    required this.quantity,
    required this.totalAmount,
    required this.deliveryTime,
    required this.restaurantName,
    required this.vendorAddress,
    required this.vendorLatitude,
    required this.vendorLongitude,
    required this.userAddress,
    required this.userLatitude,
    required this.userLongitude,
    required this.pickupDistance,
    required this.pickupDuration,
    required this.deliveryDistance,
    required this.deliveryDuration,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'].toString(),
      vendorId: json['vendorId'].toString(),
      orderNumber: json['data']['order_id'].toString(),
      quantity: json['data']['quantity'].toString(),
      totalAmount: json['data']['total_amount'],
      deliveryTime: json['data']['delivery_time'].toString(),
      restaurantName: json['data']['restaurant_name'].toString(),
      vendorAddress: json['data']['vendor_address'].toString(),
      vendorLatitude: json['data']['vendor_latitude'],
      vendorLongitude: json['data']['vendor_longitude'],
      userAddress: json['data']['user_address'],
      userLatitude: json['data']['user_latitude'],
      userLongitude: json['data']['user_longitude'],
      pickupDistance: json['pickUpLocation']['distance'],
      pickupDuration: json['pickUpLocation']['duration'],
      deliveryDistance: json['deliveryLocation']['distance'],
      deliveryDuration: json['deliveryLocation']['duration'],
    );
  }
}