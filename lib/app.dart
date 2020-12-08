import 'dart:io';

import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/feed_screen.dart';
import 'package:FlutterGalleryApp/screens/home.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

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
        textTheme: buildAppTextTheme(),
      ),
      onGenerateRoute: (RouteSettings setting) {
        if (setting.name == '/fullScreenImage') {
          FullScreenImageArguments args =
              (setting.arguments as FullScreenImageArguments);
          final route = FullScreenImage(
            photo: args.photo,
            altDescription: args.altDescription,
            heroTag: args.heroTag,
            name: args.name,
            userName: args.userName,
            userPhoto: args.userPhoto,
            key: key,
          );

          if (Platform.isAndroid) {
            return MaterialPageRoute(builder: (context) => route);
          } else if (Platform.isIOS) {
            return CupertinoPageRoute(builder: (context) => route);
          }
        }
      },
      home: Home(Connectivity().onConnectivityChanged),
    );
  }
}
