import 'package:flutter/material.dart';
import 'package:news_app/Mode/mode.dart';
import 'package:news_app/screens/profile.dart';
import 'package:news_app/screens/sceens.dart';

import 'package:provider/provider.dart';


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void _navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfile()),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('English'),
                onTap: () {
                  // Handle language change to English
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Vietnamese'),
                onTap: () {
                  // Handle language change to Vietnamese
                  Navigator.of(context).pop();
                },
              ),
              // Add more languages as needed
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NewsListScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ACCOUNT SETTINGS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 2,
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  onTap: () {
                    _navigateToProfile(context);
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'PREFERENCES',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 2,
                child: ListTile(
                  leading: Icon(Icons.dark_mode),
                  title: Text('Dark Mode'),
                  onTap: () {
                    themeProvider.toggleTheme(); // Toggle theme
                  },
                ),
              ),
              Card(
                elevation: 2,
                child: ListTile(
                  leading: Icon(Icons.language),
                  title: Text('Language'),
                  onTap: () {
                    _showLanguageDialog(context);
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'ABOUT',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 2,
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About Us'),
                  onTap: () {
                    // Handle about us tap
                  },
                ),
              ),
              Card(
                elevation: 2,
                child: ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help & Feedback'),
                  onTap: () {
                    // Handle help & feedback tap
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
