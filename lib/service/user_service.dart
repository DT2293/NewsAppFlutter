import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/model/user.dart';

class UserService {
  final String loginApiUrl = 'http://localhost:3000/api/auth/login-user-handler';
  final String updateApiUrl = 'http://localhost:3000/api/auth/update-user-handle';

  Future<User?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(loginApiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      final Map<String, dynamic> errorData = json.decode(response.body);
      String errorMessage = 'Login failed. Please try again.';

      if (errorData.containsKey('message')) {
        errorMessage = errorData['message'];
      }

      return Future.error(errorMessage);
    }
  }

  Future<void> updateUser(String email, String name, String password, String newPassword) async {
    final response = await http.post(
      Uri.parse(updateApiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'name': name,
        'password': password,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode != 200) {
      final Map<String, dynamic> errorData = json.decode(response.body);
      String errorMessage = 'Update failed. Please try again.';

      if (errorData.containsKey('message')) {
        errorMessage = errorData['message'];
      }

      throw Exception(errorMessage);
    }
  }
}
