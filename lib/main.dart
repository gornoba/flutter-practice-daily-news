import 'package:flutter/material.dart';
import 'package:flutter_practive_news/screen/detail_screen.dart';
import 'package:flutter_practive_news/screen/main_screen.dart';
import 'package:flutter_practive_news/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily News',
      debugShowCheckedModeBanner: false, // Remove Debug Banner,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/main': (context) => const MainScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final args = settings.arguments as dynamic;
          return MaterialPageRoute(
            builder: (context) => DetailScreen(newsItem: args),
          );
        }
        return null;
      },
    );
  }
}
