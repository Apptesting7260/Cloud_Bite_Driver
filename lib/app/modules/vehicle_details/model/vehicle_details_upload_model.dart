class VehicleDetailsUploadModel {
  String? type;
  String? message;
  VehicleDetailsData? data;
  bool? status;

  VehicleDetailsUploadModel({this.type, this.message, this.data, this.status});

  VehicleDetailsUploadModel.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    message = json['message'].toString();
    data = json['data'] != null ? VehicleDetailsData.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class VehicleDetailsData {
  String? id;
  String? driverId;
  String? vehicleName;
  String? brand;
  String? yearOfManufacture;
  String? registrationNumber;
  String? fuelType;
  String? rcFrontImage;
  String? rcBackImage;
  String? createdAt;

  VehicleDetailsData(
      {this.id,
        this.driverId,
        this.vehicleName,
        this.brand,
        this.yearOfManufacture,
        this.registrationNumber,
        this.fuelType,
        this.rcFrontImage,
        this.rcBackImage,
        this.createdAt});

  VehicleDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    driverId = json['driver_id'].toString();
    vehicleName = json['vehicle_name'].toString();
    brand = json['brand'].toString();
    yearOfManufacture = json['year_of_manufacture'].toString();
    registrationNumber = json['registration_number'].toString();
    fuelType = json['fuel_type'].toString();
    rcFrontImage = json['rc_front_image'].toString();
    rcBackImage = json['rc_back_image'].toString();
    createdAt = json['created_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['driver_id'] = driverId;
    data['vehicle_name'] = vehicleName;
    data['brand'] = brand;
    data['year_of_manufacture'] = yearOfManufacture;
    data['registration_number'] = registrationNumber;
    data['fuel_type'] = fuelType;
    data['rc_front_image'] = rcFrontImage;
    data['rc_back_image'] = rcBackImage;
    data['created_at'] = createdAt;
    return data;
  }
}
