import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaginationScreen extends StatefulWidget {
  @override
  _PaginationScreenState createState() => _PaginationScreenState();
}

class _PaginationScreenState extends State<PaginationScreen> {
  ScrollController _scrollController = ScrollController();
  List<Post> dataList = [];
  int currentPage = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData(currentPage);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchData(currentPage + 1);
      }
    });
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchData(int page) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=10'));
      if (response.statusCode == 200) {
        List<Post> newData = (json.decode(response.body) as List)
            .map((data) => Post.fromJson(data))
            .toList();
        setState(() {
          dataList.addAll(newData);
          currentPage = page;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagination Example'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: dataList.length + 1,
        itemBuilder: (context, index) {
          if (index < dataList.length) {
            return ListTile(
              title: Text(dataList[index].title),
              subtitle: Text(dataList[index].body),
            );
          } else if (isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SizedBox();
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('Page $currentPage'),
        ),
      ),
    );
  }

}

class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}
