import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';


String uType = '';
String uId = '';
String accounttype = '';
String branch = '';
double cpi = 0;
String className = '';
String department = '';
String email = '';
String enrollmentno = '';
String teacherid = '';
String adminid = '';
String firstname = '';
String midlename = '';
String lastname = '';
late num phone;
String profilephoto = '';

//in future uncomment if required.
// double spi1 = 0;
// late double spi2;
// late double spi3;
// late double spi4;
// late double spi5;
// late double spi6;
// late double spi7;
// late double spi8;

int semester = 0;
late int year;

List<double> spilist = [];
List<String> getbranchlist = [];
String eventTitle = '';
String eventCoordinatorName = '';
String eventCoordinatorEmail = '';
String eventAbout = '';
DateTime? eventDueDate;
String? eventLink;
String eventCoverPhoto = '';
Timestamp? timestamp;

//store current login usertype and userid
Future setLocalData(String usertype, String userid) async {
  int i = 1;

  // SharedPreferences pref = await SharedPreferences.getInstance(); //use for set data in local variable.

  return await FirebaseFirestore.instance
      .collection(usertype)
      .doc(userid)
      .get()
      .then(
    (DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        accounttype = snapshot['Account Type'];
        email = snapshot['Email'];
        firstname = snapshot['First Name'];
        midlename = snapshot['Midle Name'];
        lastname = snapshot['Last Name'];
        profilephoto = snapshot['Profile Photo'];
        phone = snapshot['Phone'];
        if (usertype == 'Teacher') {
          department = snapshot['Department'];
          teacherid = snapshot['TID'];
        }
        if (usertype == 'Student') {
          branch = snapshot['Branch'];
          cpi = snapshot['CPI'].toDouble();
          className = snapshot['Class'];
          enrollmentno = snapshot['Enrollment No'];
          year = snapshot['Year'];
          semester = snapshot['Semester'];
          for (int i = 1; i <= semester; i++) {
            spilist.add(snapshot['SPI$i']);
          }
        }
        if (usertype == 'Admin') {
          department = snapshot['Department'];
          adminid = snapshot['AID'];
        }
      }
    },
  );
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
