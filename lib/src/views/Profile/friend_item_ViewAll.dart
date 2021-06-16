import 'package:dio/dio.dart';
import 'package:fakebook_flutter_app/src/helpers/shared_preferences.dart';
import 'package:fakebook_flutter_app/src/views/Profile/profile_page.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import './models/friends.dart';
import 'friend_profile_page.dart';

class FriendItemViewAll extends StatelessWidget {
  var friend_item_ViewAll;
  FriendItemViewAll({this.friend_item_ViewAll});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlatButton(
      onPressed: () async {
        print(this.friend_item_ViewAll["username"]);
        var uid = await StorageUtil.getUid();
        if (uid == this.friend_item_ViewAll["_id"]) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FriendProfile(
                      friendId: this.friend_item_ViewAll["_id"])));
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    // margin: EdgeInsets.only(left: 15.0),
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: this.friend_item_ViewAll["avatar"] != null
                              ? NetworkImage(this.friend_item_ViewAll["avatar"])
                              : AssetImage("assets/avatar.jpg")),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          this.friend_item_ViewAll["username"] ??
                              "Người dùng Fakebook",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3.0),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          friend_item_ViewAll["same_friends"]['same_friends']
                                  .toString() +
                              ' bạn chung',
                          textAlign: TextAlign.start,
                          style:
                              TextStyle(fontSize: 14.0, color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                height: 60.0,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.people_alt_rounded,
                                      size: 35.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Text(
                                          'Xem bạn bè của ${this.friend_item_ViewAll["username"]}',
                                          style: TextStyle(fontSize: 16.0)),
                                    )
                                  ],
                                ),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                height: 60.0,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.message_rounded,
                                      size: 35.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Text(
                                          'Nhắn tin cho ${this.friend_item_ViewAll["username"]}',
                                          style: TextStyle(fontSize: 16.0)),
                                    )
                                  ],
                                ),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                height: 60.0,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.person_search_rounded,
                                      size: 35.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Text(
                                          'Xem trang cá nhân của ${this.friend_item_ViewAll["username"]}',
                                          style: TextStyle(fontSize: 16.0)),
                                    )
                                  ],
                                ),
                                onPressed: () async {
                                  print(this.friend_item_ViewAll["username"]);
                                  var uid = await StorageUtil.getUid();
                                  if (uid == this.friend_item_ViewAll["_id"]) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfilePage()));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FriendProfile(
                                                friendId:
                                                    this.friend_item_ViewAll[
                                                        "_id"])));
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                height: 60.0,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.block_rounded,
                                      size: 35.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          child: Text(
                                              'Chặn ${this.friend_item_ViewAll["username"]}',
                                              style: TextStyle(fontSize: 16.0)),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          child: Text(
                                              '${this.friend_item_ViewAll["username"]} sẽ không thể nhìn thấy bạn hoặc liên hệ với bạn trên Facebook',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black54)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                onPressed: () async {
                                  var token = await StorageUtil.getToken();
                                  Response response;
                                  Dio dio = new Dio();
                                  response = await dio.post(
                                      "https://api-fakebook.herokuapp.com/it4788/set_block?token=$token&user_id=${this.friend_item_ViewAll["_id"]}&type=0");
                                  if (response.statusCode == 200 ||
                                      response.statusCode == 201) {
                                    var responseJson = response.data;
                                    if (responseJson["code"] == 1000) {
                                      Navigator.pop(context);
                                      Flushbar(
                                        message: "Đã thêm vào danh sách chặn",
                                        duration: Duration(seconds: 3),
                                      )..show(context);
                                    }
                                  } else {
                                    Flushbar(
                                      message: "Chặn không thành công",
                                      duration: Duration(seconds: 3),
                                    )..show(context);
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                height: 60.0,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.person_remove_rounded,
                                      size: 35.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          child: Text(
                                              'Huỷ kết bạn với ${this.friend_item_ViewAll["username"]}',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.red)),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          child: Text(
                                              'Xoá ${this.friend_item_ViewAll["username"]} khỏi danh sách bạn bè',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black54)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                onPressed: () async {
                                  var token = await StorageUtil.getToken();
                                  Response response;
                                  Dio dio = new Dio();
                                  response = await dio.post(
                                      "https://api-fakebook.herokuapp.com/it4788/unfriend?token=$token&user_id=${this.friend_item_ViewAll["_id"]}");
                                  if (response.statusCode == 200 ||
                                      response.statusCode == 201) {
                                    // var responseJson = json.decode(response.data);
                                    if (response.data["code"] == 1000) {
                                      // setState(() {
                                      //   isFriend = "Thêm bạn bè";
                                      // });
                                      Flushbar(
                                        message: "Đã huỷ kết bạn thành công",
                                        duration: Duration(seconds: 3),
                                      )..show(context);
                                    }
                                  } else {
                                    Flushbar(
                                      message: "Huỷ kết bạn không thành công",
                                      duration: Duration(seconds: 3),
                                    )..show(context);
                                  }
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  });
            },
            icon: Icon(Icons.more_horiz_rounded),
          )
        ],
      ),
    );
  }
}
