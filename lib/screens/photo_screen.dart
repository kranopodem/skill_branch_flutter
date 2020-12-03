import 'package:FlutterGalleryApp/res/app_icons.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart' as widgets;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage(
      {Key key,
      this.tag,
      this.name,
      this.userName,
      this.altDescription,
      this.photo})
      : super(key: key);

  final String name;
  final String userName;
  final String altDescription;
  final String photo;
  final String tag;

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage>
    with TickerProviderStateMixin {
  get name => widget.name ?? "";
  get userName => widget.userName ?? "";
  get altDescription => widget.altDescription ?? "";
  get photo => widget.photo ?? "";
  get tag => widget.tag ?? "";

  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _playAnimation();
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
          Text(
            altDescription,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.h3.copyWith(color: AppColors.manatee),
          ),
          StaggeredAnimation(
            animationController: _controller,
            name: widget.name,
            userName: widget.userName,
            userPhoto:
                'https://sun9-37.userapi.com/knGRo-req5HNHJhc06U-ySPXKW1ouzceDVTwnQ/6yIVrjPc2rs.jpg',
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
}

class StaggeredAnimation extends StatelessWidget {
  StaggeredAnimation(
      {Key key,
      this.animationController,
      this.name,
      this.userName,
      this.userPhoto})
      : opacityUserAvatar = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(0.0, 0.5, curve: Curves.ease),
          ),
        ),
        opacityText = Tween<double>(begin: 0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(0.5, 1.0, curve: Curves.ease),
          ),
        ),
        super(key: key);

  final Animation<double> opacityUserAvatar;
  final Animation<double> opacityText;
  final Animation<double> animationController;

  final String name;
  final String userName;
  final String userPhoto;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildPhotoMetaData,
      animation: animationController,
    );
  }

  Widget _buildPhotoMetaData(BuildContext context, Widget child) {
    // ghjdthrf pyfxtybq

    // double a, b, c, d;
    //   a = animationController.value;
    //   b = opacityUserAvatar.value;
    //   print('$a - OpacityUserAvatar $b');
    //  c = animationController.value;
    // d = opacityText.value;
    //print('$c - opacityText $d');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              FadeTransition(
                opacity: opacityUserAvatar,
                child: widgets.UserAvatar(userPhoto),
              ),
              SizedBox(width: 6),
              FadeTransition(
                opacity: opacityText,
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
