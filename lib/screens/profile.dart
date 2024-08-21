import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/screens/settings.dart';
import 'package:news_app/service/user_service.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newpasswordController = TextEditingController();

  bool isEditingEmail = false;
  bool isEditingName = false;
  bool isEditingPassword = false;
  bool isEditingNewPassword = false;

  final UserService _userService = UserService();

  void _navigateToSetting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Settings()), // Điều hướng đến màn hình Settings
    );
  }

  Future<void> updateProfile() async {
    final String email = emailController.text;
    final String name = nameController.text;
    final String password = passwordController.text;
    final String newPassword = newpasswordController.text;

    try {
      await _userService.updateUser(email, name, password, newPassword);
      Fluttertoast.showToast(
        msg: "Profile updated successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      _navigateToSetting(context);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error occurred: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                suffixIcon: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      isEditingEmail = !isEditingEmail;
                    });
                  },
                ),
              ),
              readOnly: !isEditingEmail,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      isEditingName = !isEditingName;
                    });
                  },
                ),
              ),
              readOnly: !isEditingName,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      isEditingPassword = !isEditingPassword;
                    });
                  },
                ),
              ),
              obscureText: true,
              readOnly: !isEditingPassword,
            ),
            TextField(
              controller: newpasswordController,
              decoration: InputDecoration(
                labelText: 'New Password',
                suffixIcon: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      isEditingNewPassword = !isEditingNewPassword;
                    });
                  },
                ),
              ),
              obscureText: true,
              readOnly: !isEditingNewPassword,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateProfile,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
