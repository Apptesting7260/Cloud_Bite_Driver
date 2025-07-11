
class AcceptedOrderModel {
  bool? status;
  AcceptedOrderData? data;

  AcceptedOrderModel({this.status, this.data});

  AcceptedOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new AcceptedOrderData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AcceptedOrderData {
  bool? pickUp;
  OrderDetail? orderDetail;
  PickUpLocation? pickUpLocation;
  PickUpLocation? deliveryLocation;

  AcceptedOrderData({this.orderDetail,this.pickUp, this.pickUpLocation, this.deliveryLocation});

  AcceptedOrderData.fromJson(Map<String, dynamic> json) {
    pickUp = json['pickUp'];
    orderDetail = json['orderDetail'] != null
        ? new OrderDetail.fromJson(json['orderDetail'])
        : null;
    pickUpLocation = json['pickUpLocation'] != null
        ? new PickUpLocation.fromJson(json['pickUpLocation'])
        : null;
    deliveryLocation = json['deliveryLocation'] != null
        ? new PickUpLocation.fromJson(json['deliveryLocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.pickUp != null){
      data['pickUp'] = this.pickUp;
    }
    if (this.orderDetail != null) {
      data['orderDetail'] = this.orderDetail!.toJson();
    }
    if (this.pickUpLocation != null) {
      data['pickUpLocation'] = this.pickUpLocation!.toJson();
    }
    if (this.deliveryLocation != null) {
      data['deliveryLocation'] = this.deliveryLocation!.toJson();
    }
    return data;
  }
}

class OrderDetail {
  Orderdata? orderdata;
  Userdata? userdata;
  Vendordata? vendordata;
  UserAddressData? userAddressData;
  List<OrderItemsData>? orderItemsData;

  OrderDetail(
      {this.orderdata,
        this.userdata,
        this.vendordata,
        this.userAddressData,
        this.orderItemsData});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    orderdata = json['orderdata'] != null
        ? new Orderdata.fromJson(json['orderdata'])
        : null;
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
    vendordata = json['vendordata'] != null
        ? new Vendordata.fromJson(json['vendordata'])
        : null;
    userAddressData = json['user_address_data'] != null
        ? new UserAddressData.fromJson(json['user_address_data'])
        : null;
    if (json['order_items_data'] != null) {
      orderItemsData = <OrderItemsData>[];
      json['order_items_data'].forEach((v) {
        orderItemsData!.add(new OrderItemsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderdata != null) {
      data['orderdata'] = this.orderdata!.toJson();
    }
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    if (this.vendordata != null) {
      data['vendordata'] = this.vendordata!.toJson();
    }
    if (this.userAddressData != null) {
      data['user_address_data'] = this.userAddressData!.toJson();
    }
    if (this.orderItemsData != null) {
      data['order_items_data'] =
          this.orderItemsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orderdata {
  String? id;
  String? orderId;
  String? status;
  String? isDriver;
  String? quantity;
  String? totalAmount;
  String? deliveryTime;
  String? deliveryCharge;
  String? paymentStatus;
  String? paymentMethod;
  String? createdAt;
  String? updatedAt;

  Orderdata(
      {this.id,
        this.orderId,
        this.status,
        this.isDriver,
        this.quantity,
        this.totalAmount,
        this.deliveryTime,
        this.deliveryCharge,
        this.paymentStatus,
        this.paymentMethod,
        this.createdAt,
        this.updatedAt});

  Orderdata.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    orderId = json['order_id'].toString();
    status = json['status'].toString();
    isDriver = json['is_driver'].toString();
    quantity = json['quantity'].toString();
    totalAmount = json['total_amount'].toString();
    deliveryTime = json['delivery_time'].toString();
    deliveryCharge = json['delivery_charge'].toString();
    paymentStatus = json['payment_status'];
    paymentMethod = json['payment_method'];
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['status'] = this.status;
    data['is_driver'] = this.isDriver;
    data['quantity'] = this.quantity;
    data['total_amount'] = this.totalAmount;
    data['delivery_time'] = this.deliveryTime;
    data['delivery_charge'] = this.deliveryCharge;
    data['payment_status'] = this.paymentStatus;
    data['payment_method'] = this.paymentMethod;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Userdata {
  String? id;
  String? firstName;
  String? lastName;
  String? image;
  String? email;
  String? phone;
  String? fcmToken;

  Userdata(
      {this.id,
        this.firstName,
        this.lastName,
        this.image,
        this.email,
        this.phone,
        this.fcmToken});

  Userdata.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    firstName = json['first_name'].toString();
    lastName = json['last_name'].toString();
    image = json['image'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    fcmToken = json['fcm_token'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['fcm_token'] = this.fcmToken;
    return data;
  }
}

class Vendordata {
  String? id;
  String? restaurantName;
  List<String>? restaurantImages;
  String? fcmToken;
  String? address;
  double? latitude;
  double? longitude;
  String? phone;

  Vendordata(
      {this.id,
        this.restaurantName,
        this.restaurantImages,
        this.fcmToken,
        this.address,
        this.latitude,
        this.longitude,
        this.phone});

  Vendordata.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    restaurantName = json['restaurant_name'].toString();
    restaurantImages = json['restaurant_images'].cast<String>();
    fcmToken = json['fcm_token'].toString();
    address = json['address'].toString();
    latitude = json['latitude'];
    longitude = json['longitude'];
    phone = json['phone'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_name'] = this.restaurantName;
    data['restaurant_images'] = this.restaurantImages;
    data['fcm_token'] = this.fcmToken;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['phone'] = this.phone;
    return data;
  }
}

class UserAddressData {
  String? id;
  String? completeAddress;
  double? latitude;
  double? longitude;
  String? type;
  String? houseNo;

  UserAddressData(
      {this.id,
        this.completeAddress,
        this.latitude,
        this.longitude,
        this.type,
        this.houseNo});

  UserAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    completeAddress = json['complete_address'].toString();
    latitude = json['latitude'];
    longitude = json['longitude'];
    type = json['type'].toString();
    houseNo = json['house_no'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['complete_address'] = this.completeAddress;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['type'] = this.type;
    data['house_no'] = this.houseNo;
    return data;
  }
}

class OrderItemsData {
  String? id;
  String? productId;
  String? productTitle;
  List<String>? productImages;
  String? quantity;
  String? variant;
  String? addOns;
  String? price;

  OrderItemsData(
      {this.id,
        this.productId,
        this.productTitle,
        this.productImages,
        this.quantity,
        this.variant,
        this.addOns,
        this.price});

  OrderItemsData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    productId = json['product_id'].toString();
    productTitle = json['product_title'].toString();
    productImages = json['product_images'].cast<String>();
    quantity = json['quantity'].toString();
    variant = json['variant'].toString();
    addOns = json['add_ons'].toString();
    price = json['price'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_title'] = this.productTitle;
    data['product_images'] = this.productImages;
    data['quantity'] = this.quantity;
    data['variant'] = this.variant;
    data['add_ons'] = this.addOns;
    data['price'] = this.price;
    return data;
  }
}

class PickUpLocation {
  String? distance;
  String? duration;
  String? distanceValueMeters;
  String? durationValueSeconds;
  String? durationInTraffic;
  String? durationInTrafficValueSeconds;

  PickUpLocation(
      {this.distance,
        this.duration,
        this.distanceValueMeters,
        this.durationValueSeconds,
        this.durationInTraffic,
        this.durationInTrafficValueSeconds});

  PickUpLocation.fromJson(Map<String, dynamic> json) {
    distance = json['distance'].toString();
    duration = json['duration'].toString();
    distanceValueMeters = json['distance_value_meters'].toString();
    durationValueSeconds = json['duration_value_seconds'].toString();
    durationInTraffic = json['duration_in_traffic'].toString();
    durationInTrafficValueSeconds = json['duration_in_traffic_value_seconds'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance;
    data['duration'] = this.duration;
    data['distance_value_meters'] = this.distanceValueMeters;
    data['duration_value_seconds'] = this.durationValueSeconds;
    data['duration_in_traffic'] = this.durationInTraffic;
    data['duration_in_traffic_value_seconds'] =
        this.durationInTrafficValueSeconds;
    return data;
  }
}
