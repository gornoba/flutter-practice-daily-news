import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> lstNewsInfo = [];

  @override
  initState() {
    super.initState();

    getNewsInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff424242),
        title: const Text(
          'HeadLine News 🗞️',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (constext, index) {
          var newsData = lstNewsInfo[index];
          return GestureDetector(
            child: Container(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    height: 170,
                    width: double.infinity,
                    child: newsData['urlToImage'] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              newsData['urlToImage'],
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset('assets/no-picture-taking.png'),
                          ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    width: double.infinity,
                    height: 57,
                    decoration: ShapeDecoration(
                      color: Colors.black.withOpacity(0.7),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            newsData['title'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              formatDate(newsData['publishedAt']),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: newsData,
              );
            },
          );
        },
        itemCount: lstNewsInfo.length,
      ),
    );
  }

  String formatDate(String dateString) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(dateString));
  }

  Future getNewsInfo() async {
    const apiKey = '3c9279822e604dafb21caa3b46a1711b';
    const apiUrl =
        'https://newsapi.org/v2/top-headlines?country=kr&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          lstNewsInfo = responseData['articles'];
        });
      } else {
        throw Exception('Failed to load news');
      }
    } catch (error) {
      print(error);
    }
  }
}
