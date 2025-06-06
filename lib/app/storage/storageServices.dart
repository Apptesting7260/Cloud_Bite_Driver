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

  Future<bool> saveID(String token) async {
    return await _prefs.setString('ID', token);
  }

  Future<bool> saveEmail(String token) async {
    return await _prefs.setString('email', token);
  }

  Future<bool> saveMobile(String mobile) async {
    return await _prefs.setString('mobile', mobile);
  }


  // Get Methods
  String getID() {
    WidgetDesigns.consoleLog(_prefs.getString('ID').toString(), 'vendorId');
    return _prefs.getString('ID') ?? '';
  }

  String getEmail() {
    WidgetDesigns.consoleLog(_prefs.getString('email').toString(), 'vendorEmail');
    return _prefs.getString('email') ?? '';
  }

  String getMobile() {
    WidgetDesigns.consoleLog(_prefs.getString('mobile').toString(), 'vendorEmail');
    return _prefs.getString('mobile') ?? '';
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