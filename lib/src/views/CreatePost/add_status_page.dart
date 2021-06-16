import 'package:fakebook_flutter_app/src/helpers/colors_constant.dart';
import 'package:fakebook_flutter_app/src/widgets/feelling_activity_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeelingAndActivity {
  String status;
  String icon;

  FeelingAndActivity(this.status, this.icon);
}

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> with TickerProviderStateMixin {
  TabController tabController;

  List<FeelingAndActivity> list = [
    new FeelingAndActivity("hạnh phúc", "🙂"),
    new FeelingAndActivity("có phúc", "😇"),
    new FeelingAndActivity("được yêu", "🥰"),
    new FeelingAndActivity("buồn", "😟"),
    new FeelingAndActivity("đáng yêu", "😘"),
    new FeelingAndActivity("biết ơn", "😚"),
    new FeelingAndActivity("hào hứng", "😛"),
    new FeelingAndActivity("đang yêu", "😘"),
    new FeelingAndActivity("điên", "🤪"),
    new FeelingAndActivity("cảm kích", "🤭"),
    new FeelingAndActivity("sung sướng", "😁"),
    new FeelingAndActivity("tuyệt vời", "🤓"),
    new FeelingAndActivity("ngốc nghếch", "😋"),
    new FeelingAndActivity("vui vẻ", "😉"),
    new FeelingAndActivity("thật phong cách", "😎"),
    new FeelingAndActivity("thú vị", "🤭"),
    new FeelingAndActivity("thư giãn", "😌"),
    new FeelingAndActivity("mệt mỏi", "😪"),
    new FeelingAndActivity("giận dữ", "😤"),
    new FeelingAndActivity("xúc động", "😧"),
  ];

  List<FeelingAndActivity> list2 = [
    new FeelingAndActivity("Đang chúc mừng...", "🎉"),
    new FeelingAndActivity("Đang xem...", "👓"),
    new FeelingAndActivity("Đang ăn...", "🍩"),
    new FeelingAndActivity("Đang tham gia...", "📅"),
    new FeelingAndActivity("Đang đi tới...", "🛫"),
    new FeelingAndActivity("Đang nghe...", "🎧"),
    new FeelingAndActivity("Đang tìm...", "🔎"),
    new FeelingAndActivity("Đang nghĩ về...", "🌬️"),
  ];

/*
  List<FeelingActivityCard> list = [
    FeelingActivityCard(str: "hạnh phúc", icon: Icons.add),
    FeelingActivityCard(str: "buồn", icon: Icons.add),
    FeelingActivityCard(str: "đáng yêu", icon: Icons.add),
    FeelingActivityCard(str: "sung sướng", icon: Icons.add),
    FeelingActivityCard(str: "tuyệt vời", icon: Icons.add),
    FeelingActivityCard(str: "ngốc nghếch", icon: Icons.add),
    FeelingActivityCard(str: "ngốc nghếch", icon: Icons.add),
    FeelingActivityCard(str: "ngốc nghếch", icon: Icons.add),
    FeelingActivityCard(str: "ngốc nghếch", icon: Icons.add),
    FeelingActivityCard(str: "ngốc nghếch", icon: Icons.add),
    FeelingActivityCard(str: "ngốc nghếch", icon: Icons.add),
    FeelingActivityCard(str: "hạnh phúc", icon: Icons.add),
    FeelingActivityCard(str: "buồn", icon: Icons.add),
    FeelingActivityCard(str: "đáng yêu", icon: Icons.add),
    FeelingActivityCard(str: "sung sướng", icon: Icons.add),
    FeelingActivityCard(str: "tuyệt vời", icon: Icons.add),
    FeelingActivityCard(str: "ngốc nghếch", icon: Icons.add),
    FeelingActivityCard(str: "ngốc nghếch", icon: Icons.add),
    FeelingActivityCard(str: "ngốc nghếch", icon: Icons.add),
    FeelingActivityCard(str: "ngốc nghếch", icon: Icons.add),
    FeelingActivityCard(str: "ngốc nghếch", icon: Icons.add),
    FeelingActivityCard(str: "ngốc nghếch", icon: Icons.add),
  ];

 */

  //Future<String> deviceId = _getId();

  @override
  Widget build(BuildContext context) {
    FeelingAndActivity status = ModalRoute.of(context).settings.arguments;

    tabController = new TabController(length: 2, vsync: this);

    var tabBarItem = new TabBar(
      indicatorColor: Colors.blueAccent,
      unselectedLabelColor: kColorBlack,
      labelColor: Colors.blueAccent,
      tabs: [
        new Tab(
          text: "CẢM XÚC",
        ),
        new Tab(
          text: "HOẠT ĐỘNG",
        ),
      ],
      controller: tabController,
      //indicatorColor: Colors.white,
    );

    var listItem = new ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: new Card(
            elevation: 5.0,
            child: new Container(
              alignment: Alignment.center,
              margin: new EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: new Text(
                ":) $index",
                style: TextStyle(fontFamily: "emoji"),
              ),
            ),
          ),
          onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                child: new CupertinoAlertDialog(
                  title: new Column(
                    children: <Widget>[
                      new Text("ListView"),
                      new Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  content: new Text("Selected Item $index"),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text("OK"))
                  ],
                ));
          },
        );
      },
    );

    var gridView = new GridView.builder(
        itemCount: list.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: FeelingActivityCard(
              list[index],
            ),
            onTap: () {
              Navigator.pop(context, list[index]);
            },
          );
        });

    var gridView2 = new GridView.builder(
        itemCount: list2.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: FeelingActivityCard(
              list2[index],
            ),
            onTap: () {
              //Navigator.pop(context, list2[index]);
            },
          );
        });

    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: kColorWhite,
          textTheme: TextTheme(
            button: TextStyle(color: kColorBlack),
            caption: TextStyle(color: kColorBlack),
          ),

          //shape: Border.fromBorderSide(BorderSide(color: Colors.black)),
          leading: IconButton(
            color: kColorBlack,
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: new Text(
            "Bạn đang cảm thấy thế nào?",
            style: TextStyle(color: kColorBlack),
          ),
          bottom: tabBarItem,
        ),
        body: Column(
          children: [
            status != null
                ? Container(
                    height: 55,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(status.icon,
                                style: TextStyle(
                                    fontSize: 35, fontFamily: 'NotoEmoji')),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              status.status,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            print("ok");
                            setState(() {
                              status = null;
                            });
                          },
                          child: Icon(Icons.clear),
                        )
                      ],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey[500],
                            size: 24,
                          )),
                    ),
                  ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  gridView,
                  gridView2,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
