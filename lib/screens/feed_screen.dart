import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/material.dart';

const String kFlutterDash =
    'https://miro.medium.com/max/4000/1*oXbK6TZiqMeXsGW5cRvQoQ.png';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedState();
  }
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              _buildItem(index),
              Divider(thickness: 2, color: AppColors.mercury)
            ],
          );
        },
        itemCount: 10,
      ),
    );
  }

  Widget _buildItem(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          child: Hero(
            tag: index.toString(),
            child: Photo(photoLink: kFlutterDash),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FullScreenImage(
                      tag: index.toString(),
                      name: '2',
                      userName: 'asdasd',
                      photo: kFlutterDash,
                      altDescription: 'This is Flutter dash. I love him :) ♥')),
            );
          },
        ),
        _buildPhotoMeta(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text('This is Flutter dash. I love him :) ♥',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.h3.copyWith(color: AppColors.manatee)),
        )
      ],
    );
  }

  Widget _buildPhotoMeta() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                UserAvatar(
                    'https://sun9-37.userapi.com/knGRo-req5HNHJhc06U-ySPXKW1ouzceDVTwnQ/6yIVrjPc2rs.jpg'),
                SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Алексей Комзарев',
                      style: AppStyles.h2Black,
                    ),
                    Text(
                      '@kranopodem',
                      style: AppStyles.h5Black.copyWith(
                        color: AppColors.manatee,
                      ),
                    ),
                  ],
                )
              ],
            ),
            LikeButton(10, true),
          ],
        ));
  }
}
