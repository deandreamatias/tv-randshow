import 'package:http/http.dart' as http;

class ApiProvider {
  Future<http.Response> requestPost(String url) async {
    http.Response response = await http.post(url);
    return response;
  }
  Future<http.Response> requestGet(String url) async {
    http.Response response = await http.get(url);
    return response;
  }
}