class TransactionHistoryModel {
  bool? status;
  List<TransactionData>? data;
  TransactionPagination? pagination;

  TransactionHistoryModel({this.status, this.data, this.pagination});

  TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TransactionData>[];
      json['data'].forEach((v) {
        data!.add(TransactionData.fromJson(v));
      });
    }
    pagination = json['pagenation'] != null
        ? TransactionPagination.fromJson(json['pagenation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagenation'] = pagination!.toJson();
    }
    return data;
  }
}

class TransactionData {
  String? id;
  String? driverId;
  String? totalWithdrawAmount;
  String? status;
  String? paymentPhoneNumber;
  String? rejectedReason;
  String? withdrawMethodId;
  String? withdrawMethodName;
  String? createdAt;
  String? updatedAt;

  TransactionData(
      {
        this.id,
        this.driverId,
        this.totalWithdrawAmount,
        this.status,
        this.paymentPhoneNumber,
        this.rejectedReason,
        this.withdrawMethodId,
        this.withdrawMethodName,
        this.createdAt,
        this.updatedAt,
      });

  TransactionData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    driverId = json['driver_id']?.toString();
    totalWithdrawAmount = json['total_withdraw_amount']?.toString();
    status = json['status']?.toString();
    paymentPhoneNumber = json['payment_phone_number']?.toString();
    rejectedReason = json['rejected_reason']?.toString();
    withdrawMethodId = json['withdraw_method_id']?.toString();
    withdrawMethodName = json['withdraw_method_name']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['driver_id'] = driverId;
    data['total_withdraw_amount'] = totalWithdrawAmount;
    data['status'] = status;
    data['payment_phone_number'] = paymentPhoneNumber;
    data['rejected_reason'] = rejectedReason;
    data['withdraw_method_id'] = withdrawMethodId;
    data['withdraw_method_name'] = withdrawMethodName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class TransactionPagination {
  String? totalCount;
  String? totalPages;
  String? currentPage;
  String? perPage;

  TransactionPagination(
      {this.totalCount, this.totalPages, this.currentPage, this.perPage});

  TransactionPagination.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount']?.toString();
    totalPages = json['totalPages']?.toString();
    currentPage = json['currentPage']?.toString();
    perPage = json['perPage']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    data['totalPages'] = totalPages;
    data['currentPage'] = currentPage;
    data['perPage'] = perPage;
    return data;
  }
}
