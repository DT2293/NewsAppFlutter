import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/screens/sceens.dart';

class ReadArticle {
  final String title;
  final DateTime publishedAt;
  DateTime? readTime; 

  ReadArticle({required this.title, required this.publishedAt, this.readTime});
}

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<ReadArticle> readArticles = [];
  

  @override
  void initState() {
    super.initState();
    fetchReadArticles();
  }

  Future<void> fetchReadArticles() async {
    final String apiKey = 'YOUR_NEWSAPI_API_KEY'; // Thay YOUR_NEWSAPI_API_KEY bằng API key của bạn
    final String apiUrl = 'https://newsapi.org/v2/top-headlines'; // URL endpoint của News API

    final response = await http.get(
      Uri.parse('$apiUrl?q=bitcoin&apiKey=$apiKey'), // Ví dụ: Lấy tin tức về Bitcoin
    );

    if (response.statusCode == 200) {
      // Xử lý phản hồi thành công
      final jsonData = json.decode(response.body);
      List<ReadArticle> fetchedArticles = [];

      for (var article in jsonData['articles']) {
        fetchedArticles.add(
          ReadArticle(
            title: article['title'],
            publishedAt: DateTime.parse(article['publishedAt']),
          ),
        );
      }

      setState(() {
        readArticles = fetchedArticles;
      });
    } else {
      // Xử lý lỗi
      print('Failed to fetch articles: ${response.statusCode}');
    }
  }

  void recordReadTime(ReadArticle article) {
    setState(() {
      // Ghi nhận thời gian đọc là thời điểm hiện tại
      article.readTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Articles'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsListScreen())); // Quay lại màn hình trước đó (NewsListScreen)
          },
        ),
      ),
      
      body: ListView.builder(
        itemCount: readArticles.length,
        itemBuilder: (context, index) {
          final article = readArticles[index];
          return ListTile(
            title: Text(article.title),
            subtitle: Text(
              article.readTime != null
                  ? 'Read on: ${article.readTime}'
                  : 'Not read yet',
            ),
            onTap: () {
              recordReadTime(article); // Gọi hàm để ghi nhận thời gian đọc khi người dùng nhấn vào
            },
          );
        },
      ),
    );
  }
}
