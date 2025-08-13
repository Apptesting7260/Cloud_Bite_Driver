import 'dart:developer';
import 'dart:io';

import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:http/http.dart' as http;



class NetworkApiServices extends BaseApiServices {

  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  Future<dynamic> getApiWithoutToken(String url) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url),
          headers: {"Authorization": ""}).timeout(const Duration(seconds: 50));

      responseJson = returnResponse(response, url);
    } on SocketException {
      throw Exception("Internet Connection Issue..");
    } on RequestTimeOut {
      throw RequestTimeOut(
        onPress: () {},
      );
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  @override
  Future<dynamic> getApi(String url, String token) async {

    if (kDebugMode) {
      print("tocken@calling : ${token.toString()}");
      print("Get url@calling : ${url.toString()}");
      // print(url);
    }

    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": token,
      }).timeout(const Duration(seconds: 50));

      responseJson = returnResponse(response, url);
    } on SocketException {
      throw Exception("Internet Connection Issue..");
    } on RequestTimeOut {
      throw RequestTimeOut(
        onPress: () {},
      );
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApi(var data, String url, String token) async {

    dynamic responseJson;
    try {

      log("$token\n$url\n${data.toString()}", name: "token + url + data");
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": token,
        },
        body: data,
      ).timeout(const Duration(seconds: 50));

      responseJson = returnResponse(response, url);
      log("$responseJson", name: "data from api");
    } on SocketException {
      throw Exception("Internet Connection Issue..");
    } on RequestTimeOut {
      throw RequestTimeOut(
        onPress: () {},
      );
    } catch (e) {
      log("Error: $e", name: "Error in postApi");
    }

    return responseJson;
  }


  Future<dynamic> postApi2(var data, String url, String token) async {

    log("$token\n$url\n${data.toString()}", name: "token + url + data");

    dynamic responseJson;
    try {

      final response = await http.post(Uri.parse(url),
          headers: {"Authorization": "Bearer $token",'Content-Type': 'application/json',}, body: jsonEncode(data)).timeout(const Duration(seconds: 50));
      responseJson = returnResponse(response, url);
      if (kDebugMode) {
        print("data: $response");
      }
    } on SocketException {
      throw Exception("Internet Connection Issue..");
    } on RequestTimeOut {
      throw RequestTimeOut(
        onPress: () {},
      );
    }
    if (kDebugMode) {
      print("$responseJson");
    }
    return responseJson;
  }


  Future<dynamic> postApiMultiPart(String url, String token, Map<String, String> fields, Map<String, dynamic> files) async {

    dynamic responseJson;
    try {

      var headers = {
        'Authorization': token
      };

      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields.addAll(fields);

      log("Sending Request: ${request.fields}", name:  "multi part fields");
      log("Sending Request url + token: $token $url", name: "multi part fields");

      // Image files ko request me add karna
      // for (var entry in files.entries) {
      //   request.files.add(await http.MultipartFile.fromPath(entry.key, entry.value));
      // }
      for (var entry in files.entries) {
        final key = entry.key;
        final value = entry.value;

        if (value.runtimeType == String) {
          // Single file path
          request.files.add(await http.MultipartFile.fromPath(key, value));
          WidgetDesigns.consoleLog('eroor', value);
        } else if (value.runtimeType == List<String>) {
          // Multiple file paths
          for(int i=0;i<value.length;i++){
            request.files.add(await http.MultipartFile.fromPath(key, value[i]));
          }
        } else {
          WidgetDesigns.consoleLog(value.runtimeType.toString(), "type of file");
          throw Exception("Unsupported file input type for key '$key'");
        }
      }

      request.headers.addAll(headers);

      http.StreamedResponse streamResponse = await request.send();

      String responseString = await streamResponse.stream.bytesToString();

      responseJson = returnResponseMultiPart(streamResponse, responseString, url);
      log("$responseJson",name:  "data from api");

    } on SocketException {
      throw Exception("Internet Connection Issue..");
    } on RequestTimeOut {
      throw Exception("Request Time Out..");
    }

    return responseJson;
  }



  dynamic returnResponse(http.Response response, String url) {
    log("$url + ${response.statusCode}",name:  "From return response");

    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 403:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 503:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 500:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 405:
        dynamic responseJson = jsonDecode(response.body);
        storageServices.removeToken();
        Get.offNamed(Routes.welcome);
        return responseJson;
      case 501:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 422:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw Exception('Error occurred while communicating with server ${response.statusCode}');
    }
  }


  dynamic returnResponseMultiPart(http.StreamedResponse response, String responseBody, String url) {
    log("$url + ${response.statusCode}",name: "From return response");

    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(responseBody);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(responseBody);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(responseBody);
        return responseJson;
      case 401:
        dynamic responseJson = jsonDecode(responseBody);
        return responseJson;
      case 403:
        dynamic responseJson = jsonDecode(responseBody);
        return responseJson;
      case 404:
        dynamic responseJson = jsonDecode(responseBody);
        return responseJson;
      case 503:
        dynamic responseJson = jsonDecode(responseBody);
        return responseJson;
      case 500:
        dynamic responseJson = jsonDecode(responseBody);
        return responseJson;
      case 405:
        dynamic responseJson = jsonDecode(responseBody);
        return responseJson;
      case 501:
        dynamic responseJson = jsonDecode(responseBody);
        return responseJson;

      default:
        throw Exception('Error occurred while communicating with server ${response.statusCode}');
    }
  }
}
