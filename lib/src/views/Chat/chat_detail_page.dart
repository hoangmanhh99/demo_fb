import 'dart:convert';

import 'package:fakebook_flutter_app/src/constant/colors.dart';
import 'package:fakebook_flutter_app/src/helpers/fetch_data.dart';
import 'package:fakebook_flutter_app/src/helpers/internet_connection.dart';
import 'package:fakebook_flutter_app/src/helpers/parseDate.dart';
import 'package:fakebook_flutter_app/src/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:line_icons/line_icons.dart';
import 'home_page.dart';
// import 'package:flutter_chat_app/models/message_model.dart';
// import 'package:flutter_chat_app/models/user_model.dart';

class ChatScreen extends StatefulWidget {
  final bool isOnline = true;
  final String username;
  final String id;
  final String avatar;
  final String conversationId;
  final String partnerId;

  // final messages;
  // final

  ChatScreen(
      {this.username,
      this.id,
      this.avatar,
      this.conversationId,
      this.partnerId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with AutomaticKeepAliveClientMixin {
  SocketIO socketIO;
  TextEditingController textController;
  var messages = [];
  var myId;
  var myAvatar;
  var myUsername;
  var conversationId;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    socketIO = SocketIOManager().createSocketIO(
      'https://chat-fake-book.herokuapp.com',
      '/',
    );
    socketIO.init();

    //Subscribe to an event to listen to
    socketIO.subscribe('onmessage', (jsonData) {
      //Convert the JSON data received into a Map
      Map<String, dynamic> data = json.decode(jsonData);
      print(data);
      this.setState(() => messages.insert(0, {
            "message": data["message"],
            "sender": data["sender"],
            "created": ParseDate.parseMessage(data["created"])
          }));
      // scrollController.animateTo(
      //   scrollController.position.maxScrollExtent,
      //   duration: Duration(milliseconds: 600),
      //   curve: Curves.ease,
      // );
    });
    //Connect to the socket
    socketIO.connect();

    // super.initState();
    var ff = () async {
      String token = await StorageUtil.getToken();
      String myid = await StorageUtil.getUid();
      String username = await StorageUtil.getUsername();
      String avatar = await StorageUtil.getAvatar();
      if (await InternetConnection.isConnect()) {
        var res = await FetchData.getConversation(
            token, widget.conversationId, "0", "20", widget.partnerId);
        var data = await jsonDecode(res.body);
        // print(data);
        if (res.statusCode == 200) {
          setState(() {
            // friends = data["data"]["friends"];
            myId = myid;
            myUsername = username;
            myAvatar = avatar;
            conversationId =
                widget.conversationId ?? data["data"]["conversation_id"];
            messages = data["data"]["conversation"].reversed.toList();
            socketIO.sendMessage(
                "joinchat",
                json.encode({
                  '_id': myId,
                }));
            // print(id);
            // print(data["data"]["friends"]);
          });
        } else {
          print("Lỗi server");
        }
      }
    };
    ff();
  }

  _chatBubble(var message, bool isMe, bool isSameUser, int messageType) {
    print("isMe : $isMe");
    if (isMe) {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 1),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: getMessageType(
                    messageType, isMe), //BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                message["message"] != null ? message["message"] : "null",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          !isSameUser && message["sender"] != myId
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      ParseDate.parseMessage(message["created"]),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: widget.avatar != null
                            ? NetworkImage(widget.avatar)
                            : AssetImage('assets/avatar.jpg'),
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: getMessageType(messageType, isMe),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                message["message"] != null ? message["message"] : "null",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          !isSameUser // && message["sender"] != myId
              ? Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: widget.avatar != null
                            ? NetworkImage(widget.avatar)
                            : AssetImage('assets/avatar.jpg'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      message["created"] != null
                          ? ParseDate.parseMessage(message["created"])
                          : "created null",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    }
  }

  getMessageType(messageType, isMe) {
    if (messageType == 0) {
      return BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30));
    }

    if (isMe) {
      if (messageType == 0) {
        return BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30));
      } else
      // start message
      if (messageType == 1) {
        return BorderRadius.only(
            topRight: Radius.circular(6),
            bottomRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30));
      }
      // middle message
      else if (messageType == 2) {
        return BorderRadius.only(
            topRight: Radius.circular(6),
            bottomRight: Radius.circular(6),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30));
      }
      // end message
      else if (messageType == 3) {
        return BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(6),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30));
      }
      // standalone message
      else {
        return BorderRadius.all(Radius.circular(30));
      }
    }
    // for sender bubble
    else {
      // start message
      if (messageType == 1) {
        return BorderRadius.only(
            topLeft: Radius.circular(6),
            bottomLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30));
      }
      // middle message
      else if (messageType == 2) {
        return BorderRadius.only(
            topLeft: Radius.circular(6),
            bottomLeft: Radius.circular(6),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30));
      }
      // end message
      else if (messageType == 3) {
        return BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(6),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30));
      }
      // standalone message
      else {
        return BorderRadius.all(Radius.circular(30));
      }
    }
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
              textCapitalization: TextCapitalization.sentences,
              controller: textController,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              if (textController.text.isNotEmpty) {
                //Send the message as JSON data to send_message event
                print("widget id: ${widget.id}");
                print("id: ${myId}");
                socketIO.sendMessage(
                    'send',
                    json.encode({
                      'message': textController.text,
                      "conversation_id": conversationId,
                      'sender': myId,
                      'receiver': widget.id
                    }));
                //Add the message to the list
                this.setState(() => messages.insert(0, {
                      "message": textController.text,
                      "sender": myId,
                      "created": " ",
                    }));
                textController.text = '';
                //Scrolldown the list to show the latest message
                // scrollController.animateTo(
                //   scrollController.position.maxScrollExtent,
                //   duration: Duration(milliseconds: 600),
                //   curve: Curves.ease,
                // );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // String messages[index-1];
    // String messages[index+1];
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: grey.withOpacity(0.2),
        elevation: 0,
        leading: FlatButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatPage()));
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue, // setColor
            )),
        title: Row(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: widget.avatar != null
                      ? DecorationImage(
                          image: NetworkImage(widget.avatar), fit: BoxFit.cover)
                      : DecorationImage(
                          image: AssetImage('assets/avatar.jpg'))),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.username != null
                      ? widget.username
                      : "Người dùng Fakebook",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: black),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Đang hoạt động",
                  style: TextStyle(color: black.withOpacity(0.4), fontSize: 14),
                )
              ],
            )
          ],
        ),
        actions: <Widget>[
          Icon(
            LineIcons.phone,
            color: Colors.blue,
            size: 32,
          ),
          SizedBox(
            width: 15,
          ),
          Icon(
            LineIcons.video_camera,
            color: Colors.blue,
            size: 35,
          ),
          SizedBox(
            width: 8,
          ),
          true //online
              ? Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                      color: online,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white38)),
                )
              : Container(
                  width: 0,
                  height: 0,
                  decoration: BoxDecoration(
                      color: online,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white38)),
                ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(20),
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messages[index];
                // if (index < messages.length - 1) {
                //   messages[index + 1]["sender"] = messages[index + 1]["sender"]["sender"];
                // } else {
                //   messages[index + 1]["sender"] = null;
                // }

                // print("${message['sender']}+ " " + $myId");
                final bool isMe = message["sender"] == myId;
                final bool isSameUser = index != 0
                    ? messages[index - 1]["sender"] == message["sender"]
                    : false;
                int i = 0;
                // print("pr: ${messages[index-1]}  nex: ${messages[index+1]}");
                if (isMe) {
                  if (index != 0 && index < messages.length - 1) {
                    if (messages[index - 1]["sender"] != null) {
                      if (messages[index - 1]["sender"] != myId &&
                          messages[index + 1]["sender"] != myId) i = 0;
                      if (messages[index - 1]["sender"] != myId &&
                          messages[index + 1]["sender"] == myId) i = 1;
                      if (messages[index - 1]["sender"] == myId &&
                          messages[index + 1]["sender"] == myId) i = 2;
                      if (messages[index - 1]["sender"] == myId &&
                          messages[index + 1]["sender"] != myId) i = 3;
                    } else {
                      // if(messages[index+1]==)
                      if (messages[index + 1]["sender"] != myId) i = 0;
                      if (messages[index + 1]["sender"] == myId) i = 1;
                    }
                  } else if (index == 0) {
                    if (messages.length == 1) {
                      i = 0;
                    } else {
                      if (messages[index + 1]["sender"] == myId) i = 1;
                      if (messages[index + 1]["sender"] != myId) i = 0;
                    }
                  } else {
                    if (messages[index - 1]["sender"] == myId) i = 3;
                    if (messages[index - 1]["sender"] != myId) i = 0;
                  }
                } else {
                  if (index != 0 && index < messages.length - 1) {
                    if (messages[index - 1]["sender"] != null) {
                      if (messages[index - 1]["sender"] == myId &&
                          messages[index + 1]["sender"] == myId) i = 0;
                      if (messages[index - 1]["sender"] == myId &&
                          messages[index + 1]["sender"] != myId) i = 1;
                      if (messages[index - 1]["sender"] != myId &&
                          messages[index + 1]["sender"] != myId) i = 2;
                      if (messages[index - 1]["sender"] != myId &&
                          messages[index + 1]["sender"] == myId) i = 3;
                    } else {
                      if (messages[index + 1]["sender"] == myId) {
                        i = 0;
                      }
                      if (messages[index + 1]["sender"] != myId) {
                        i = 1;
                      }
                    }
                  } else if (index == 0) {
                    if (messages.length == 1) {
                      i = 0;
                    } else {
                      if (messages[index + 1]["sender"] == myId) {
                        i = 0;
                      }
                      if (messages[index + 1]["sender"] != myId) {
                        i = 1;
                      }
                    }
                  } else {
                    if (messages[index - 1]["sender"] == myId) {
                      i = 0;
                    }
                    if (messages[index - 1]["sender"] != myId) {
                      i = 3;
                    }
                  }
                }
                // messages[index - 1]["sender"]["sender"] = message["sender"];
                return _chatBubble(message, isMe, isSameUser, i);
              },
            ),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
