import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:news_app/model/comments.dart';
import 'package:news_app/model/news_article.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsArticle article;
  NewsDetailScreen({required this.article});

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final FlutterTts flutterTts = FlutterTts();
  List<String> comments = []; // Danh sách lưu trữ bình luận

  Future<void> _speak() async {
    await flutterTts.speak(widget.article.content);
  }

 Future<void> _comment(BuildContext context) async {
  TextEditingController userNameController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('Comment on Article'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: userNameController,
              decoration: InputDecoration(hintText: "Enter your name"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: commentController,
              decoration: InputDecoration(hintText: "Enter your comment"),
              maxLines: 3,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
          ),
          TextButton(
            child: Text('Submit'),
            onPressed: () {
              String userName = userNameController.text;
              String comment = commentController.text;
              if (userName.isNotEmpty && comment.isNotEmpty) {
                setState(() {
                  comments.add(Comment(userName: userName, content: comment));
                });
              }
              Navigator.of(dialogContext).pop();
            },
          ),
        ],
      );
    },
  );
}


  // @override
  // Widget build(BuildContext context) {
  //   List<Widget> commentWidgets = []; // Danh sách widget để hiển thị bình luận

  //   // Chuyển đổi từng bình luận thành widget Text và thêm vào danh sách
  //   for (String comment in comments) {
  //     commentWidgets.add(
  //       Padding(
  //         padding: const EdgeInsets.only(bottom: 10.0),
  //         child: Text(comment),
  //       ),
  //     );
  //   }

  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(widget.article.title),
  //     ),
  //     body: SingleChildScrollView(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           if (widget.article.urlToImage != null)
  //             Image.network(widget.article.urlToImage!),
  //           SizedBox(height: 10),
  //           Text(
  //             widget.article.title,
  //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
  //           ),
  //           SizedBox(height: 10),
  //           Text(
  //             widget.article.description,
  //             style: TextStyle(fontSize: 16),
  //           ),
  //           SizedBox(height: 20),
  //           Text(
  //             widget.article.content,
  //             style: TextStyle(fontSize: 16),
  //           ),
  //           SizedBox(height: 20),
  //           Row(
  //             children: [
  //               ElevatedButton(
  //                 onPressed: _speak,
  //                 child: Text('Read full Article'),
  //               ),
  //               SizedBox(width: 20),
  //               ElevatedButton(
  //                 onPressed: () => _comment(context),
  //                 child: Row(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Icon(Icons.comment),
  //                     SizedBox(width: 8),
  //                     Text('Comment'),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //           SizedBox(height: 20),
  //           Row(
  //             children: [
  //               ElevatedButton(
  //                 onPressed: _speak, // Hành động chưa xác định, có thể là một hành động tải xuống
  //                 child: Row(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Icon(Icons.download),
  //                     SizedBox(width: 8),
  //                     Text('Download'),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(width: 20),
  //               ElevatedButton(
  //                 onPressed: _speak, // Hành động chưa xác định, có thể là một hành động nghe bài viết
  //                 child: Row(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Icon(Icons.list_outlined),
  //                     SizedBox(width: 8),
  //                     Text('Listen full Article'),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //           SizedBox(height: 20),
  //           if (comments.isNotEmpty) ...[
  //             Text(
  //               'Comments:',
  //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  //             ),
  //             SizedBox(height: 10),
  //             ...commentWidgets, // Nối danh sách các widget bình luận vào đây
  //           ],
  //         ],
  //       ),
  //     ),
  //   );
  // }
  @override
Widget build(BuildContext context) {
  List<Widget> commentWidgets = [];

  // Chuyển đổi từng bình luận thành widget Text và thêm vào danh sách
  for (Comment comment in comments) {
    commentWidgets.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.userName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(comment.content),
          ],
        ),
      ),
    );
  }

  return Scaffold(
    appBar: AppBar(
      title: Text(widget.article.title),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.article.urlToImage != null)
            Image.network(widget.article.urlToImage!),
          SizedBox(height: 10),
          Text(
            widget.article.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(height: 10),
          Text(
            widget.article.description,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            widget.article.content,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: _speak,
                child: Text('Read full Article'),
              ),
              Padding(padding: EdgeInsets.only(left: 20.0)),
              ElevatedButton(
                onPressed: () => _comment(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.comment),
                    SizedBox(width: 8),
                    Text('Comment'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          if (comments.isNotEmpty) ...[
            Text(
              'Comments:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            ...commentWidgets, // Nối danh sách các widget bình luận vào đây
          ],
        ],
      ),
    ),
  );
}

}

