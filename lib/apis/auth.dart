import 'dart:convert';
import 'package:http/http.dart' as http;

class PingResponse {
  final String message;

  PingResponse({this.message});

  factory PingResponse.fromJson(Map<String, dynamic> json) {
    return PingResponse(
      message: json["message"],
    );
  }
}

Future<PingResponse> fetchPing() async {
  final response = await http.get('http://api.yjin.kim/ping');
  if (response.statusCode == 200) {
    return PingResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to ping to server');
  }
}

class LoginResponse {
  final String id;
  final String message;
  final String token;

  LoginResponse({this.id, this.message, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'],
      message: json['message'],
      token: json['token'],
    );
  }
}

Future<http.Response> postJSON(final String url, final Map<String, dynamic> body) {
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  final encBody = jsonEncode(body);
  return http.post(url, body: encBody, headers: headers);
}

Future<LoginResponse> fetchLogin(final String email, final String password) async {
  final response = await postJSON('http://api.yjin.kim/login', {
    'email': email,
    'password': password,
  });
  if (response.statusCode == 200) {
    return LoginResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to login');
  }
}
