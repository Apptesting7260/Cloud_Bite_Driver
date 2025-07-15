import 'package:collection/collection.dart';

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
    final status = json['status'] is bool
        ? json['status'] as bool
        : (json['status'] as int?) == 1;

    Map<String, List<NotificationItem>> parsedData = {};

    if (json['data'] != null) {
      if (json['data'] is List) {
        // Handle array response - group by date
        final items = (json['data'] as List)
            .map((item) => NotificationItem.fromJson(item))
            .toList();

        // Group notifications by date
        final grouped = groupBy(items, (item) => item.createdAt ?? 'No Date');
        parsedData = grouped.map((key, value) => MapEntry(key, value));
      } else if (json['data'] is Map<String, dynamic>) {
        // Handle map response (if you still want to support this format)
        final rawData = json['data'] as Map<String, dynamic>;
        parsedData = rawData.map(
              (key, value) => MapEntry(
            key,
            List<NotificationItem>.from(
              (value as List).map((item) => NotificationItem.fromJson(item)),
            ),
          ),
        );
      }
    }

    return NotificationResponseModel(
      status: status,
      message: json['message']?.toString(),
      data: parsedData,
      currentPage: json['current_page']?.toString(),
      totalNotifications: json['total_notifications']?.toString(),
      totalPages: json['total_pages']?.toString(),
    );
  }
}
