import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String apiUrl = 'http://localhost:3000/api/auth/update-user-handle';

  Future<void> updateUser({
    required String email,
    required String name,
    required String password,
    required String newPassword,
  }) async {
    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'name': name,
        'password': password,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      // Xử lý khi cập nhật thành công
      print('User updated successfully');
    } else {
      // Xử lý lỗi nếu có
      final Map<String, dynamic> errorData = json.decode(response.body);
      String errorMessage = 'User update failed. Please try again.';

      if (errorData.containsKey('message')) {
        errorMessage = errorData['message'];
      }

      throw Exception(errorMessage); // Trả về lỗi để xử lý ở lớp giao diện
    }
  }

  // Các phương thức khác của UserService
}
