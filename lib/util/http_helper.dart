import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String _baseUrl = 'http://api.nytimes.com/svc/';

  Future<dynamic> get(String url) async {
    var responseJson;
    print("calling API");
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _handleResponse(response);
    } on SocketException {
      throw Exception("No Internet Connection");
    }
    return responseJson;
  }

  dynamic _handleResponse(http.Response response) {
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body.toString());
      default:
        throw Exception("Error with status code ${response.statusCode}");
    }
  }
}
