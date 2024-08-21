// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:news_app/news_article.dart';

// class NewsService {
//   final String _endpoint = 'https://newsapi.org/v2/top-headlines';
//   final String _apiKey = '3b81cbbd1feb4436902f8373bcc93288'; // Thay YOUR_API_KEY bằng API key của bạn

//   Future<List<NewsArticle>> fetchArticles({String category = 'general'}) async {
//     final response = await http.get(Uri.parse('$_endpoint?country=us&category=$category&apiKey=$_apiKey'));

//     if (response.statusCode == 200) {
//       List<dynamic> body = json.decode(response.body)['articles'];
//       return body.map((dynamic item) => NewsArticle.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to load articles');
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_article.dart';


class NewsService {
  final String _endpoint = 'https://newsapi.org/v2/top-headlines';
  final String _apiKey = '3b81cbbd1feb4436902f8373bcc93288';

  Future<List<NewsArticle>> fetchArticles({String category = 'general'}) async {
    final url = Uri.parse('$_endpoint?country=us&category=$category&apiKey=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['articles'];
      return body.map((dynamic item) => NewsArticle.fromJson(item)).toList();
    } else {
      // // In ra response để debug
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');  
      throw Exception('Failed to load articles');
    }
  }
}
