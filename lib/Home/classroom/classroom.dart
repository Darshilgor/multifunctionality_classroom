import 'package:flutter/material.dart';
import 'package:my_app/Home/classroom/classroom%20componant/member.dart';
import 'package:my_app/Home/classroom/classroom%20componant/subject.dart';

class Classroom extends StatelessWidget {
  const Classroom({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.blue,
          overlayColor: MaterialStateProperty.all(Colors.blue),
          tabs: <Tab>[
            Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.stream,
                    color: Colors.black,
                  ),
                  Text(
                    "Class Stream",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            Tab(
              child: Text(
                "Subject",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                "TODO",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                "Attendance",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                "Member",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        body: TabBarView(children: <Widget>[
          Center(
            child: Text("Class Stream"),            
            // child: Text("Class Stream"),
            // child: ClassStream(
            //   className: className.toString(),
            //   getKey: DateTime.now().toString(),),
          ),
          Center(
            child: Subject(),
          ),
          Center(
            child: Text("TODO"),
          ),
          Center(
            child: Text("Atendance"),
          ),
          Center(
            child: Member(),
          ),
        ]),
      ),
    );
  }
}
