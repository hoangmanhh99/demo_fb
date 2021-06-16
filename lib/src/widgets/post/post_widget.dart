import 'package:fakebook_flutter_app/src/helpers/colors_constant.dart';
import 'package:fakebook_flutter_app/src/helpers/epandaple_text.dart';
import 'package:fakebook_flutter_app/src/helpers/read_more_text.dart';
import 'package:fakebook_flutter_app/src/helpers/screen.dart';
import 'package:fakebook_flutter_app/src/models/post.dart';
import 'package:fakebook_flutter_app/src/views/HomePage/TabBarView/HomeTab/home_tab_controller.dart';
import 'package:fakebook_flutter_app/src/views/HomePage/TabBarView/HomeTab/post_widget_controller.dart';
import 'package:fakebook_flutter_app/src/views/SinglePost/single_post_screen.dart';
import 'package:fakebook_flutter_app/src/widgets/post/assets_post_wiget.dart';
import 'package:fakebook_flutter_app/src/widgets/post/comment_widget.dart';
import 'package:fakebook_flutter_app/src/widgets/post/footer_post_wiget.dart';
import 'package:fakebook_flutter_app/src/widgets/post/header_post_widget.dart';
import 'package:fakebook_flutter_app/src/widgets/post/image_view.dart';
import 'package:fakebook_flutter_app/src/widgets/post/video_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_flutter_app/src/models/post1.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class PostWidget extends StatefulWidget {
  final PostModel post;
  PostController controller;
  String username;

  PostWidget({this.post, this.controller, this.username});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  void initState() {
    widget.controller
        .init(widget.post.is_liked, widget.post.like, widget.post.comment);
    super.initState();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColorWhite,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.only(top: 10),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SinglePost(
                              widget.post,
                              widget.controller,
                              widget.username,
                            )));
              },
              child: HeaderPost(widget.post, widget.username)),
          //Text(post.content, style: TextStyle(fontSize: 15.0)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: ExpandableText(widget.post.described)),
          ),

/*
          ReadMoreText(
            post.content,
            trimLines: 2,
            colorClickableText: Colors.grey,
            trimMode: TrimMode.Line,
            trimCollapsedText: '...xem thêm',
            trimExpandedText: ' show less',
          ),

*/

          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SinglePost(
                            widget.post,
                            widget.controller,
                            widget.username,
                          )));
            },
            child: AssetPost(widget.post, widget.controller, widget.username),
          ),
          //AssetPost(widget.post, widget.controller, widget.username),

          FooterPost(widget.post, widget.controller, widget.username)
        ],
      ),
    );
  }
}
