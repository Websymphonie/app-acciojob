import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';

class ApiRoutes {
  static String BASE_WEBSITE = "https://accio-job.com/";
  var log = Logger();

  Future<dynamic> get(String url) async {
    url = formated(url);
    var response = await http.get(Uri.parse(url));
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    url = formated(url);
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    return response;
  }

  String formated(String url) {
    return BASE_WEBSITE + url;
  }
}
