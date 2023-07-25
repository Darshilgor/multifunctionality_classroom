import 'package:flutter/material.dart';
import 'package:my_app/Home/classroom/classroom.dart';
import 'package:my_app/Home/liveclass/liveclass.dart';
import 'package:my_app/Home/profile/profile.dart';
import 'package:my_app/utils/Drawer/navbar.dart';
import 'package:my_app/utils/constant/constants.dart';

import 'dashboard/dashboard.dart';

class ForStudent extends StatefulWidget {
  const ForStudent({
    super.key,
  });

  @override
  State<ForStudent> createState() => _HomeState();
}

class _HomeState extends State<ForStudent> {
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
  void initState() {
    super.initState();
    //getting sharedpreference value of user type and id type
    getLocalData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar(),
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
}
