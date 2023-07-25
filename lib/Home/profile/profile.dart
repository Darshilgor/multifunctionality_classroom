import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/utils/constant/constants.dart';
import 'package:my_app/utils/login/choise.dart';
// import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser;
  final String ut = uType;
  final String ui = uId;
  String fname = '';
  String mname = '';
  String lname = '';
  String mail = '';
  String phone = '';
  String course = '';
  String semester = '';
  String year = '';
  String enrollment = '';
  String id = '';
  String department = '';
  String accounttype = '';
  String teacherid = '';
  String adminid = '';
  String profileimageurl = '';

  @override
  void initState() {
    super.initState();
    //getting login user data
    userData();
  }

  File? profileimage;

  final ImagePicker _picker = ImagePicker();
  String profilephotourl = '';
  String profileurl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            //profile photo

            profileImage(context),

            //profile field of user first name,midle name,last name
            Visibility(
              child: Column(
                children: [
                  addProfileField('Name', '$fname $mname $lname'),
                ],
              ),
            ),

            //profile field if user type is student
            Visibility(
              visible: uType == 'Student',
              child: Column(
                children: [
                  addProfileField('Enrollment No', enrollment),
                  addProfileField('Email', mail),
                  addProfileField('Phone No', phone),
                  addProfileField('Account Type', accounttype),
                  addProfileField('Branch', course),
                  addProfileField('Semester', semester),
                  addProfileField('Year', year),
                ],
              ),
            ),
            //profile field if user type is admin
            Visibility(
              visible: uType == 'Admin',
              child: Column(
                children: [
                  addProfileField('Admin Id', adminid),
                  addProfileField('Email', mail),
                  addProfileField('Phone No', phone),
                  addProfileField('Account Type', accounttype),
                  addProfileField('Department', department),
                  addProfileField('Year', year),
                ],
              ),
            ),
            //profile field if user type is teacher
            Visibility(
              visible: uType == 'Teacher',
              child: Column(
                children: [
                  addProfileField('Teacher Id', teacherid),
                  addProfileField('Email', mail),
                  addProfileField('Phone No', phone),
                  addProfileField('Account Type', accounttype),
                  addProfileField('Department', department),
                  addProfileField('Year', year),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              //log out button
              child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Choise(),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Log Out",
                    style: TextStyle(fontSize: 23),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

//text form field method
  Widget addProfileField(String label, String labeltext) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            '$label:',
            style: const TextStyle(fontSize: 17),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 7,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                label: Text(labeltext),
                enabled: false,
                labelStyle: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        )
      ],
    );
  }

//get login user data method
  Future userData() async {
    await FirebaseFirestore.instance.collection(uType).doc(uId).get().then(
      (snapshot) async {
        if (snapshot.exists) {
          setState(
            () {
              if (uType == 'Student') {
                semester = snapshot.data()!['Semester'];
                enrollment = snapshot.data()!['Enrollment No'];
                course = snapshot.data()!['Branch'];
              } else if (uType == 'Teacher') {
                teacherid = snapshot.data()!['TID'];
                department = snapshot.data()!['Department'];
              } else if (uType == 'Admin') {
                adminid = snapshot.data()!['AID'];
                department = snapshot.data()!['Department'];
              }
              fname = snapshot.data()!['First Name'];
              mname = snapshot.data()!['Midle Name'];
              lname = snapshot.data()!['Last Name'];
              mail = snapshot.data()!['Email'];
              phone = snapshot.data()!['Phone'];
              year = snapshot.data()!['Year'];
              accounttype = snapshot.data()!['Account Type'];
              profileimageurl = snapshot.data()!['Profile Photo'];
            },
          );
          setState(() {});
        }
      },
    );
  }

  //profile image method
  profileImage(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: CircleAvatar(
            radius: 80,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
              profileimageurl.toString(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 120, left: 230),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 8, color: const Color.fromARGB(255, 82, 165, 232)),
                color: const Color.fromARGB(255, 82, 165, 232)),
            child: InkWell(
              child: const Icon(
                Icons.edit,
                size: 30,
                color: Colors.white,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => showAlert(context),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

//change profile image method
  showAlert(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
          "Choose Profile Photo",
        ),
      ),
      content: IconButton(
        onPressed: () {},
        icon: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  gallery();
                },
                child: const Icon(
                  Icons.file_upload_outlined,
                  size: 35,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              InkWell(
                onTap: () {
                  camera();
                },
                child: Icon(
                  Icons.camera,
                  size: 35,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future gallery() async {
    final pickedfile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      setState(
        () {
          profileimage = File(pickedfile.path);
        },
      );
      try {
        if (uType == 'Student') {
          final file = File(profileimage!.path);
          final storageref = FirebaseStorage.instance.ref().child(
              'images/Profile/StudentProfilePhoto/${enrollment.toString()}');
          storageref.putFile(file).whenComplete(
            () async {
              profileurl = await FirebaseStorage.instance
                  .ref()
                  .child(
                      'images/Profile/StudentProfilePhoto/${enrollment.toString()}')
                  .getDownloadURL()
                  .whenComplete(() {});
              setState(() {
                profileimageurl = profileurl;
              });
              set();
            },
          );
        } else if (uType == 'Teacher') {
          final file = File(profileimage!.path);
          final storageref = FirebaseStorage.instance.ref().child(
              'images/Profile/TeacherProfilePhoto/${teacherid.toString()}');
          storageref.putFile(file).whenComplete(
            () async {
              profileurl = await FirebaseStorage.instance
                  .ref()
                  .child(
                      'images/Profile/TeacherProfilePhoto/${teacherid.toString()}')
                  .getDownloadURL()
                  .whenComplete(() {});
              setState(() {
                profileimageurl = profileurl;
              });
              set();
            },
          );
        } else if (uType == 'Admin') {
          final file = File(profileimage!.path);
          final storageref = FirebaseStorage.instance
              .ref()
              .child('images/Profile/AdminProfilePhoto/${adminid.toString()}');
          storageref.putFile(file).whenComplete(
            () async {
              profileurl = await FirebaseStorage.instance
                  .ref()
                  .child(
                      'images/Profile/AdminProfilePhoto/${adminid.toString()}')
                  .getDownloadURL()
                  .whenComplete(() {});
              setState(() {
                profileimageurl = profileurl;
              });
              set();
            },
          );
        }
      } catch (e) {
        return e;
      }
      Navigator.pop(context);
    }
  }

  Future camera() async {
    final pickedfile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedfile != null) {
      setState(() {
        profileimage = File(pickedfile.path);
      });
    }
  }

  Future set() async {
    return await FirebaseFirestore.instance.collection(uType).doc(uId).update(
      {
        'Profile Photo': profileimageurl.toString(),
        'Account Type': accounttype.toString(),
        'Branch': course.toString(),
        'Email': mail.toString(),
        'Enrollment No': enrollment.toString(),
        'First Name': fname.toString(),
        'Midle Name': mname.toString(),
        'Last Name': lname.toString(),
        'Phone': phone.toString(),
        'Semester': semester.toString(),
        'Year': year.toString(),
      },
    );
    // setState(() {});
  }
}
