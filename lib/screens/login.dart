// import 'package:flutter/material.dart';
// import 'package:news_app/screens/register.dart';
// import 'package:news_app/screens/sceens.dart';
// import 'package:news_app/service/user_service.dart';


// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final UserService _userService = UserService(); // Tạo đối tượng dịch vụ người dùng

//   void navigateToForgotPassword() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
//     );
//   }

//   void navigateToRegister() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => RegisterPage()),
//     );
//   }

//   Future<void> _login() async {
//     final String email = _emailController.text.trim();
//     final String password = _passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter both email and password')),
//       );
//       return;
//     }

//     try {
//       final user = await _userService.login(email, password);

//       if (user != null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => NewsListScreen()),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Login failed. Please check your credentials.')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An error occurred: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 'News App',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.blue[900],
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   hintText: 'Enter your email',
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   hintText: 'Enter your password',
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                 ),
//                 obscureText: true,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _login,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   foregroundColor: Colors.white,
//                   shadowColor: Colors.blueAccent,
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10), // Bo góc nút
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Khoảng cách giữa text và biên của nút
//                 ),
//                 child: Text('Login'),
//               ),
//               SizedBox(height: 10),
//               Center(
//                 child: InkWell(
//                   onTap: navigateToForgotPassword, // Gọi phương thức navigateToForgotPassword khi nhấn vào
//                   child: Text(
//                     'Forgot Password?',
//                     style: TextStyle(fontSize: 16, color: Colors.blue[900]),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 50),
//               Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'I do not have an account?',
//                       style: TextStyle(fontSize: 16, color: Colors.blue[900]),
//                     ),
//                     SizedBox(width: 5),
//                     InkWell(
//                       onTap: navigateToRegister, // Gọi phương thức navigateToRegister khi nhấn vào
//                       child: Text(
//                         'REGISTER',
//                         style: TextStyle(fontSize: 16, color: Colors.blue[900], fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ForgotPasswordPage extends StatelessWidget {
//   final TextEditingController _emailController = TextEditingController();

//   Future<void> _resetPassword() async {
//     final String email = _emailController.text.trim();

//     if (email.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter your email')),
//       );
//       return;
//     }

//     // Thực hiện logic khôi phục mật khẩu ở đây
//     try {
//       // Giả sử bạn có một phương thức trong UserService để xử lý khôi phục mật khẩu
//       await _userService.resetPassword(email);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Password reset link sent to your email')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An error occurred: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Forgot Password'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Forgot Password',
//                 style: TextStyle(fontSize: 24),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   hintText: 'Enter your email',
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _resetPassword,
//                 child: Text('Reset Password'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/screens/register.dart';
import 'package:news_app/screens/sceens.dart';// Import lớp UserService
import 'package:news_app/model/user.dart';
import 'package:news_app/service/sendmail.dart';
import 'package:news_app/service/user_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserService _userService = UserService();

  void navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
    );
  }

  void navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      User? user = await _userService.login(email, password);
      if (user != null) {
        // Đăng nhập thành công, điều hướng đến màn hình chính
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NewsListScreen()),
        );
      }
    } catch (error) {
      // Xử lý lỗi nếu đăng nhập thất bại
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'News App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController, // Gán controller cho TextField
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController, // Gán controller cho TextField
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login, // Gọi phương thức _login() khi nhấn nút
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.blueAccent,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bo góc nút
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Khoảng cách giữa text và biên của nút
                ),
                child: Text('Login'),
              ),
              SizedBox(height: 10),
              Center(
                child: InkWell(
                  onTap: navigateToForgotPassword, // Gọi phương thức navigateToForgotPassword khi nhấn vào
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 16, color: Colors.blue[900]),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'I do not have an account?',
                      style: TextStyle(fontSize: 16, color: Colors.blue[900]),
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: navigateToRegister, // Gọi phương thức navigateToRegister khi nhấn vào
                      child: Text(
                        'REGISTER',
                        style: TextStyle(fontSize: 16, color: Colors.blue[900], fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isResendVisible = false;
  final EmailService _emailService = EmailService();
  Timer? _resendTimer;

  void _sendEmailWithDelay() {
    final email = _emailController.text;

    _emailService.sendMailWithDelay(email, 60).then((_) {
      setState(() {
        _isResendVisible = true;
      });

      // Bắt đầu đếm thời gian 60 giây để tự động gửi lại email
      _startResendTimer();
    }).catchError((error) {
      print('Error: $error');
    });
  }

  void _startResendTimer() {
    _resendTimer?.cancel(); // Hủy timer nếu có trước đó
    _resendTimer = Timer(Duration(seconds: 60), () {
      _sendEmailWithDelay(); // Gửi lại email sau 60 giây
    });
  }

  @override
  void dispose() {
    _resendTimer?.cancel(); // Hủy timer khi thoát màn hình để tránh rò rỉ bộ nhớ
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Forgot Password',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendEmailWithDelay,
                child: Text('Reset Password'),
              ),
              if (_isResendVisible)
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _sendEmailWithDelay,
                  child: Text('Resend Email'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
