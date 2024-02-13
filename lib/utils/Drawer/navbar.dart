import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/student_corner_features.dart';
import 'package:my_app/teachercorner.dart';
import 'package:my_app/utils/Admin/adminpage.dart';
import 'package:my_app/utils/Drawer/courses/courses.dart';
import 'package:my_app/utils/Drawer/studentlist/studentlist.dart';
import 'package:my_app/utils/Drawer/teacherlist/teacherlist.dart';
import 'package:my_app/utils/constant/constants.dart';
import 'package:my_app/utils/login/choise.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  // final user = FirebaseAuth.instance.currentUser;
  // String fname = '';
  // String lname = '';
  // String mname = '';
  // String mail = '';
  // String type = '';
  // String profileimageurl = '';


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // navbar account photo
          UserAccountsDrawerHeader(
            accountName: Text('$firstname $lastname'),
            accountEmail: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(email),
                  Text(uType),
                ],
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(profilephoto.toString()),
              backgroundColor: Colors.transparent,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backgroundimage1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Visibility(
            visible: uType == 'Student',
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudetnCornerFeatures(),
                  ),
                );
              },
              leading: Icon(
                Icons.info,
                size: 27,
              ),
              title: Text(
                "Student Corner",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
          Visibility(
            visible: uType == 'Admin',
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Courses(),
                  ),
                );
              },
              leading: Icon(
                Icons.info,
                size: 27,
              ),
              title: Text(
                "Courses",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
          Visibility(
            visible: uType == 'Admin',
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeacherList(),
                  ),
                );
              },
              leading: Icon(
                Icons.info,
                size: 27,
              ),
              title: Text(
                "Teachers",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
          Visibility(
            visible: uType == 'Admin',
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentsList(),
                  ),
                );
              },
              leading: Icon(
                Icons.info,
                size: 27,
              ),
              title: Text(
                "Students",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
          Visibility(
            visible: uType == 'Admin',
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminPage(),
                  ),
                );
              },
              leading: Icon(
                Icons.admin_panel_settings,
                size: 29,
              ),
              title: Text(
                "Admin Panel",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
          Visibility(
            visible: uType == 'Teacher',
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TeacherCorner(),
                  ),
                );
              },
              leading: Icon(
                Icons.admin_panel_settings,
                size: 29,
              ),
              title: Text(
                "Teacher Corner",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.help,
              size: 25,
            ),
            title: Text(
              "Help",
              style: TextStyle(fontSize: 17),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.settings,
              size: 25,
            ),
            title: const Text(
              "Setting",
              style: TextStyle(fontSize: 17),
            ),
          ),
          ListTile(
            onTap: () {
              try {
                FirebaseAuth.instance.sendPasswordResetEmail(email: email).then(
                    (value) => Fluttertoast.showToast(
                        msg: 'Mail was send for resent password'));
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Choise()));
                FirebaseAuth.instance.signOut();
                setState(() {});
              } catch (e) {
                Fluttertoast.showToast(msg: e.toString());
                setState(() {});
              }
            },
            leading: Icon(
              Icons.lock_reset_outlined,
              size: 25,
            ),
            title: const Text(
              "reset password",
              style: TextStyle(fontSize: 17),
            ),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Choise()));
              }
            },
            leading: const Icon(
              Icons.logout,
              size: 25,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(fontSize: 17),
            ),
          )
        ],
      ),
    );
  }

  // Future userData() async {
  //   await FirebaseFirestore.instance
  //       .collection(uType.toString())
  //       .doc(uId.toString())
  //       .get()
  //       .then((snapshot) {
  //     if (snapshot.exists) {
  //       setState(() {
  //         fname = snapshot.data()!['First Name'];
  //         mname = snapshot.data()!['Midle Name'];
  //         lname = snapshot.data()!['Last Name'];
  //         mail = snapshot.data()!['Email'];
  //         type = snapshot.data()!['Account Type'];
  //         profileimageurl = snapshot.data()!['Profile Photo'];
  //       });
  //     }
  //   });
  // }
}
