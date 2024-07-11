import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  final dynamic newsItem;

  const DetailScreen({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 150,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffffffff),
          elevation: 0,
          leading: TextButton(
            child: const Text(
              '뒤로가기',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          color: const Color(0xffffffff),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  height: 331,
                  width: double.infinity,
                  child: newsItem['urlToImage'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            newsItem['urlToImage'],
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
                    bottom: 5,
                    top: 16,
                  ),
                  child: Text(
                    newsItem['title'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(formatDate(newsItem['publishedAt'])),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(16),
                  child: Text(
                    newsItem['description'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Colors.grey.shade200,
                      ),
                    ),
                    child: const Text(
                      'Read More',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      _launchURL();
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }

  String formatDate(String dateString) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(dateString));
  }

  _launchURL() {
    launchUrl(Uri.parse(newsItem['url']));
  }
}
