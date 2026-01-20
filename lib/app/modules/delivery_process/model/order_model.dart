class OrderModel {
  final String orderId;
  final String remainingSec;
  final String expiryTime;
  final String vendorId;
  final String orderNumber;
  final String quantity;
  final String totalAmount;
  final String deliveryTime;
  final String deliveryCharge;
  final String restaurantName;
  final String vendorAddress;
  final double vendorLatitude;
  final double vendorLongitude;
  final String userAddress;
  final double userLatitude;
  final double userLongitude;
  final String pickupDistance;
  final String pickupDuration;
  final String deliveryDistance;
  final String deliveryDuration;
  // final double deliveryCharge;

  OrderModel({
    required this.orderId,
    required this.expiryTime,
    required this.remainingSec,
    required this.deliveryCharge,
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
    // required this.deliveryCharge,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      deliveryCharge: json['data']['delivery_charge'].toString(),
      orderId: json['orderId'].toString(),
      expiryTime: json['expiryTime'].toString(),
      remainingSec: json['remainingSec'].toString(),
      vendorId: json['vendorId'].toString(),
      orderNumber: json['data']['order_id']?.toString() ?? '',
      quantity: json['data']['quantity']?.toString() ?? '0',
      totalAmount: json['data']['total_amount']?.toString() ?? '0.00',
      deliveryTime: json['data']['delivery_time']?.toString() ?? '',
      restaurantName: json['data']['restaurant_name']?.toString() ?? '',
      vendorAddress: json['data']['vendor_address']?.toString() ?? '',
      vendorLatitude: _toDouble(json['data']['vendor_latitude']),
      vendorLongitude: _toDouble(json['data']['vendor_longitude']),
      userAddress: json['data']['user_address']?.toString() ?? '',
      userLatitude: _toDouble(json['data']['user_latitude']),
      userLongitude: _toDouble(json['data']['user_longitude']),
      pickupDistance: json['pickUpLocation']['distance']?.toString() ?? '',
      pickupDuration: json['pickUpLocation']['duration']?.toString() ?? '',
      deliveryDistance: json['deliveryLocation']['distance']?.toString() ?? '',
      deliveryDuration: json['deliveryLocation']['duration']?.toString() ?? '',
/*
      deliveryCharge: _toDouble(json['delivery_charge']['delivery_charge']),
*/
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}