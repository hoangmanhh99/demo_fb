import 'package:fakebook_flutter_app/src/helpers/colors_constant.dart';
import 'package:fakebook_flutter_app/src/models/post.dart';
import 'package:fakebook_flutter_app/src/views/HomePage/TabBarView/HomeTab/post_widget_controller.dart';
import 'package:fakebook_flutter_app/src/views/HomePage/TabBarView/MenuTab/menu_tab.dart';
import 'package:fakebook_flutter_app/src/widgets/post/footer_post_wiget.dart';
import 'package:fakebook_flutter_app/src/widgets/post/header_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageView extends StatefulWidget {
  PostModel post;
  PostController controller;
  String username;

  ImageView(this.post, this.controller, this.username);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool isShowContent = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //title: widget.title,
        theme: ThemeData.dark().copyWith(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          platform: Theme.of(context).platform,
        ),
        home: SafeArea(
          maintainBottomViewPadding: true,
          top: true,
          minimum: EdgeInsets.only(top: 20),
          child: Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                //alignment: Alignment.bottomCenter,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isShowContent = !isShowContent;
                      });
                    },
                    child: Container(
                        child: PhotoViewGallery.builder(
                      builder: (BuildContext context, int index) {
                        return PhotoViewGalleryPageOptions(
                          imageProvider:
                              NetworkImage(widget.post.image[index].url),
                          minScale: PhotoViewComputedScale.contained*0.9,
                          maxScale: PhotoViewComputedScale.contained*2,
                          initialScale: PhotoViewComputedScale.contained*0.9,
                          heroAttributes: PhotoViewHeroAttributes(tag: index),
                        );
                      },
                      itemCount: widget.post.image.length,
                      loadingBuilder: (context, event) => Center(
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            value: event == null
                                ? 0
                                : event.cumulativeBytesLoaded /
                                    event.expectedTotalBytes,
                          ),
                        ),
                      ),
                      //backgroundDecoration: widget.backgroundDecoration,
                      // pageController: widget.pageController,
                      //onPageChanged: onPageChanged,
                    )),
                  ),
                  if (isShowContent)
                    Positioned.fill(
                      top: MediaQuery.of(context).size.height * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.bottomLeft,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(),
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(widget.post.author.username)),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(widget.post.described)),
                                ],
                              ),
                            ),
                          ),
                          FooterPost(
                              widget.post, widget.controller, widget.username),
                        ],
                      ),
                    ),
                  if (isShowContent)
                    Positioned.fill(
                        top: 20,
                        right: 10,
                        child: Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (_) {
                                      return SizedBox(
                                        height: 240,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 60,
                                              child: FlatButton(
                                                onPressed: () {},
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.save_alt),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                          "Lưu vào điện thoại"),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 60,
                                              child: FlatButton(
                                                onPressed: () {},
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.ac_unit_sharp),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                          "Chia sẻ ra bên ngoài"),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 60,
                                              child: FlatButton(
                                                onPressed: () {},
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.ac_unit_sharp),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                          "Gửi bằng Messenger"),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 60,
                                              child: FlatButton(
                                                onPressed: () {},
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .announcement_outlined,
                                                        color: kColorBlue,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Tìm hỗ trợ hoặc báo cáo ảnh",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Icon(Icons.more_vert),
                            )))
                ],
              ),
            ),
          ),
        ));
  }
}
