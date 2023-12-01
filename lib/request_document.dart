import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/constant/constants.dart';

class Request_Document extends StatefulWidget {
  const Request_Document({super.key});

  @override
  State<Request_Document> createState() => _Request_DocumentState();
}

class _Request_DocumentState extends State<Request_Document> {
  String classname = '';
  String branchname = '';
  String teacherid = '';
  String studentfirstname = '';
  String studentlastname = '';
  List<String> requestedDocuments = [];
  @override
  void initState() {
    super.initState();
    getstudetndata();
  }

  Widget build(BuildContext context) {
    bool bonafiteflag = false;
    bool admissionflag = false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Documents'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                showlistofdocumentsmethod(
                  'Bonafite Certificate',
                ),
                SizedBox(
                  height: 20,
                ),
                showlistofdocumentsmethod(
                  'Admission Latter',
                ),
              ],
            ),
            button(bonafiteflag, admissionflag),
          ],
        ),
      ),
    );
  }

  showlistofdocumentsmethod(
    String labeltext,
  ) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                if (requestedDocuments.contains(labeltext)) {
                  requestedDocuments.remove(labeltext);
                } else {
                  requestedDocuments.add(labeltext);
                }
                setState(() {});
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.06,
                  padding: EdgeInsets.all(
                    15,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    color: (requestedDocuments.contains(labeltext))
                        ? Colors.grey
                        : Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    labeltext,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  button(bool bonafiteflag, bool admissionflag) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            print('OnTapped');
            sendrequesttoteacher(studentfirstname, studentlastname, classname,
                branchname, bonafiteflag, admissionflag);
            Navigator.pop(context);
            SnackBar(content: Text("Your Request Has been send"));
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(
                20,
              ),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                "Request",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Future getstudetndata() async {
    await FirebaseFirestore.instance.collection(uType).doc(uId).get().then(
      (value) {
        classname = value.data()!['Class'];
        branchname = value.data()!['Branch'];
        studentfirstname = value.data()!['First Name'];
        studentlastname = value.data()!['Last Name'];
      },
    );
    print(studentfirstname);
    print(studentlastname);
    print(classname);
    print(branchname);
  }

  Future sendrequesttoteacher(
      String studentfirstname,
      String studentlastname,
      String classname,
      String branchname,
      bool bonafiteflag,
      bool admissionflag) async {
    await FirebaseFirestore.instance.collection('Teacher').get().then(
      (QuerySnapshot snapshot) {
        snapshot.docs.forEach(
          (element) {
            if ((element['Department'] == branchname) &&
                (element['Class'] == classname)) {
              teacherid = element['TID'];
              print(
                element['First Name'],
              );
            }
          },
        );
      },
    );
    try {
      if (requestedDocuments.contains("Bonafite Certificate")) {
        await FirebaseFirestore.instance
            .collection('Teacher')
            .doc(teacherid)
            .collection('Document Request')
            .doc('Bonafite Certificate')
            .collection(uId.toString())
            .doc('$studentfirstname $studentlastname'.toString())
            .set(
              {
                'First Name': studentfirstname,
                'Last Name': studentlastname,
                'Class': classname,
                'Branch': branchname,
                'Status': 'Pending',
              },
            )
            .then((value) => print("done1"))
            .onError((error, stackTrace) => print(error));
      }
      if (requestedDocuments.contains("Admission Latter")) {
        await FirebaseFirestore.instance
            .collection('Teacher')
            .doc(teacherid)
            .collection('Document Request')
            .doc('Admission Later')
            .collection(uId)
            .doc(studentfirstname + ' ' + studentlastname)
            .set(
              {
                'Enrollment No': uId,
                'First Name': studentfirstname,
                'Last Name': studentlastname,
                'Status': 'Pending',
              },
            )
            .then((value) => print("done2"))
            .onError((error, stackTrace) => print(error));
      }
    } on FirebaseException catch (e) {
      print(e);
    }

    print('All Done');
  }
}
