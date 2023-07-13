import 'package:flutter/material.dart';

class Member extends StatelessWidget {
  const Member({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 27,
              child: ClipOval(
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
            ),
            title: Text(
              "Teacher1",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text("Teacher"),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 27,
              child: ClipOval(
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
            ),
            title: Text(
              "Teacher2",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text("Teacher"),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 27,
              child: ClipOval(
                child: Image.asset("assets/edited_darshil.jpg"),
              ),
            ),
            title: Text(
              "Student1",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text("Student"),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 27,
              child: ClipOval(
                child: Image.asset("assets/edited_darshil.jpg"),
              ),
            ),
            title: Text(
              "Student2",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text("Student"),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 27,
              child: ClipOval(
                child: Image.asset("assets/edited_darshil.jpg"),
              ),
            ),
            title: Text(
              "Student3",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text("Student"),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 27,
              child: ClipOval(
                child: Image.asset("assets/edited_darshil.jpg"),
              ),
            ),
            title: Text(
              "Student4",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text("Student"),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 27,
              child: ClipOval(
                child: Image.asset("assets/edited_darshil.jpg"),
              ),
            ),
            title: Text(
              "Student5",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text("Student"),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 27,
              child: ClipOval(
                child: Image.asset("assets/edited_darshil.jpg"),
              ),
            ),
            title: Text(
              "Student6",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text("Student"),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 27,
              child: ClipOval(
                child: Image.asset("assets/edited_darshil.jpg"),
              ),
            ),
            title: Text(
              "Student7",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text("Student"),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 27,
              child: ClipOval(
                child: Image.asset("assets/edited_darshil.jpg"),
              ),
            ),
            title: Text(
              "Student8",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text("Student"),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 27,
              child: ClipOval(
                child: Image.asset("assets/edited_darshil.jpg"),
              ),
            ),
            title: Text(
              "Student9",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text("Student"),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 27,
              child: ClipOval(
                child: Image.asset("assets/edited_darshil.jpg"),
              ),
            ),
            title: Text(
              "Student10",
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text("Student"),
          ),
        ],
      ),
    );
  }
}
