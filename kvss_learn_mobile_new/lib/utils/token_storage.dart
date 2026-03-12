import 'package:shared_preferences/shared_preferences.dart';

<<<<<<< HEAD
Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

Future<void> removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token');
}
Future<void> clearToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token');
=======
class TokenStorage {

  static const _key = 'auth_token';

  static Future<void> save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, token);
  }

  static Future<String?> get() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

>>>>>>> 4eab97b (Remove large RPM file)
}