import 'package:fakebook_flutter_app/src/helpers/colors_constant.dart';
import 'package:fakebook_flutter_app/src/views/HomePage/TabBarView/HomeTab/hihi.dart';
import 'package:fakebook_flutter_app/src/views/HomePage/TabBarView/HomeTab/home_tab.dart';
import 'package:fakebook_flutter_app/src/views/HomePage/TabBarView/FriendTab/friends_tab.dart';
import 'package:fakebook_flutter_app/src/views/HomePage/TabBarView/WatchTab/watch_tab.dart';
import 'package:fakebook_flutter_app/src/views/HomePage/TabBarView/NotificationTab/notifications_tab.dart';
import 'package:fakebook_flutter_app/src/views/HomePage/TabBarView/MenuTab/menu_tab.dart';
import 'package:fakebook_flutter_app/src/views/Search/searched_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fakebook_flutter_app/src/views/Chat/home_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        body: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                stretch: false,
                backgroundColor: Colors.white,
                floating: true,
                pinned: true,
                snap: false,
                forceElevated: false,
                automaticallyImplyLeading: false,
                brightness: Brightness.light,
                title: Text('facebook',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold)),
                actions: [
                  Container(
                    decoration: new BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      color: Colors.black,
                      tooltip: 'search',
                      onPressed: () {
                        Navigator.pushNamed(context, "home_search_screen");
                      },
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    //margin: const EdgeInsets.all(10),
                    decoration: new BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(FontAwesomeIcons.facebookMessenger),
                      color: Colors.black,
                      //tooltip: 'Add new entry',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPage()));
                      },
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
                elevation: 0.0,
                bottom: TabBar(
                  indicatorColor: kColorBlue,
                  controller: _tabController,
                  unselectedLabelColor: kColorBlack,
                  labelColor: kColorBlue,
                  tabs: [
                    Tab(icon: Icon(Icons.home_outlined, size: 30.0)),
                    Tab(icon: Icon(Icons.people, size: 30.0)),
                    Tab(icon: Icon(Icons.ondemand_video, size: 30.0)),
                    Tab(icon: Icon(Icons.notifications, size: 30.0)),
                    Tab(icon: Icon(Icons.menu, size: 30.0))
                  ],
                ),
              ),
            ];
          },
          body: new TabBarView(controller: _tabController, children: [
            CharacterListView(),
            FriendsTab(),
            WatchTab(),
            NotificationsTab(),
            MenuTab()
          ]),
        ),
      ),
    );
  }
}
