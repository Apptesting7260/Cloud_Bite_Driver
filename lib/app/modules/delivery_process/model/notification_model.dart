class NotificationItem {
  final String? id;
  final String? vendorId;
  final String? title;
  final String? body;
  final String? createdAt;
  final String? updatedAt;

  NotificationItem({
    required this.id,
    required this.vendorId,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id']?.toString(),
      vendorId: json['vendor_id']?.toString(),
      title: json['title']?.toString(),
      body: json['body']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }
}


class NotificationResponseModel {
  final bool? status;
  final String? message;
  final Map<String, List<NotificationItem>> data;
  final String? currentPage;
  final String? totalNotifications;
  final String? totalPages;

  NotificationResponseModel({
    required this.status,
    required this.message,
    required this.data,
    required this.currentPage,
    required this.totalNotifications,
    required this.totalPages,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'] as Map<String, dynamic>;
    final parsedData = rawData.map(
          (key, value) => MapEntry(
        key,
        List<NotificationItem>.from(
          value.map((item) => NotificationItem.fromJson(item)),
        ),
      ),
    );

    return NotificationResponseModel(
      status: json['status'],
      message: json['message']?.toString(),
      data: parsedData,
      currentPage: json['current_page']?.toString(),
      totalNotifications: json['total_notifications']?.toString(),
      totalPages: json['total_pages']?.toString(),
    );
  }
}
