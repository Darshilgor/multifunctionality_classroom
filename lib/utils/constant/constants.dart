import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String uType = '';
String uId = '';
String userfirstname = '';
String userlastname = '';
String className = '';
String userprofilephoto = '';
String eventTitle = '';
String eventCoordinatorName = '';
String eventCoordinatorEmail = '';
String eventAbout = '';
DateTime? eventDueDate;
String? eventLink;
String eventCoverPhoto = '';
Timestamp? timestamp;
bool isLoading = false;
int studentsemester = 0;

//store current login usertype and userid
Future setLocalData(String usertype, String userid) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('uType', usertype);
  pref.setString('uId', userid);
}

//get current login usertype and userid
Future getLocalData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  uType = pref.getString('uType') ?? uType;
  uId = pref.getString('uId') ?? uId;
}

//for logout remove current usertype and userid and userdetail
Future removeLocalData() async {
  final pref = await SharedPreferences.getInstance();
  await pref.remove('uType');
  await pref.remove('uId');
}

// Future setdata() async {
//   if (uType == 'Student') {
//     await FirebaseFirestore.instance.collection(uType).doc(uId).get().then(
//       (value) {
//         studentsemester = value['Semester'] as int;
//       },
//     );
//   }
//   print(studentsemester);
// }
