class WalletBalanceModel {
  bool? status;
  String? message;
  WalletData? data;

  WalletBalanceModel({this.status, this.data, this.message});

  WalletBalanceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']?.toString();
    data = json['data'] != null ? WalletData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class WalletData {
  String? wallet;

  WalletData({this.wallet});

  WalletData.fromJson(Map<String, dynamic> json) {
    wallet = json['wallet']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wallet'] = wallet;
    return data;
  }
}
