  import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailService {
  final String apiUrl = 'http://localhost:3000/api/auth/send-mail';

  Future<void> sendMail(String email) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      print('Email sent successfully');
    } else {
      final Map<String, dynamic> errorData = json.decode(response.body);
      String errorMessage = 'Failed to send email. Please try again.';

      if (errorData.containsKey('message')) {
        errorMessage = errorData['message'];
      }

      return Future.error(errorMessage);
    }
  }

  Future<void> sendMailWithDelay(String email, int delayInSeconds) async {
    await Future.delayed(Duration(seconds: delayInSeconds));
    await sendMail(email);
  }
}
