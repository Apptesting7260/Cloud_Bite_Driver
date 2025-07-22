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
    WidgetDesigns.consoleLog(token, 'auth_token');
    return await _prefs.setString(_tokenKey, token);
  }

  Future<bool> saveDriverID(String driverId) async {
    return await _prefs.setString('driverId', driverId);
  }

  Future<bool> saveID(String id) async {
    return await _prefs.setString('id', id);
  }

  Future<bool> saveDeliveryID(String id) async {
    return await _prefs.setString('id', id);
  }

  Future<bool> saveOTP(String otp) async {
    return await _prefs.setString('OTP', otp);
  }

  Future<bool> saveEmailOTP(String otp) async {
    return await _prefs.setString('email_OTP', otp);
  }

  Future<bool> saveEmail(String email) async {
    return await _prefs.setString('email', email);
  }

  Future<bool> saveEmailVerified(bool isVerified) async {
    return await _prefs.setBool('emailVerified', isVerified);
  }

  Future<bool> saveMobile(String mobile) async {
    return await _prefs.setString('mobile', mobile);
  }

  Future<bool> saveStages(String stage) async {
    return await _prefs.setString('stage', stage);
  }

  Future<bool> saveDeliveryType(String vehicleType) async {
    return await _prefs.setString('vehicleType', vehicleType);
  }

  Future<bool> saveFirstName(String firstName) async {
    return await _prefs.setString('firstName', firstName);
  }

  Future<bool> saveLastName(String lastName) async {
    return await _prefs.setString('lastName', lastName);
  }

  Future<bool> saveDOB(String dateOfBirth) async {
    return await _prefs.setString('dateOfBirth', dateOfBirth);
  }


  Future<bool> saveProfile(String profile) async {
    return await _prefs.setString('profile', profile);
  }

  Future<bool> saveAddress(String address) async {
    return await _prefs.setString('address', address);
  }


  // Get Methods
  String getDeliveryID() {
    WidgetDesigns.consoleLog(_prefs.getString('id').toString(), 'id');
    return _prefs.getString('id') ?? '';
  }

  String getDeliveryType() {
    WidgetDesigns.consoleLog(_prefs.getString('vehicleType').toString(), 'vehicleType');
    return _prefs.getString('vehicleType') ?? '';
  }

  String getDriverID() {
    WidgetDesigns.consoleLog(_prefs.getString('driverId').toString(), 'driverId');
    return _prefs.getString('driverId') ?? '';
  }

  String getID() {
    WidgetDesigns.consoleLog(_prefs.getString('id').toString(), 'id');
    return _prefs.getString('id') ?? '';
  }

  String getEmail() {
    WidgetDesigns.consoleLog(_prefs.getString('email').toString(), 'driverEmail');
    return _prefs.getString('email') ?? '';
  }

  bool getEmailVerified() {
    WidgetDesigns.consoleLog(_prefs.getBool('emailVerified').toString(), 'emailVerified');
    return _prefs.getBool('emailVerified') ?? false;
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
    WidgetDesigns.consoleLog(_prefs.getString('mobile').toString(), 'mobile');
    return _prefs.getString('mobile') ?? '';
  }

  String getFirstName() {
    WidgetDesigns.consoleLog(_prefs.getString('firstName').toString(), 'firstName');
    return _prefs.getString('firstName') ?? '';
  }

  String getLastName() {
    WidgetDesigns.consoleLog(_prefs.getString('lastName').toString(), 'lastName');
    return _prefs.getString('lastName') ?? '';
  }


  String getDOB() {
    WidgetDesigns.consoleLog(_prefs.getString('dateOfBirth').toString(), 'dateOfBirth');
    return _prefs.getString('dateOfBirth') ?? '';
  }

  String getProfile() {
    WidgetDesigns.consoleLog(_prefs.getString('profile').toString(), 'profile');
    return _prefs.getString('profile') ?? '';
  }

  String getAddress() {
    WidgetDesigns.consoleLog(_prefs.getString('address').toString(), 'address');
    return _prefs.getString('address') ?? '';
  }

  String getStages() {
    WidgetDesigns.consoleLog(_prefs.getString('stage').toString(), 'stage');
    return _prefs.getString('stage') ?? '';
  }

  String getToken() {
    return _prefs.getString(_tokenKey) ?? '';
  }

  returnFCMToken()  {
    return  PushNotificationService.fcmToken;
  }

  Future<bool> removeToken() async {
    return await _prefs.remove(_tokenKey);
  }

  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}