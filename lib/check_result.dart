import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/constant/constants.dart';
import 'package:my_app/utils/constant/getlist.dart';

class Check_Result extends StatefulWidget {
  const Check_Result({super.key});

  @override
  State<Check_Result> createState() => _Check_ResultState();
}

class _Check_ResultState extends State<Check_Result> {
  bool isnull = true;
  late TextEditingController controller;
  final semesterkey = GlobalKey<FormState>();
  List<String> semesters = [];
  List<DropDownValueModel> semesterlist = [];
  late SingleValueDropDownController semestercontroller;
  List<String> Subject = [];
  List<double> listofspi = [];
  List<String> sem = [];
  List<double> sumlist = [];
  List<String> Subjectlength = [];
  List<String> SPIlist = [];
  double sum = 0;
  double average = 0;
  double total = 0;
  double sumofspi = 0;
  int ssemester = 0;
  GetList getlist = GetList();
  @override
  void initState() {
    super.initState();
    semestercontroller = SingleValueDropDownController();
    controller = new TextEditingController(text: cpi.toString());
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
                semestercontroller, true, "Select Select", semesterkey),
            if (isnull == false && semestercontroller.dropDownValue != null)
              getresultdetails(
                  semestercontroller.dropDownValue!.name.toString()),
            SizedBox(
              height: 20,
            ),
            if (isnull == false)
              Column(
                children: [
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
                ],
              ),

            SizedBox(
              height: 20,
            ),
            if (semestercontroller.dropDownValue != null)
              if (int.parse(semestercontroller.dropDownValue!.name) ==
                  (semester - 1))
                Column(
                  children: [
                    // calculatecpi(),
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
                        readOnly: true,
                        controller: controller,
                      ),
                    ),
                  ],
                ),

            // showcpi(),
          ],
        ),
      ),
    );
  }

  createstudentdropdown(
      BuildContext context,
      String labeltext,
      List<DropDownValueModel> semesterlist,
      SingleValueDropDownController semester,
      bool bool,
      String errormessage,
      GlobalKey<FormState> branchkey) {
    List<DropDownValueModel>? list = [];
    return Column(
      children: [
        Form(
          key: branchkey,
          child: FutureBuilder(
            future: getlist.getsemesterlistforresult(),
            builder: (context, future) {
              if (future.hasData) {
                list = future.data;
                return DropDownTextField(
                  onChanged: (value) async {
                    if (semestercontroller.dropDownValue == null) {
                      setState(() {
                        isnull = true;
                      });
                    } else
                      sum = 0;
                    if (semestercontroller.dropDownValue != null) {
                      setState(() {
                        isnull = false;
                      });
                      List<dynamic> marks = [];

                      await FirebaseFirestore.instance
                          .collection(uType)
                          .doc(uId)
                          .collection(
                              semestercontroller.dropDownValue!.name.toString())
                          .get()
                          .then(
                        (QuerySnapshot snapshot) {
                          snapshot.docs.forEach(
                            (element) {
                              setState(
                                () {
                                  if (element['Marks'] != null &&
                                      (element['Marks'] is int ||
                                          element['Marks'] is double)) {
                                    marks.add(element['Marks']);
                                  }
                                },
                              );
                            },
                          );
                          SPI(marks);
                        },
                      );
                      print('Marks list is in checkresult is ${marks}');
                      // getsumofmarks(
                      //     semestercontroller.dropDownValue!.name.toString());
                    }
                  },
                  isEnabled: bool,
                  dropDownList: list!,
                  validator: (value) {
                    if (semester.dropDownValue == null) {
                      return errormessage;
                    } else if (semester.dropDownValue!.name.isEmpty) {
                      return errormessage;
                    } else {
                      return null;
                    }
                  },
                  controller: semestercontroller,
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
                );
              }
              return Text("data");
            },
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
          return Center(
            child: CircularProgressIndicator(),
          );
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
                          snap['Marks'].toString(),
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

  Future<List<dynamic>> getsumofmarks(String semester) async {
    List<dynamic> marks = [];

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
                if (element['Marks'] != null &&
                    (element['Marks'] is int || element['Marks'] is double)) {
                  marks.add(element['Marks']);
                }
              },
            );
          },
        );
        SPI(marks);
      },
    );
    print('Marks list is in checkresult is ${marks}');
    return marks;
  }

  double SPI(List<dynamic> marks) {
    for (int i = 0; i < marks.length; i++) {
      setState(() {
        sum += marks[i];
      });
    }
    average = (sum / marks.length) / 10;
    return average;
  }
//this is for when we add marks then calculate spi autometic.

  // Future addSPI(List<double> sumlist, List<String> Subjectlength,
  //     List<String> sem) async {
  //   for (int i = 0; i <= sem.length - 1; i++) {
  //     await FirebaseFirestore.instance.collection(uType).doc(uId).update(
  //       {
  //         'SPI' '${i + 1}':
  //             ((sumlist[i] / double.parse(Subjectlength[i])) / 10.0),
  //       },
  //     );
  //   }
  //   print('SPI added');
  //   print("Calculate sumofcpi");
  //   // addcpi();
  // }

  // Future addcpi() async {
  //   for (int i = 1; i <= ssemester; i++) {
  //     await FirebaseFirestore.instance.collection(uType).doc(uId).get().then(
  //       (value) {
  //         sumofspi += value['SPI$i'];
  //       },
  //     );
  //   }
  //   print(sumofspi);
  //   CPI = sumofspi / ssemester;
  //   await FirebaseFirestore.instance.collection(uType).doc(uId).update(
  //     {
  //       'CPI': CPI,
  //     },
  //   );
  //   print("finally CPI added");
  // }
}
