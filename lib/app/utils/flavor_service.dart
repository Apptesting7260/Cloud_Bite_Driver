import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class FlavorService extends GetxService {
  static const _flavor = String.fromEnvironment('FLAVOR');

  /// Load environment files inside service
  Future<FlavorService> init() async {
    await dotenv.load(fileName: ".env");
    debugPrint("FlavorService initialized with flavor: $_flavor");
    return this;
  }


  /// Base API URL
  String get baseUrl {
    debugPrint("Base URL for flavor: $_flavor");
    switch (_flavor) {
      case 'prod':
        return dotenv.env['PROD_API_URL'] ?? '';
      case 'staging':
        return dotenv.env['STAGING_API_URL'] ?? '';
      default:
        return dotenv.env['PROD_API_URL'] ?? '';
    }
  }

  /// Expose current flavor name publicly
  String get flavor => _flavor;
}
