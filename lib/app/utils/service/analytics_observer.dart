import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'analytic_service.dart';

class AnalyticsObserver extends GetObserver {
  final AnalyticsService _analytics = AnalyticsService();

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);

    final screenName = route.settings.name;
    if (screenName != null) {
      _analytics.logScreen("$screenName-driver");
    }
  }
}
