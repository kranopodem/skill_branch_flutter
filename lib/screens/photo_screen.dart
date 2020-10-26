import 'package:FlutterGalleryApp/res/app_icons.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart' as widgets;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FullScreenImage extends StatefulWidget {
  FullScreenImage({Key key, this.name, this.userName, this.altDescription, this.photo})
      : super(key: key);

  final String name;
  final String userName;
  final String altDescription;
  final String photo;

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  get name => widget.name??"";
  get userName => widget.userName??"";
  get altDescription => widget.altDescription??"";
  get photo => widget.photo??"";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widgets.Photo(
            photoLink: photo,
          ),
          Text(
            altDescription,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.h3.copyWith(color: AppColors.manatee),
          ),
          Row(
            children: <Widget>[
              widgets.UserAvatar(
                  'https://sun9-37.userapi.com/knGRo-req5HNHJhc06U-ySPXKW1ouzceDVTwnQ/6yIVrjPc2rs.jpg'),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    name,
                    style: AppStyles.h1Black,
                  ),
                  Text(
                    "@"+userName,
                    style: AppStyles.h5Black.copyWith(
                      color: AppColors.manatee,
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('Save', () {
                print('test');
              }),
              SizedBox(
                width: 12,
              ),
              _buildButton('Visit', () {
                print('test');
              }),
            ],
          )
        ],
      ),
      appBar: AppBar(
        title: Text('Photo'),
        leading: IconButton(icon: Icon(CupertinoIcons.back), onPressed: null),
        centerTitle: true,
      ),
    );
  }

  Widget _buildButton(String text, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 105,
        height: 36,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: Color(0xFF39CEFD),
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }
}
