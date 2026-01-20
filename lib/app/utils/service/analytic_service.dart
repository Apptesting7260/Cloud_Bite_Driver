import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  // Private constructor
  AnalyticsService._internal();

  static final AnalyticsService _instance = AnalyticsService._internal();

  factory AnalyticsService() => _instance;

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Log custom event (Realtime supported in DebugView)
  Future<void> logEvent({required String name, var parameters}) async {
    try {
      await _analytics.logEvent(name: name, parameters: parameters);

      if (kDebugMode) {
        debugPrint("📊 Analytics Event: $name → $parameters");
      }
    } catch (e) {
      debugPrint("❌ Analytics error: $e");
    }
  }

  /// Track screen views
  Future<void> logScreen(String screenName) async {
    try {
      await _analytics.logScreenView(screenName: screenName);

      if (kDebugMode) {
        debugPrint("📱 Screen Tracked: $screenName");
      }
    } catch (e) {
      debugPrint("❌ Screen tracking error: $e");
    }
  }

  /// Set user ID
  Future<void> setUserId(String userId) async {
    try {
      await _analytics.setUserId(id: userId);
    } catch (e) {
      debugPrint("❌ setUserId error: $e");
    }
  }

  Future<void> logAddToCart({required var data}) async {
    final Map<String, Object> params = _sanitizeMap(data);
print("add_to_cart");
print("cart data evnet---- $params");
    await _analytics.logEvent(name: 'add_to_cart', parameters: params);
  }

  Future<void> logCancelOrder({required var data}) async {
    final Map<String, Object> params = _sanitizeMap(data);
    await _analytics.logEvent(name: 'cancel_order', parameters:params);
  }

  Future<void> logLogin({required var data}) async {
    final Map<String, Object> params = _sanitizeMap(data);
    await _analytics.logEvent(name: 'login', parameters:params);
  }
  Future<void> logSocialLogin({required var data}) async {
    final Map<String, Object> params = _sanitizeMap(data);
    await _analytics.logEvent(name: 'social_login', parameters:params);
  }
  Future<void> logLogout({required var data}) async {
    final Map<String, Object> params = _sanitizeMap(data);
    await _analytics.logEvent(name: 'logout', parameters:params);
  }

  Future<void> logPlaceOrder({required var data}) async {
    final Map<String, Object> params = _sanitizeMap(data);

    await _analytics.logEvent(name: 'place_order', parameters: params);
  }

  Future<void> logPlacePreOrder({required var data}) async {
    final Map<String, Object> params = _sanitizeMap(data);

    await _analytics.logEvent(name: 'place_pre_order', parameters: params);
  }

  /// Set user property
  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
    } catch (e) {
      debugPrint("❌ setUserProperty error: $e");
    }
  }

  /// Clear user data on logout
  Future<void> reset() async {
    try {
      await _analytics.resetAnalyticsData();
    } catch (e) {
      debugPrint("❌ resetAnalyticsData error: $e");
    }
  }

  Map<String, Object> _sanitizeMap(Map input) {
    final Map<String, Object> output = {};

    input.forEach((key, value) {
      final String stringKey = key.toString();

      if (value == null) {
        // skip null values
        return;
      }

      if (value is num) {
        output[stringKey] = value;
      } else if (value is String) {
        output[stringKey] = value;
      } else if (value is bool) {
        // Convert bool → int (recommended)
        output[stringKey] = value ? 1 : 0;
      } else if (value is List) {
        // Store list length (BEST PRACTICE)
        output['${stringKey}_count'] = value.length;
      } else if (value is Map) {
        // Store map size
        output['${stringKey}_count'] = value.length;
      } else {
        // fallback → string
        output[stringKey] = value.toString();
      }
    });

    return output;
  }
}
