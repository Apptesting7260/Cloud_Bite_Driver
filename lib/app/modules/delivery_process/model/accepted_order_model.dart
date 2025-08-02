class AcceptedOrderModel {
  bool? status;
  AcceptedData? data;
  AcceptedOrderModel({this.status, this.data});

  AcceptedOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? AcceptedData.fromJson(json['data']) : null;
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

class AcceptedData {
  OrderDetail? orderDetail;
  PickUpLocation? pickUpLocation;
  PickUpLocation? deliveryLocation;
  bool? pickUp;

  AcceptedData(
      {this.orderDetail,
        this.pickUpLocation,
        this.deliveryLocation,
        this.pickUp});

  AcceptedData.fromJson(Map<String, dynamic> json) {
    orderDetail = json['orderDetail'] != null
        ? OrderDetail.fromJson(json['orderDetail'])
        : null;
    pickUpLocation = json['pickUpLocation'] != null
        ? PickUpLocation.fromJson(json['pickUpLocation'])
        : null;
    deliveryLocation = json['deliveryLocation'] != null
        ? PickUpLocation.fromJson(json['deliveryLocation'])
        : null;
    pickUp = json['pickUp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderDetail != null) {
      data['orderDetail'] = orderDetail!.toJson();
    }
    if (pickUpLocation != null) {
      data['pickUpLocation'] = pickUpLocation!.toJson();
    }
    if (deliveryLocation != null) {
      data['deliveryLocation'] = deliveryLocation!.toJson();
    }
    data['pickUp'] = pickUp;
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
        ? Orderdata.fromJson(json['orderdata'])
        : null;
    userdata = json['userdata'] != null
        ? Userdata.fromJson(json['userdata'])
        : null;
    vendordata = json['vendordata'] != null
        ? Vendordata.fromJson(json['vendordata'])
        : null;
    userAddressData = json['user_address_data'] != null
        ? UserAddressData.fromJson(json['user_address_data'])
        : null;
    if (json['order_items_data'] != null) {
      orderItemsData = <OrderItemsData>[];
      json['order_items_data'].forEach((v) {
        orderItemsData!.add(OrderItemsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderdata != null) {
      data['orderdata'] = orderdata!.toJson();
    }
    if (userdata != null) {
      data['userdata'] = userdata!.toJson();
    }
    if (vendordata != null) {
      data['vendordata'] = vendordata!.toJson();
    }
    if (userAddressData != null) {
      data['user_address_data'] = userAddressData!.toJson();
    }
    if (orderItemsData != null) {
      data['order_items_data'] =
          orderItemsData!.map((v) => v.toJson()).toList();
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
    id = json['id']?.toString();
    orderId = json['order_id']?.toString();
    status = json['status']?.toString();
    isDriver = json['is_driver']?.toString();
    quantity = json['quantity']?.toString();
    totalAmount = json['total_amount']?.toString();
    deliveryTime = json['delivery_time']?.toString();
    deliveryCharge = json['delivery_charge']?.toString();
    paymentStatus = json['payment_status']?.toString();
    paymentMethod = json['payment_method']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['status'] = status;
    data['is_driver'] = isDriver;
    data['quantity'] = quantity;
    data['total_amount'] = totalAmount;
    data['delivery_time'] = deliveryTime;
    data['delivery_charge'] = deliveryCharge;
    data['payment_status'] = paymentStatus;
    data['payment_method'] = paymentMethod;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Userdata {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? image;
  String? fcmToken;

  Userdata(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.image,
        this.fcmToken});

  Userdata.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    firstName = json['first_name'].toString();
    lastName = json['last_name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    image = json['image'].toString();
    fcmToken = json['fcm_token'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['fcm_token'] = fcmToken;
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
    latitude = json['latitude'] != null ? double.tryParse(json['latitude'].toString()) : null;
    longitude = json['longitude'] != null ? double.tryParse(json['longitude'].toString()) : null;
    phone = json['phone'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['restaurant_name'] = restaurantName;
    data['restaurant_images'] = restaurantImages;
    data['fcm_token'] = fcmToken;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['phone'] = phone;
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
    latitude = json['latitude'] != null ? double.tryParse(json['latitude'].toString()) : null;
    longitude = json['longitude'] != null ? double.tryParse(json['longitude'].toString()) : null;
    type = json['type'].toString();
    houseNo = json['house_no'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['complete_address'] = completeAddress;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['type'] = type;
    data['house_no'] = houseNo;
    return data;
  }
}

class OrderItemsData {
  String? id;
  String? productId;
  String? productTitle;
  List<String>? productImages;
  String? quantity;
  List<Variant>? variant;
  List<AddOns>? addOns;
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
    if (json['variant'] != null) {
      variant = <Variant>[];
      json['variant'].forEach((v) {
        variant!.add(Variant.fromJson(v));
      });
    }
    if (json['add_ons'] != null) {
      addOns = <AddOns>[];
      json['add_ons'].forEach((v) {
        addOns!.add(AddOns.fromJson(v));
      });
    }
    price = json['price'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['product_title'] = productTitle;
    data['product_images'] = productImages;
    data['quantity'] = quantity;
    if (variant != null) {
      data['variant'] = variant!.map((v) => v.toJson()).toList();
    }
    if (addOns != null) {
      data['add_ons'] = addOns!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    return data;
  }
}

class Variant {
  String? price;
  String? datumName;
  String? variantId;
  String? variantTitle;

  Variant({this.price, this.datumName, this.variantId, this.variantTitle});

  Variant.fromJson(Map<String, dynamic> json) {
    price = json['price'].toString();
    datumName = json['datumName'].toString();
    variantId = json['variantId'].toString();
    variantTitle = json['variantTitle'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['datumName'] = datumName;
    data['variantId'] = variantId;
    data['variantTitle'] = variantTitle;
    return data;
  }
}

class AddOns {
  String? id;
  String? name;
  String? price;

  AddOns({this.id, this.name, this.price});

  AddOns.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    price = json['price'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['distance'] = distance;
    data['duration'] = duration;
    data['distance_value_meters'] = distanceValueMeters;
    data['duration_value_seconds'] = durationValueSeconds;
    data['duration_in_traffic'] = durationInTraffic;
    data['duration_in_traffic_value_seconds'] =
        durationInTrafficValueSeconds;
    return data;
  }
}
