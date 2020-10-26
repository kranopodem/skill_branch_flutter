import 'package:FlutterGalleryApp/screens/feed_screen.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:flutter/material.dart';

const String kFlutterDash =
    'https://miro.medium.com/max/4000/1*oXbK6TZiqMeXsGW5cRvQoQ.png';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FullScreenImage(
        name: 'Алексей Комзарев',
        userName: '@kranopodem',
        altDescription:
            'Beautiful girl in a yellow dress with a flower on her head in the summer in the forest',
        photo: kFlutterDash,
      ),
    );
  }
}
