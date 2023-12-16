import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/utils/constant/getlist.dart';
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

// List<String> firstsemsubjectlist=[];
// List<String> secondsemsubjectlist=[];
// List<String> thirdsemsubjectlist=[];
// List<String> fourthsemsubjectlist=[];
// List<String> fifthsemsubjectlist=[];
// List<String> sixsemsubjectlist=[];
// List<String> sevensemsubjectlist=[];
// List<String> eightsemsubjectlist=[];

GetList getlist = GetList();

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
  SharedPreferences pref = await SharedPreferences
      .getInstance(); //use for set data in local variable.
  pref.setString("uType", usertype);
  pref.setString("uId", userid);
}

//get current login usertype and userid
Future getLocalData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  uType = pref.getString('uType') ?? uType;
  uId = pref.getString('uId') ?? uId;
}

Future getloginuserdata(uType, uId) async {
  List<double> spilist = [];

  return await FirebaseFirestore.instance.collection(uType).doc(uId).get().then(
    (DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        accounttype = snapshot['Account Type'];
        email = snapshot['Email'];
        firstname = snapshot['First Name'];
        midlename = snapshot['Midle Name'];
        lastname = snapshot['Last Name'];
        profilephoto = snapshot['Profile Photo'];
        phone = snapshot['Phone'];
        if (uType == 'Teacher') {
          department = snapshot['Department'];
          teacherid = snapshot['TID'];
        }
        if (uType == 'Student') {
          branch = snapshot['Branch'];
          cpi = snapshot['CPI'].toDouble();
          className = snapshot['Class'];
          enrollmentno = snapshot['Enrollment No'];
          year = snapshot['Year'];
          semester = snapshot['Semester'];
          for (int i = 1; i < semester; i++) {
            spilist.add(snapshot['SPI$i']);
          }
        }
        if (uType == 'Admin') {
          department = snapshot['Department'];
          adminid = snapshot['AID'];
        }
      }
      print('SPI List In Constant File Is ${spilist}');
      print('Semester Value in Constant File Is ${semester}');
      if (uType == 'Student' && semester != 0) {
        getstudentresult(uType, uId);
      }
      print('SPI List in Constant file $spilist');
      // print('Subject List in Constant File $subjectlist');
    },
  );
}

Future<List<double>> getstudentresult(String uType, String uId) async {
  num marks = 0;
  List<double> spivaluelist = [];
  List<List<String>> subjectlist = [[]];
  List<List<String>> markslist = [[]];
  await getlist.getsemesterlistforresult().then(
    (value) async {
      for (int i = 0; i < value.length; i++) {
        print(value);
        print('You Reached there');
        await FirebaseFirestore.instance
            .collection(uType)
            .doc(uId)
            .collection(value[i].name)
            .get()
            .then(
          (QuerySnapshot snapshot) {
            snapshot.docs.forEach(
              (element) {
                // print(
                //     'In Constant File Marks of ${value[i].name} Is ${element['Marks']}');
                // marks += element['Marks'];
                // print(
                //     'In Constant File Total Marks of ${value[i].name} Is ${marks}');
                // print(
                //     'Length of documents In ${value[i]} Is ${snapshot.docs.length}');
                // spivaluelist.add(marks / snapshot.docs.length);

                // for (int j = 0; j < snapshot.docs.length; j++) {
                //   subjectlist[i][j] = element['Subject'];
                // }
              },
            );
          },
        );
      }
    },
  );
  print('SPI List in Constant file $spivaluelist');
  print('Subject List in Constant File $subjectlist');
  return spivaluelist;
  // return FutureBuilder(
  //   future: getlist.getsemesterlistforresult(),
  //   builder: (context, future) {
  //     if (future.hasData) {
  //       list = future.data;
  //       spilist = getstudentresultdetails(list) as List<double>;
  //       print('List of SPI IS This $spilist');
  //     }

  //   },
  // );
}

// Future<List<double>> getstudentresultdetails(
//     List<DropDownValueModel> list) async {

//   for (int i = 0; i < list.length; i++) {

//     spilist.add(marks / noofsubject);
//     print('SPI List in Constant file $spilist');
//     print('Subject List in Constant File $subjectlist');
//   }

//   return spilist;
// }

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
