import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/adminpage.dart';
import 'package:my_app/choise.dart';
import 'package:my_app/constants.dart';
import 'package:my_app/main.dart';

void main(List<String> args) {
  runApp(
    const MyApp(),
  );
}

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final user = FirebaseAuth.instance.currentUser;
  String fname = '';
  String lname = '';
  String mname = '';
  String mail = '';
  String type = '';

  @override
  void initState() {
    super.initState();
    getLocalData();
    userData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // navbar account photo
          UserAccountsDrawerHeader(
            accountName: Text('$fname $lname'),
            accountEmail: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(mail),
                  Text(type),
                ],
              ),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "assets/edited_darshil.jpg",
                  fit: BoxFit.cover,
                  height: 250,
                  width: 250,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backgroundimage1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.info,
              size: 27,
            ),
            title: Text(
              "About",
              style: TextStyle(fontSize: 17),
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
              FirebaseAuth.instance.signOut();
              {
                Navigator.push(context,
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

  Future userData() async {
    await FirebaseFirestore.instance
        .collection(uType.toString())
        .doc(uId.toString())
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        setState(() {
          fname = snapshot.data()!['First Name'];
          mname = snapshot.data()!['Midle Name'];
          lname = snapshot.data()!['Last Name'];
          mail = snapshot.data()!['Email'];
          type = snapshot.data()!['Account Type'];
        });
      }
    });
  }
}
