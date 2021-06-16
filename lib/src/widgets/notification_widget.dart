import 'package:fakebook_flutter_app/src/helpers/parseDate.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../views/HomePage/TabBarView/HomeTab/post_widget_controller.dart';
import '../helpers/fetch_data.dart';
import '../helpers/internet_connection.dart';
import '../helpers/shared_preferences.dart';
import '../views/SinglePost/single_post_screen.dart';
import '../models/post.dart';
import '../views/Profile/friend_profile_page.dart';
// import 'package:fakebook_flutter_app/src/models/user_notification.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';

class NotificationWidget extends StatefulWidget {
  var notification;
  NotificationWidget({this.notification});
  @override
  NotificationState createState() => NotificationState();
}

class NotificationState extends State<NotificationWidget> {
  var notification;
  var isRead;
  @override
  void initState() {
    setState(() {
      notification = widget.notification;
      isRead = widget.notification["read"];
    });
    super.initState();
  }
  // NotificationWidget({this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100.0,
      color: isRead != "1" ? Colors.blue[50] : Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: notification["id"]["avatar"] != null
                ? NetworkImage(notification["id"]["avatar"])
                : AssetImage("assets/avatar.jpg"),
            radius: 35.0,
          ),
          SizedBox(width: 15.0),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isRead = "1";
                    });
                    String token = await StorageUtil.getToken();
                    FetchData.setReadNotification(
                        token, notification["id"]["_id"]);
                    if (await InternetConnection.isConnect()) {
                      if (notification["id"]["type"] == "get post") {
                        var res = await FetchData.getPost(
                            token, notification["id"]["object_id"]);
                        var data = await jsonDecode(res.body);
                        if (res.statusCode == 200) {
                          PostModel postModel =
                              PostModel.fromJson(data["data"]);
                          print(data);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SinglePost(postModel,
                                      new PostController(), "Bạn")));
                        } else {
                          print("lỗi server");
                        }
                      } else {
                        //   var res = await FetchData.getUserInfo(
                        //     token, notification["id"]["object_id"]);
                        // var data = await jsonDecode(res.body);
                        // if (res.statusCode == 200) {
                        // PostModel postModel = PostModel.fromJson(data["data"]);
                        // print(data);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FriendProfile(
                                      friendId: notification["id"]["object_id"],
                                    )));
                        // } else {
                        //   print("lỗi server");
                        // }
                      }
                    } else {
                      print("lỗi internet");
                    }
                  },
                  child: Text(
                    notification["id"]["title"] != null
                        ? notification["id"]["title"]
                        : "thông báo mặc định",
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                Text(
                    notification["id"]["created"] != null
                        ? ParseDate.parse(notification["id"]["created"])
                        : "thời gian mặc định",
                    style: TextStyle(fontSize: 15.0, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
