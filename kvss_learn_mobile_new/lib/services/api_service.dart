import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://learning.kvsoftsolutions.com/api/v1'; // 🔁 adjust to your Laravel API

  // ---------------------------
  // LOGIN / REGISTER FUNCTIONS
  // ---------------------------
  static Future<Map<String, dynamic>> registerUser(String name, String email, String mobile, String password,String confirmPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'mobile':mobile,
        'password': password,
        "password_confirmation":confirmPassword
      }),
    );

    return jsonDecode(response.body);
  }


  // Fetch Profile
  static Future<Map<String, dynamic>> fetchProfile() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );

    return jsonDecode(response.body);
  }

// Update Profile
 static Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    final token = await getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    return jsonDecode(response.body);
  }


  // Get saved token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    return jsonDecode(response.body);
  }

  // ---------------------------
  // FETCH LESSONS (Protected)
  // ---------------------------


// Fetch lessons
  static Future<List<dynamic>> fetchLessons() async {
    final token = await getToken();
    if (token == null) throw Exception('Token not found');

    final response = await http.get(
      Uri.parse('$baseUrl/lessons'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      
      final decoded = jsonDecode(response.body);
      final lessons = decoded['data']?['data'] ?? [];
      return lessons;
    } else if (response.statusCode == 403) {
      throw Exception('Permission denied');
    } else {
      throw Exception('Failed to load lessons');
    }
  }


  static Future<bool> validateToken(String token) async {
  final response = await http.get(
    Uri.parse('$baseUrl/validate-token'),
    headers: {'Authorization': 'Bearer $token'},
  );
  return response.statusCode == 200;
}
}
