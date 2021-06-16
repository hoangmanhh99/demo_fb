import 'package:fakebook_flutter_app/src/helpers/colors_constant.dart';
import 'package:fakebook_flutter_app/src/helpers/shared_preferences.dart';
import 'package:fakebook_flutter_app/src/models/post.dart';
import 'package:fakebook_flutter_app/src/views/HomePage/TabBarView/HomeTab/home_tab_controller.dart';
import 'package:fakebook_flutter_app/src/views/HomePage/TabBarView/HomeTab/post_widget_controller.dart';
import 'package:fakebook_flutter_app/src/widgets/loading_shimmer.dart';
import 'package:fakebook_flutter_app/src/widgets/post/post_widget.dart';
import 'package:fakebook_flutter_app/src/widgets/separator_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ProfilePost extends StatefulWidget {
  final userId;
  final List<PostModel> list;
  final bool isLoadingParent;

  const ProfilePost({Key key, this.userId, this.list, this.isLoadingParent})
      : super(key: key);
  @override
  _ProfilePostState createState() => _ProfilePostState();
}

class _ProfilePostState extends State<ProfilePost>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  String username;
  String avatar;
  String uid;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  List<PostModel> listPostModel = new List();
  bool isLoading = false;
  NewFeedController newFeedController = new NewFeedController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StorageUtil.getUsername().then((value) => setState(() {
          username = value;
        }));
    StorageUtil.getAvatar().then((value) => setState(() {
          avatar = value;
        }));
    StorageUtil.getUid().then((value) => setState(() {
          uid = value;
        }));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var uid = await StorageUtil.getUid();
      if (!mounted) return;
      setState(() => isLoading = true);
      await newFeedController.getMyPost(
          userId: widget.userId ?? uid,
          onSuccess: (values) {
            for (PostModel val in values)
              // if (val.video != null)
              setState(() {
                listPostModel.add(val);
              });
            setState(() {
              isLoading = false;
            });
          },
          onError: (msg) {
            setState(() => isLoading = false);
            print(msg);
          });
    });
  }

  Future<void> _refresh() async {
    var uid = await StorageUtil.getUid();
    refreshKey.currentState?.show(atTop: false);
    setState(() => isLoading = true);
    await newFeedController.getMyPost(
        onSuccess: (values) {
          print("hehe");
          for (PostModel val in values)
            // if (val.video != null)
            setState(() {
              listPostModel.add(val);
            });
          setState(() {
            isLoading = false;
          });
        },
        userId: uid,
        onError: (msg) {
          Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG);
          setState(() => isLoading = false);
          print(msg);
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildDemo() {
    return isLoading
        ? LoadingNewFeed()
        : ListView.builder(
            padding: EdgeInsets.only(top: 3),
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: listPostModel.length,
            itemBuilder: (context, index) {
              //postController[index] = new PostController();
              return PostWidget(
                post: listPostModel[index],
                controller: new PostController(),
                username: username,
              );
            });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        backgroundColor: Colors.grey[300],
        key: refreshKey,
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.userId == uid) buildPostReturn(),
              buildDemo(),
              //buildBody(), //warning: dont remove
              //buildTest()
            ],
          ),
        ));
  }

  Widget buildPostReturn() {
    print(widget.isLoadingParent);
    if (widget.list.isEmpty) {
      print(isLoading.toString() + "empty");
      if (widget.isLoadingParent) {
        if (widget.isLoadingParent == true)
          return Container(
            margin: EdgeInsets.only(top: 8),
            color: kColorWhite,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: kColorGrey,
                  radius: 20.0,
                  backgroundImage: avatar == null
                      ? AssetImage('assets/avatar.jpg')
                      : NetworkImage(avatar),
                ),
                SizedBox(width: 7.0),
                Text(username,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
                //SizedBox(height: 0.0),
                Expanded(child: SizedBox()),
                CircularProgressIndicator(),
              ],
            ),
          );
      } else {
        return SizedBox.shrink();
      }
    } else
      return Column(
        children: [
          if (widget.isLoadingParent == true)
            Container(
              margin: EdgeInsets.only(top: 8),
              color: kColorWhite,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: kColorGrey,
                    radius: 20.0,
                    backgroundImage: avatar == null
                        ? AssetImage('assets/avatar.jpg')
                        : NetworkImage(avatar),
                  ),
                  SizedBox(width: 7.0),
                  Text(username,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.0)),
                  //SizedBox(height: 0.0),
                  Expanded(child: SizedBox()),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          Column(
            children: [
              for (var i in widget.list)
                PostWidget(
                  username: username,
                  controller: new PostController(),
                  post: i,
                )
            ],
          ),
        ],
      );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
