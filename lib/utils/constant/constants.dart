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
String lastname = '';
String midlename = '';
num phone = 0;
String profilephoto = '';
List<double> spilist = [];

GetList getlist = GetList();

int semester = 0;
int year = 0;

List<String> getbranchlist = [];
String eventTitle = '';
String eventCoordinatorName = '';
String eventCoordinatorEmail = '';
String eventAbout = '';
DateTime? eventDueDate;
String? eventLink;
String eventCoverPhoto = '';
Timestamp? timestamp;
  List<Map<String, dynamic>> resultlist = [];


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
  return await FirebaseFirestore.instance.collection(uType).doc(uId).get().then(
    (DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        
        if (uType == 'Teacher') {
          department = snapshot['Department'];
          teacherid = snapshot['TID'];
        }
        if (uType == 'Student') {
          branch = snapshot['Branch'];
          cpi = snapshot['CPI'];
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
        accounttype = snapshot['Account Type'];
        email = snapshot['Email'];
        firstname = snapshot['First Name'];
        midlename = snapshot['Midle Name'];
        lastname = snapshot['Last Name'];
        profilephoto = snapshot['Profile Photo'];
        phone = snapshot['Phone'];
      }
      print(semester);
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

Future<List<Map<String, dynamic>>> getstudentresult(
    String uType, String uId) async {
  List<double> spivaluelist = [];
  List<Map<dynamic, dynamic>> subjectlist = [];

  await getlist.getsemesterlistforresult().then(
    (value) async {
      print('Value is in constants dart file is $value');
      for (int i = 0; i < value.length; i++) {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection(uType)
            .doc(uId)
            .collection(value[i].name.toString())
            .get();
        Map<String, dynamic> mapobject = {};

        for (QueryDocumentSnapshot sn in snapshot.docs) {
          mapobject.addAll({'${sn['Subject']}': '${sn['Marks']}'});
          print('Map object is in for loop is $mapobject');
        }
        resultlist.add(mapobject);
      }
    },
  );
  print('Result list is in constant dart file is $resultlist');
  return resultlist;
 
}


//for logout remove current usertype and userid and userdetail
Future removeLocalData() async {
  final pref = await SharedPreferences.getInstance();
  await pref.remove('uType');
  await pref.remove('uId');
}
