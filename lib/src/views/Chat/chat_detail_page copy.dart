// import 'dart:convert';

// import 'package:fakebook_flutter_app/src/constant/data.dart';
// import 'package:fakebook_flutter_app/src/constant/colors.dart';
// import 'package:fakebook_flutter_app/src/helpers/fetch_data.dart';
// import 'package:fakebook_flutter_app/src/helpers/internet_connection.dart';
// import 'package:fakebook_flutter_app/src/helpers/shared_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:flutter_socket_io/flutter_socket_io.dart';

// class ChatDetailPage extends StatefulWidget {
//   final String id;
//   final String avatar;
//   final String username;
//   final String conversationId;
//   ChatDetailPage({
//     Key key,
//     this.id,
//     this.conversationId,
//     this.avatar,
//     this.username,
//   }) : super(key: key);
//   @override
//   _ChatDetailPageState createState() => _ChatDetailPageState();
// }

// class _ChatDetailPageState extends State<ChatDetailPage>
//     with AutomaticKeepAliveClientMixin {
//   var messages = [];

//   TextEditingController _sendMessageController = new TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     var ff = () async {
//       String token = await StorageUtil.getToken();
//       if (await InternetConnection.isConnect()) {
//         var res = await FetchData.getConversation(
//             token, widget.conversationId, "0", "20", widget);
//         var data = await jsonDecode(res.body);
//         print(data);
//         if (res.statusCode == 200) {
//           setState(() {
//             // friends = data["data"]["friends"];
//             messages = data["data"]["conversation"];
//             print(messages);
//             // print(data["data"]["friends"]);
//           });
//         } else {
//           print("Lỗi server");
//         }
//       }
//     };
//     ff();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: grey.withOpacity(0.2),
//         elevation: 0,
//         leading: FlatButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Icon(
//               Icons.arrow_back_ios,
//               color: Colors.blue, // setColor
//             )),
//         title: Row(
//           children: <Widget>[
//             Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                       image: NetworkImage(widget.avatar != null
//                           ? widget.avatar
//                           : AssetImage('assets/avatar.jpg')),
//                       fit: BoxFit.cover)),
//             ),
//             SizedBox(
//               width: 15,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   widget.username != null
//                       ? widget.username
//                       : "Người dùng Fakebook",
//                   style: TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold, color: black),
//                 ),
//                 SizedBox(
//                   height: 3,
//                 ),
//                 Text(
//                   "Đang hoạt động",
//                   style: TextStyle(color: black.withOpacity(0.4), fontSize: 14),
//                 )
//               ],
//             )
//           ],
//         ),
//         actions: <Widget>[
//           Icon(
//             LineIcons.phone,
//             color: Colors.blue,
//             size: 32,
//           ),
//           SizedBox(
//             width: 15,
//           ),
//           Icon(
//             LineIcons.video_camera,
//             color: Colors.blue,
//             size: 35,
//           ),
//           SizedBox(
//             width: 8,
//           ),
//           true //online
//               ? Container(
//                   width: 13,
//                   height: 13,
//                   decoration: BoxDecoration(
//                       color: online,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.white38)),
//                 )
//               : Container(
//                   width: 0,
//                   height: 0,
//                   decoration: BoxDecoration(
//                       color: online,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.white38)),
//                 ),
//           SizedBox(
//             width: 15,
//           ),
//         ],
//       ),
//       body: Text("j\n\n\n\n\n\n\n\n\n\n\n\nj"),
//       bottomSheet: TextField(
//         decoration: InputDecoration.collapsed(
//           hintText: 'Send a message...',
//         ),
//       ),
//     );
//     // );
//   }

//   Widget getBottom() {
//     return Container(
//       padding:
//           EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//       height: 60,
//       width: double.infinity,
//       decoration: BoxDecoration(color: grey.withOpacity(0.2)),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Container(
//               width: (MediaQuery.of(context).size.width - 40) / 2,
//               child: Row(
//                 children: <Widget>[
//                   Icon(
//                     Icons.add_circle,
//                     size: 35,
//                     color: Colors.blue,
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Icon(
//                     Icons.camera_alt,
//                     size: 35,
//                     color: Colors.blue,
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Icon(
//                     Icons.photo,
//                     size: 35,
//                     color: Colors.blue,
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Icon(
//                     Icons.keyboard_voice,
//                     size: 35,
//                     color: Colors.blue,
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               width: (MediaQuery.of(context).size.width - 40) / 2,
//               child: Row(
//                 children: <Widget>[
//                   Container(
//                     width: (MediaQuery.of(context).size.width - 140) / 2,
//                     height: 40,
//                     decoration: BoxDecoration(
//                         color: grey, borderRadius: BorderRadius.circular(20)),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 12),
//                       child: TextField(
//                         cursorColor: black,
//                         controller: _sendMessageController,
//                         decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Aa",
//                             suffixIcon: Icon(
//                               Icons.sentiment_satisfied_alt,
//                               color: Colors.blue,
//                               size: 35,
//                             )),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Icon(
//                     Icons.thumb_up,
//                     size: 35,
//                     color: Colors.blue,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget getBody() {
//     return ListView(
//       padding: EdgeInsets.only(right: 10, left: 10, top: 20, bottom: 10),
//       children: List.generate(messages.length, (index) {
//         return ChatBubble(
//             isMe: messages[index]["sender"] != widget.id,
//             messageType: 3,
//             message: messages[index]["message"],
//             profileImg: widget.avatar != null
//                 ? widget.avatar
//                 : AssetImage('assets/avatar.jpg'),
//             id: widget.id);
//       }),
//     );
//   }

//   @override
//   // TODO: implement wantKeepAlive
//   bool get wantKeepAlive => true;
// }

// class ChatBubble extends StatelessWidget {
//   final bool isMe;
//   final String profileImg;
//   final String message;
//   final int messageType;
//   final String id;
//   const ChatBubble(
//       {Key key,
//       this.isMe,
//       this.profileImg,
//       this.message,
//       this.messageType,
//       this.id})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (isMe) {
//       return Padding(
//         padding: const EdgeInsets.all(1.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             Flexible(
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: getMessageType(messageType)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(9.0),
//                   child: Text(
//                     message != null ? message : "null",
//                     style: TextStyle(color: white, fontSize: 17),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       );
//     } else {
//       return Padding(
//         padding: EdgeInsets.all(1.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               width: 35,
//               height: 35,
//               decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                       image: NetworkImage(profileImg), fit: BoxFit.cover)),
//             ),
//             SizedBox(
//               width: 15,
//             ),
//             Flexible(
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: grey, borderRadius: getMessageType(messageType)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(9.0),
//                   child: Text(
//                     message != null ? message : "null",
//                     style: TextStyle(color: black, fontSize: 17),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       );
//     }
//   }

//   getMessageType(messageType) {
//     if (isMe) {
//       // start message
//       if (messageType == 1) {
//         return BorderRadius.only(
//             topRight: Radius.circular(30),
//             bottomRight: Radius.circular(5),
//             topLeft: Radius.circular(30),
//             bottomLeft: Radius.circular(30));
//       }
//       // middle message
//       else if (messageType == 2) {
//         return BorderRadius.only(
//             topRight: Radius.circular(5),
//             bottomRight: Radius.circular(5),
//             topLeft: Radius.circular(30),
//             bottomLeft: Radius.circular(30));
//       }
//       // end message
//       else if (messageType == 3) {
//         return BorderRadius.only(
//             topRight: Radius.circular(5),
//             bottomRight: Radius.circular(30),
//             topLeft: Radius.circular(30),
//             bottomLeft: Radius.circular(30));
//       }
//       // standalone message
//       else {
//         return BorderRadius.all(Radius.circular(30));
//       }
//     }
//     // for sender bubble
//     else {
//       // start message
//       if (messageType == 1) {
//         return BorderRadius.only(
//             topLeft: Radius.circular(30),
//             bottomLeft: Radius.circular(5),
//             topRight: Radius.circular(30),
//             bottomRight: Radius.circular(30));
//       }
//       // middle message
//       else if (messageType == 2) {
//         return BorderRadius.only(
//             topLeft: Radius.circular(5),
//             bottomLeft: Radius.circular(5),
//             topRight: Radius.circular(30),
//             bottomRight: Radius.circular(30));
//       }
//       // end message
//       else if (messageType == 3) {
//         return BorderRadius.only(
//             topLeft: Radius.circular(5),
//             bottomLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//             bottomRight: Radius.circular(30));
//       }
//       // standalone message
//       else {
//         return BorderRadius.all(Radius.circular(30));
//       }
//     }
//   }
// }
