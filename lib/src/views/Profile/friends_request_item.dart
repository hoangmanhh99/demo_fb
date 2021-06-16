import 'package:flutter/material.dart';
import './models/friends.dart';

class FriendRequestItem extends StatelessWidget{
  Friends friend_request_item;
  FriendRequestItem({this.friend_request_item});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlatButton(
      onPressed: (){print(this.friend_request_item.username);},
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(

                children: [
                  Container(
                    // margin: EdgeInsets.only(left: 15.0),
                    height: 90.0,
                    width: 90.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(this.friend_request_item.avatar) ),
                    ),
                  ),
                  SizedBox(width: 12.0,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.62,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(this.friend_request_item.username,textAlign: TextAlign.start,style: TextStyle(fontSize: 16.0),),
                            Text('2 tuần'),
                          ],
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3.0),
                        width: MediaQuery.of(context).size.width * 0.62,
                        child: Text('90 bạn chung',textAlign: TextAlign.start,style: TextStyle(fontSize: 14.0, color: Colors.black54),),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FlatButton(
                              minWidth: 105.0,
                              onPressed: (){},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                              ),
                              color: Colors.blue,
                              child: Text('Chấp nhận',style: TextStyle(color: Colors.white),),
                            ),
                            SizedBox(width: 8.0,),
                            FlatButton(
                              minWidth: 105.0,
                              onPressed: (){},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                              ),
                              color:Color.fromARGB(110, 192, 195, 195) ,
                              child: Text('Xoá'),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          // Container(
          //   margin: EdgeInsets.only(top:14.0),
          //   child:Text('2 tuần') ,
          // )
        ],
      ),
    );
  }
}