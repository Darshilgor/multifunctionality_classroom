import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_app/Home/classroom/classroom.dart';
import 'package:my_app/Home/liveclass/liveclass.dart';
import 'package:my_app/Home/profile/profile.dart';
import 'package:my_app/notification_services.dart';
import 'package:my_app/utils/Drawer/navbar.dart';

import 'dashboard/dashboard.dart';
import 'package:http/http.dart' as http;

class ForStudent extends StatefulWidget {
  final String usertype, userid;
  const ForStudent({super.key, required this.userid, required this.usertype});

  @override
  State<ForStudent> createState() => _HomeState();
}

class _HomeState extends State<ForStudent> {
  notification_Services notificationservices = notification_Services();

  @override
  void initState() {
    super.initState();

    notificationservices.requestnotificationpermission();
    notificationservices.firebaseinit();
    notificationservices.ontokenrefresh();

    notificationservices.getdevicetoken().then(
          (value) => print(
            value,
          ),
        );
    sendnotification();
  }

  int index = 0;
  PageStorageBucket bucket = PageStorageBucket();
  final List screens = const [
    DashBoard(),
    Classroom(),
    Liveclass(),
    Profile(),
  ];
  Widget currentScreen = const DashBoard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 6,
        title: (index == 0)
            ? const Text(
                "Dashboard",
                style: TextStyle(fontSize: 25),
              )
            : ((index == 1)
                ? const Text(
                    "Classroom",
                    style: TextStyle(fontSize: 25),
                  )
                : ((index == 2)
                    ? const Text(
                        "Liveclass",
                        style: TextStyle(fontSize: 25),
                      )
                    : const Text(
                        "Profile",
                        style: TextStyle(fontSize: 25),
                      ))),
        actions: [
          //popmenu button
          PopupMenuButton(
            position: PopupMenuPosition.under,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text("Refresh"),
                  onTap: () {},
                ),
                PopupMenuItem(
                  child: Text("Report"),
                  onTap: () {},
                )
              ];
            },
          )
        ],
      ),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: false,
        currentIndex: index,
        onTap: (index) {
          setState(() {
            this.index = index;
            currentScreen = screens[index];
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Classroom',
              backgroundColor: Colors.deepOrange),
          BottomNavigationBarItem(
              icon: Icon(Icons.live_tv),
              label: 'Live Class',
              activeIcon: Icon(Icons.video_call_rounded),
              backgroundColor: Colors.lightGreen),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_ind),
              label: 'Profile',
              backgroundColor: Colors.orangeAccent),
        ],
      ),
    );
  }

  Future sendnotification() async {
    notificationservices.getdevicetoken().then(
      (value) async {
        var data = {
          'to': value.toString(),
          'priority': 'high',
          'notification': {
            'title': 'Gor',
            'body': 'Darshil',
          }
        };
        await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Authorization':
                'Key=AAAAkFDq8M4:APA91bH_62mL7DqvHbvwKyPNB5GagygGFkWi0ugeuVn6ZJaMTdlgA0FLbPgKuIBmTCqu3wmrT-TgmLip1994v6MkgibGX8-bN06NTJccgOoC3K8dhGZMyYU85WHkI8O2A4TF7vp3QP9X'
          },
        );
      },
    );
  }
}
