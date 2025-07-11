class RatingModel {
  String? message;
  bool? status;
  String? type;
  Summary? summary;
  List<RatingData>? data;
  String? totalPages;
  String? currentPage;

  RatingModel(
      {this.message,
        this.status,
        this.type,
        this.summary,
        this.data,
        this.totalPages,
        this.currentPage});

  RatingModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    status = json['status'];
    type = json['type'].toString();
    summary =
    json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
    if (json['data'] != null) {
      data = <RatingData>[];
      json['data'].forEach((v) {
        data!.add(new RatingData.fromJson(v));
      });
    }
    totalPages = json['total_pages'].toString();
    currentPage = json['current_page'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['type'] = this.type;
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['current_page'] = this.currentPage;
    return data;
  }
}

class Summary {
  String? averageRating;
  String? totalRatings;
  Distribution? distribution;

  Summary({this.averageRating, this.totalRatings, this.distribution});

  Summary.fromJson(Map<String, dynamic> json) {
    averageRating = json['average_rating'].toString();
    totalRatings = json['total_ratings'].toString();
    distribution = json['distribution'] != null
        ? new Distribution.fromJson(json['distribution'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['average_rating'] = this.averageRating;
    data['total_ratings'] = this.totalRatings;
    if (this.distribution != null) {
      data['distribution'] = this.distribution!.toJson();
    }
    return data;
  }
}

class Distribution {
  String? i5Star;
  String? i4Star;
  String? i3Star;
  String? i2Star;
  String? i1Star;

  Distribution(
      {this.i5Star, this.i4Star, this.i3Star, this.i2Star, this.i1Star});

  Distribution.fromJson(Map<String, dynamic> json) {
    i5Star = json['5_star'].toString();
    i4Star = json['4_star'].toString();
    i3Star = json['3_star'].toString();
    i2Star = json['2_star'].toString();
    i1Star = json['1_star'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['5_star'] = this.i5Star;
    data['4_star'] = this.i4Star;
    data['3_star'] = this.i3Star;
    data['2_star'] = this.i2Star;
    data['1_star'] = this.i1Star;
    return data;
  }
}

class RatingData {
  String? rating;
  String? driverReview;
  String? orderQuantity;
  String? userFirstName;
  String? userLastName;
  String? userImage;
  String? vendorImage;
  String? createdAt;
  String? orderId;

  RatingData(
      {this.rating,
        this.driverReview,
        this.orderQuantity,
        this.userFirstName,
        this.userLastName,
        this.userImage,
        this.vendorImage,
        this.createdAt,
        this.orderId});

  RatingData.fromJson(Map<String, dynamic> json) {
    rating = json['rating'].toString();
    driverReview = json['driver_review'].toString();
    orderQuantity = json['order_quantity'].toString();
    userFirstName = json['user_first_name'].toString();
    userLastName = json['user_last_name'].toString();
    userImage = json['user_image'].toString();
    vendorImage = json['vendor_image'].toString();
    createdAt = json['created_at'].toString();
    orderId = json['order_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['driver_review'] = this.driverReview;
    data['order_quantity'] = this.orderQuantity;
    data['user_first_name'] = this.userFirstName;
    data['user_last_name'] = this.userLastName;
    data['user_image'] = this.userImage;
    data['vendor_image'] = this.vendorImage;
    data['created_at'] = this.createdAt;
    data['order_id'] = this.orderId;
    return data;
  }
}
