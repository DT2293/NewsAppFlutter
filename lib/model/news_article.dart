class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String? urlToImage; // Có thể là null
  final String content; 

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage, // Có thể là null
    required this.content,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'No title', // Giá trị mặc định nếu null
      description: json['description'] ?? 'No description', // Giá trị mặc định nếu null
      url: json['url'],
      urlToImage: json['urlToImage'], // Có thể là null
      content: json['content'] ?? 'No content available', // Giá trị mặc định nếu null
    );
  }
}
