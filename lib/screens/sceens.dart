import 'package:flutter/material.dart';
import 'package:news_app/model/news_article.dart';
import 'package:news_app/screens/history.dart';
import 'package:news_app/screens/login.dart';
import 'package:news_app/screens/news_detail_screen.dart';
import 'package:news_app/screens/settings.dart';
import 'package:news_app/service/news_service.dart';
import 'package:provider/provider.dart';
import 'package:news_app/Mode/mode.dart';

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen>
    with SingleTickerProviderStateMixin {
  final NewsService newsService = NewsService();
  late TabController _tabController;
  List<String> categories = [
    'general',
    'business',
    'technology',
    'sports',
    'health',
    'science'
  ];
  late Future<List<NewsArticle>> _futureArticles;
  String searchKeyword = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    _futureArticles = newsService.fetchArticles(category: categories[0]);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }// giúp đảm bảo rằng tất cả các tài nguyên được quản lý bởi _tabController sẽ được giải phóng khi widget bị hủy.

  void _selectCategory(String category) {
    setState(() {
      _futureArticles = newsService.fetchArticles(category: category);
    });
  }

  void _searchArticles(String query) {
    setState(() {
      searchKeyword = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Lấy theme hiện tại từ ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.blue, // Thay đổi màu sắc dựa vào theme
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: categories.map((category) {
            return Tab(
              text: category.toUpperCase(),
            );
          }).toList(),
          onTap: (index) {
            _selectCategory(categories[index]);
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode ? Colors.black : Colors.blue, // Thay đổi màu sắc dựa vào theme
              ),
              child: Text(
                'Hello Admin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
            ),
             ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Community'),
              onTap: () {
                // Handle about tap
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage())); // Close the drawer
                // Navigate to about screen or perform action
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Handle about tap
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage())); // Close the drawer
                // Navigate to about screen or perform action
              },
            ),

            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                // Handle about tap
                Navigator.pop(context); // Close the drawer
                // Navigate to about screen or perform action
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _searchArticles,
              decoration: InputDecoration(
                hintText: 'Search articles...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: categories.map((category) {
                return FutureBuilder(
                  future: newsService.fetchArticles(category: category),
                  builder: (context, AsyncSnapshot<List<NewsArticle>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No articles found'));
                    } else {
                      List<NewsArticle> articles = snapshot.data!;
                      // Lọc danh sách bài báo dựa trên từ khóa tìm kiếm
                      articles = articles.where((article) =>
                          article.title.toLowerCase().contains(searchKeyword.toLowerCase()) ||
                          article.description.toLowerCase().contains(searchKeyword.toLowerCase())).toList();
                      return ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            color: themeProvider.isDarkMode ? Colors.grey[900] : Colors.blueGrey[50], // Thay đổi màu sắc dựa vào theme
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetailScreen(article: articles[index]),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    articles[index].urlToImage != null
                                        ? Container(
                                            width: 100,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                              image: DecorationImage(
                                                image: NetworkImage(articles[index].urlToImage!),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: 100,
                                            height: 150,
                                            color: Colors.grey,
                                            child: Icon(Icons.image, size: 50),
                                          ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            articles[index].title,
                                            style: TextStyle(fontWeight: FontWeight.bold, color: themeProvider.isDarkMode ? Colors.white : Colors.black), // Thay đổi màu sắc dựa vào theme
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            articles[index].description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Colors.grey[700]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
