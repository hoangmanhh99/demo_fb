import 'package:fakebook_flutter_app/src/helpers/colors_constant.dart';
import 'package:fakebook_flutter_app/src/helpers/screen.dart';
import 'package:fakebook_flutter_app/src/models/post.dart';
import 'package:fakebook_flutter_app/src/views/HomePage/TabBarView/HomeTab/home_tab_controller.dart';
import 'package:fakebook_flutter_app/src/views/HomePage/TabBarView/HomeTab/post_widget_controller.dart';
import 'package:fakebook_flutter_app/src/views/SinglePost/single_post_screen.dart';
import 'package:fakebook_flutter_app/src/widgets/post/image_view.dart';
import 'package:fakebook_flutter_app/src/widgets/post/video_view.dart';
import 'package:flutter/material.dart';

class AssetPost extends StatefulWidget {
  PostModel post;
  PostController controller;
  String username;

  AssetPost(this.post, this.controller, this.username);

  @override
  _AssetPostState createState() => _AssetPostState();
}

class _AssetPostState extends State<AssetPost> {
  @override
  void initState() {
    //widget.homeController.likeBehavior(widget.post.is_liked);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return assetView();
  }

  Widget assetView() {
    if (widget.post.video != null)
      return Padding(
        padding: EdgeInsets.all(ConstScreen.sizeDefault),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(widget.post.video.thumb),
            Icon(
              Icons.play_circle_filled_rounded,
              color: kColorWhite,
              size: 120,
            ),
          ],
        ),
      );
    if (widget.post.image.length != 0) {
      switch (widget.post.image.length) {
        case 1:
          return Padding(
            padding: EdgeInsets.all(0),
            child: Image.network(
              widget.post.image[0].url,
              fit: BoxFit.contain,
            ),
          );
        case 2:
          return GridView.count(
            padding: EdgeInsets.all(0),
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: List.generate(widget.post.image.length, (index) {
              String asset = widget.post.image[index].url;
              return Padding(
                  padding: EdgeInsets.all(0), child: Image.network(asset));
            }),
          );
        case 3:
          return Container(
            padding: EdgeInsets.all(ConstScreen.sizeDefault),
            child: Row(
              children: [
                Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width / 2.15,
                    child: Image.network(
                      widget.post.image[0].url,
                      fit: BoxFit.contain,
                    )),
                SizedBox(
                  width: 7,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.15,
                  child: Column(
                    children: [
                      Image.network(widget.post.image[1].url),
                      Image.network(widget.post.image[2].url),
                    ],
                  ),
                )
              ],
            ),
          );
        case 4:
          return GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            padding: EdgeInsets.all(0),
            children: List.generate(widget.post.image.length, (index) {
              String asset = widget.post.image[index].url;
              return Image.network(asset);
            }),
          );
      }
    }
    if (widget.post.image.length == 0 && widget.post.video == null)
      return SizedBox.shrink();
  }
}
