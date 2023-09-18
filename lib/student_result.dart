import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/constant/constants.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final semesterkey = GlobalKey<FormState>();
  List<String> semesters = [];
  List<DropDownValueModel> semesterlist = [];
  late SingleValueDropDownController semester;
  List<String> Subject = [];
  List<double> marks = [];
  List<double> listofspi = [];
  List<String> sem = [];
  List<double> sumlist = [];
  List<String> Subjectlength = [];
  List<String> SPIlist = [];
  double sum = 0;
  double average = 0;
  double total = 0;
  double cpi = 0;
  @override
  void initState() {
    super.initState();
    getsemesterlist();
    semester = SingleValueDropDownController();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Results",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          10,
        ),
        child: Column(
          children: [
            createstudentdropdown(context, "Select Semester", semesterlist,
                semester, true, "Select Select", semesterkey),
            if (semester.dropDownValue != null)
              getresultdetails(semester.dropDownValue!.name.toString()),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'SPI',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: TextFormField(
                controller: TextEditingController(text: '${(average)}'),
                readOnly: true,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'CPI',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: TextFormField(
                controller: TextEditingController(text: '$cpi'),
                readOnly: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getsemesterlist() async {
    await FirebaseFirestore.instance.collection('Semester').get().then(
      (QuerySnapshot snapshot) {
        snapshot.docs.forEach(
          (element) {
            setState(
              () {
                semesters.add(
                  element['Semester No'],
                );
              },
            );
          },
        );
        setState(() {
          sem = semesters.getRange(0, 5).toList();
        });
        for (int i = 0; i < sem.length; i++) {
          setState(
            () {
              semesterlist.add(
                DropDownValueModel(
                  name: sem[i],
                  value: sem[i],
                ),
              );
            },
          );
        }
      },
    );
    getlistofmarksandsubject(sem);
    return sem;
  }

  createstudentdropdown(BuildContext context, String labeltext, semesterlist,
      semester, bool bool, String errormessage, branchkey) {
    return Column(
      children: [
        Form(
          key: branchkey,
          child: DropDownTextField(
            onChanged: (value) {
              setState(() {
                marks.removeRange(0, marks.length);
                sum = 0;
                getsumofmarks(semester.dropDownValue!.name.toString());
              });
            },
            isEnabled: bool,
            dropDownList: semesterlist,
            validator: (value) {
              if (semester.dropDownValue == null) {
                return errormessage;
              } else if (semester.dropDownValue!.name.isEmpty) {
                return errormessage;
              } else {
                return null;
              }
            },
            controller: semester,
            dropDownItemCount: 5,
            dropdownRadius: 10,
            textFieldDecoration: InputDecoration(
              labelText: labeltext,
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  StreamBuilder getresultdetails(String semester) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(uType)
          .doc(uId)
          .collection(semester)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Data Not Available");
        }
        return Column(
          children: snapshot.data!.docs.map<Widget>(
            (snap) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          snap['Subject'],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          snap['Marks'],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      thickness: 2,
                      height: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }

  Future<List<double>> getsumofmarks(String semester) async {
    await FirebaseFirestore.instance
        .collection(uType)
        .doc(uId)
        .collection(semester)
        .get()
        .then(
      (QuerySnapshot snapshot) {
        snapshot.docs.forEach(
          (element) {
            setState(
              () {
                marks.add(double.parse(element['Marks']));
              },
            );
          },
        );
        SPI(marks);
      },
    );
    return marks;
  }

  double SPI(List<double> marks) {
    for (int i = 0; i < marks.length; i++) {
      setState(() {
        sum += marks[i];
      });
    }
    print(sum);
    average = (sum / marks.length) / 10;
    print(average);
    CPI(average, semester.dropDownValue!.name);
    return average;
  }

  double CPI(double average, String semester) {
    if (semester == '1') {
      setState(() {
        cpi = average;
      });
    } else {
      setState(() {
        getlatestcpi();
      });
    }
    return cpi;
  }

  Future getlatestcpi() async {
    FirebaseFirestore.instance
        .collection(uType)
        .doc(uId)
        .collection(semester.toString())
        .get()
        .then(
      (QuerySnapshot snapshot) {
        snapshot.docs.forEach((element) {
          setState(() {
            listofspi.add(
              element['CPI'],
            );
          });
        });
      },
    );
  }

  Future getlistofmarksandsubject(List<String> sem) async {
    double s = 0;
    int dl = 0;
    for (int i = 0; i <= sem.length - 1; i++) {
      print(sem[i]);
      await FirebaseFirestore.instance
          .collection(uType)
          .doc(uId)
          .collection(sem[i].toString())
          .get()
          .then(
        (QuerySnapshot snapshot) {
          snapshot.docs.forEach(
            (element) {
              setState(
                () {
                  s += double.parse(element['Marks']);
                },
              );
            },
          );
        },
      );
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(uType)
          .doc(uId)
          .collection(sem[i])
          .get();
      dl = querySnapshot.docs.length;
      setState(
        () {
          sumlist.add(s);
          s = 0;
          Subjectlength.add(dl.toString());
          dl = 0;
        },
      );
    }
    addSPI(sumlist, Subjectlength, sem);
    print(sumlist);
    print(Subjectlength);
  }

  Future addSPI(List<double> sumlist, List<String> Subjectlength,
      List<String> sem) async {
    for (int i = 0; i <= sem.length - 1; i++) {
      await FirebaseFirestore.instance.collection(uType).doc(uId).update(
        {
          'SPI' '${i + 1}':
              ((sumlist[i] / double.parse(Subjectlength[i])) / 10.0),
        },
      );
    }
    print('SPI added');
    getSPIlist();
  }

  Future getSPIlist() async {
    var spi= FirebaseFirestore.instance.collection(uType).doc(uId).snapshots();
    FutureBuilder(

      future: spi,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          for (int i = 0; i <= sem.length - 1; i++) {
            Map<String,dynamic> spi =
                snapshot.data!.data() as Map<String,dynamic>;
            SPIlist[i] += spi['SPI${i + 1}'] ;
            
          }
        }
        return Text("No Data Found");
      },
    );
    print(SPIlist);
    return SPIlist;
  }
}
