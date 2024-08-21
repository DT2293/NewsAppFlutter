import 'package:flutter/material.dart';
import 'package:news_app/Mode/mode.dart';
import 'package:news_app/screens/login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(), // Initialize ThemeProvider
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'News App',
          theme: themeProvider.currentTheme(), // Access current theme from ThemeProvider
          home: LoginPage(), // Adjust based on your screen structure
          debugShowCheckedModeBanner: false,
        );
      },
    ); 
  }
}