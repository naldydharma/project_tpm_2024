import 'package:http/http.dart' as http;
import 'dart:convert';

class BaseNetwork{
  static final String baseUrl = "https://www.mmobomb.com/api1/games?platform=pc";

  static Future<Map<String, dynamic>> get (String partUrl) async {
    final String fullUrl = baseUrl + "/" + partUrl;

    final http.Response response = await http.get(Uri.parse(fullUrl));

    _logDebug("response : ${response.body}");

    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> _processResponse(
      http.Response response) async {
    final body = response.body;
    if(body.isNotEmpty) {
      final jsonBody = json.decode(body);
      return jsonBody;
    }else {
      print ("processResponse error");
      return {"error": true};
    }
  }

  static void _logDebug(String value) {
    print("[BASE_NETWORK] - $value");
  }
}