import 'package:cloud_bites_driver/app/core/app_exports.dart';

class StorageServices extends GetxService{
  late SharedPreferences _prefs;
  final _tokenKey = 'auth_token';

  // Set Methods
  Future<StorageServices> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> saveToken(String token) async {
    return await _prefs.setString(_tokenKey, token);
  }

  Future<bool> saveDeliveryID(String id) async {
    return await _prefs.setString('deliveryId', id);
  }

  Future<bool> saveOTP(String otp) async {
    return await _prefs.setString('OTP', otp);
  }

  Future<bool> saveEmailOTP(String otp) async {
    return await _prefs.setString('email_OTP', otp);
  }

  Future<bool> saveEmail(String token) async {
    return await _prefs.setString('email', token);
  }

  Future<bool> saveMobile(String mobile) async {
    return await _prefs.setString('mobile', mobile);
  }

  Future<bool> saveStages(String stage) async {
    return await _prefs.setString('stage', stage);
  }

  // Get Methods
  String getDeliveryID() {
    WidgetDesigns.consoleLog(_prefs.getString('deliveryId').toString(), 'deliveryId');
    return _prefs.getString('deliveryId') ?? '';
  }

  String getEmail() {
    WidgetDesigns.consoleLog(_prefs.getString('email').toString(), 'driverEmail');
    return _prefs.getString('email') ?? '';
  }

  String getOTP() {
    WidgetDesigns.consoleLog(_prefs.getString('OTP').toString(), 'driverOTP');
    return _prefs.getString('OTP') ?? '';
  }

  String getEmailOTP() {
    WidgetDesigns.consoleLog(_prefs.getString('email_OTP').toString(), 'driverOTP');
    return _prefs.getString('email_OTP') ?? '';
  }

  String getMobile() {
    WidgetDesigns.consoleLog(_prefs.getString('mobile').toString(), 'driverMobile');
    return _prefs.getString('mobile') ?? '';
  }

  String getStages() {
    WidgetDesigns.consoleLog(_prefs.getString('stage').toString(), 'stage');
    return _prefs.getString('stage') ?? '';
  }

  String getToken() {
    return _prefs.getString(_tokenKey) ?? '';
  }

  Future<bool> removeToken() async {
    return await _prefs.remove(_tokenKey);
  }

  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}