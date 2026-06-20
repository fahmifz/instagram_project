import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {

  static const String baseUrl =
    "http://10.147.131.110:8000/api/auth";

  static Future<Map<String, dynamic>> login({
  required String login,
  required String password,
}) async {

  print("LOGIN URL => ${baseUrl}/login");

  final response = await http.post(
    Uri.parse('$baseUrl/login'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'login': login,
      'password': password,
    }),
  );

  print("LOGIN STATUS => ${response.statusCode}");
  print("LOGIN BODY => ${response.body}");

  return jsonDecode(response.body);
}

  static Future<Map<String, dynamic>> register({
    required String fullname,
    required String username,
    required String login,
    required String password,
    required int birthDay,
    required int birthMonth,
    required int birthYear,
  }) async {

    print("URL => $baseUrl/register");

    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'fullname': fullname,
        'username': username,
        'login': login,
        'password': password,
        'birth_day': birthDay,
        'birth_month': birthMonth,
        'birth_year': birthYear,
      }),
    );

    print("STATUS => ${response.statusCode}");
    print("BODY => ${response.body}");

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> verifyOtp({
      required String login,
      required String otp,
    }) async {

    final response = await http.post(
      Uri.parse('$baseUrl/verify-otp'),

      headers: {
        'Content-Type': 'application/json',
      },

      body: jsonEncode({
        'login': login,
        'otp': otp,
      }),
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>?> getProfile(
  int userId,
) async {

  final response = await http.get(
    Uri.parse(
      "$baseUrl/profile/$userId",
    ),
  );

  print("PROFILE URL = $baseUrl/profile/$userId");
  print("PROFILE STATUS = ${response.statusCode}");
  print("PROFILE BODY = ${response.body}");

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }

  return null;
}

}