import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Globals{
  static const String apiUrl = "http://65.1.104.178";
  var storage = const FlutterSecureStorage();

  Future<Map<String, String>> createHeaders()async{
    String? token = await storage.read(key: "TOKEN");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };
    return headers;
  }
}