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
  List<DropDownValueModel> semesterlist = [];
  late SingleValueDropDownController semestercontroller;
  double sum = 0;
  double average = 0;
  @override
  void initState() {
    super.initState();
    getloginuserdata(uType, uId);
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
              showresultdata(semestercontroller),
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
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
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

  showresultdata(SingleValueDropDownController semestercontroller) {
    Map<String, dynamic> mapvalue =
        resultlist[(int.parse(semestercontroller.dropDownValue!.name) - 1)];
    print(mapvalue);

    List<Widget> rows = [];

    mapvalue.forEach(
      (key, value) {
        rows.add(
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    key,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
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
    );
    return Column(
      children: rows,
    );
  }
}
