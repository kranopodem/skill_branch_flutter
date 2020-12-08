import 'package:FlutterGalleryApp/res/app_icons.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart' as widgets;
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class FullScreenImageArguments {
  FullScreenImageArguments({
    Key key,
    this.name,
    this.userName,
    this.altDescription,
    this.photo,
    this.userPhoto,
    this.heroTag,
  });

  final String name;
  final String userName;
  final String altDescription;
  final String photo;
  final String heroTag;
  final String userPhoto;
}

class FullScreenImage extends StatefulWidget {
  FullScreenImage({
    Key key,
    this.name,
    this.userName,
    this.altDescription,
    this.photo,
    this.userPhoto,
    this.heroTag,
  }) : super(key: key);

  final String name;
  final String userName;
  final String altDescription;
  final String photo;
  final String heroTag;
  final String userPhoto;

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage>
    with TickerProviderStateMixin {
  get name => widget.name ?? "";
  get userName => widget.userName ?? "";
  get altDescription => widget.altDescription ?? "";
  get photo => widget.photo ?? "";
  get tag => widget.heroTag ?? "";
  get userPhoto => widget.userPhoto ?? "";

  AnimationController _controller;
  Animation<double> opacityUserAvatar;
  Animation<double> opacityText;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    opacityUserAvatar = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.ease),
      ),
    );
    opacityText = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.ease),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: tag,
            child: widgets.Photo(
              photoLink: photo,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              altDescription,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.h3.copyWith(color: AppColors.manatee),
            ),
          ),
          _buildPhotoMeta(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: <Widget>[
                _buildButton('Save', () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Download photos'),
                        content:
                            Text('Are you sure you want to download a photo?'),
                        actions: [
                          FlatButton(
                            child: Text('Download'),
                            onPressed: () {
                              GallerySaver.saveImage(
                                  "https://mobikul.com/wp-content/uploads/2019/11/Simulator-Screen-Shot-iPhone-X%CA%80-2019-11-01-at-19.05.50-473x1024.png");
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text('Close'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }),
                SizedBox(
                  width: 12,
                ),
                _buildButton('Visit', () {
                  print('test');
                }),
              ],
            ),
          )
        ],
      ),
      appBar: AppBar(
        title: Text('Photo'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ClaimBottomSheet();
                  });
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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

  Widget _buildPhotoMeta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              AnimatedBuilder(
                animation: _controller,
                builder: (context, Widget child) {
                  return Opacity(
                      opacity: opacityUserAvatar.value, child: child);
                },
                child: widgets.UserAvatar(userPhoto),
              ),
              SizedBox(width: 6),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, Widget child) {
                  return Opacity(opacity: opacityText.value, child: child);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(name, style: AppStyles.h1Black),
                    Text('@$userName',
                        style: AppStyles.h5Black
                            .copyWith(color: AppColors.manatee)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
