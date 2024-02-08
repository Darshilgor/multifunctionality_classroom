import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/constant/constants.dart';
import 'package:my_app/utils/constant/getlist.dart';

class EnterResult extends StatefulWidget {
  final String title;
  const EnterResult({super.key, required this.title});

  @override
  State<EnterResult> createState() => _EnterResultState();
}

class _EnterResultState extends State<EnterResult> {
  int latestsemester = 0;
  bool visible = false;
  GetList getlist = GetList();
  late SingleValueDropDownController enrollment;
  late SingleValueDropDownController department;
  List<DropDownValueModel> list = [];
  List<String> subjectlist = [];
  late List<TextEditingController> marklist = [];
  int semester = 0;
  final createdepartmentkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    enrollment = SingleValueDropDownController();
    department = SingleValueDropDownController();
    // marklist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        child: Column(
          children: [
            createstudentdropdown(context, "Select Branch", department,
                createdepartmentkey, true, "Select Branch"),
            if (department.dropDownValue != null)
              getspecificbranchstudentlist(context, 'Select Student Enrollment',
                  enrollment, department, visible),
            // (spilist.length == 3)
            //     ? Text('Result is already entered...')
            buildlistviewbuilder(department, enrollment, subjectlist, marklist),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10,
              ),
              child: InkWell(
                onTap: () {
                  if (enrollment.dropDownValue != null) {
                    getlist.addsubjectresult(
                        enrollment.dropDownValue!.name.toString(),
                        semester.toString(),
                        subjectlist,
                        marklist);
                  }

                  Navigator.pop(context);
                  ScaffoldMessenger(
                    child: Text(
                      "Result enterd",
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            // buildlistview(),
          ],
        ),
      ),
    );
  }

  dropdownenrollmentlist(
    BuildContext context,
    String labeltext,
    List<DropDownValueModel> dropdownlist,
    SingleValueDropDownController controller,
    bool visible,
  ) {
    String studentid = '';
    return Column(
      children: [
        DropDownTextField(
          isEnabled: visible,
          dropDownList: dropdownlist,
          validator: (value) {
            if (enrollment.dropDownValue == null) {
              return "Select enrollment";
            } else if (enrollment.dropDownValue!.name.isEmpty) {
              return "Select enrollment";
            } else {
              return null;
            }
          },
          onChanged: (value) async {
            // getstudentdetails(enrollment),
            if (enrollment.dropDownValue != null) {
              // getstudentdetails(enrollment.dropDownValue!.name.toString());
              await FirebaseFirestore.instance
                  .collection('Student')
                  .doc(enrollment.dropDownValue!.name.toString())
                  .get()
                  .then(
                (value) {
                  setState(
                    () {
                      semester = value['Semester'];
                      studentid = value['Enrollment No'];
                      semester = semester - 1;
                    },
                  );
                },
              );
              subjectlist = await getlist.getlistsubjectlist(
                  department, semester, studentid);
              print('Semester$semester');
              print(subjectlist);
              marklist = List<TextEditingController>.generate(
                  subjectlist.length, (index) => TextEditingController());
              for (int i = 0; i < subjectlist.length; i++) {}
            }
            setState(() {});
          },
          controller: controller,
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
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  createstudentdropdown(
      BuildContext context,
      String errormessage,
      SingleValueDropDownController controller,
      GlobalKey<FormState> key,
      bool bool,
      String labeltext) {
    List<DropDownValueModel> list = [];
    return Column(
      children: [
        Form(
          key: key,
          child: FutureBuilder(
            future: getlist.getdepartmentlist(),
            builder: (context, future) {
              if (future.hasData) {
                list = future.data!;
                return DropDownTextField(
                  onChanged: (value) {
                    setState(() {
                      visible = true;
                      list = [];
                      enrollment.clearDropDown();
                    });
                    print(visible);
                    print(controller.dropDownValue!.name);
                  },
                  isEnabled: bool,
                  dropDownList: list,
                  validator: (value) {
                    if (controller.dropDownValue == null) {
                      return errormessage;
                    } else if (controller.dropDownValue!.name.isEmpty) {
                      return errormessage;
                    } else {
                      return null;
                    }
                  },
                  controller: controller,
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
              } else {
                return Center(
                  child: Text(
                    "Something went wrong",
                  ),
                );
              }
            },
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  getspecificbranchstudentlist(
      BuildContext context,
      String labeltext,
      SingleValueDropDownController controller,
      SingleValueDropDownController department,
      bool bool) {
    return Visibility(
      visible: bool,
      child: FutureBuilder(
        future: getlist.getspecificbranchstudent(department),
        builder: (context, future) {
          if (future.data != null) {
            print(future.data);
            list = future.data!;
            print('djlaf;jdskf;ljadsklfjda$list');
            // dropdownenrollmentlist(context, "Select student enrollment", list,
            //     enrollment, visible);
           return  dropdownenrollmentlist(context, "Select student enrollment", list,
                enrollment, visible);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildlistviewbuilder(
    SingleValueDropDownController department,
    SingleValueDropDownController enrollment,
    List<String> subjectlist,
    List<TextEditingController> marklist,
  ) {
    return Expanded(
      // height: MediaQuery.of(context).size.height * 0.75,
      child: ListView.builder(
        itemCount: marklist.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 15,
            ),
            child: TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                if (marklist[index].text.toString() == null) {
                  return 'Enter Marks';
                } else if (marklist[index].text.toString().isEmpty) {
                  return 'Enter Marks';
                } else {
                  return null;
                }
              },
              controller: marklist[index],
              decoration: InputDecoration(
                counterText: '',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 23,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                label: Text(subjectlist[index]),
                hintText: subjectlist[index],
                labelStyle: const TextStyle(fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }

  // Future getstudentdetails(String enrollment) async {
  //   await FirebaseFirestore.instance
  //       .collection('Student')
  //       .doc(enrollment)
  //       .get()
  //       .then(
  //     (DocumentSnapshot snapshot) {
  //       if (snapshot.exists) {
  //         for (int i = 1; i <= 8; i++) {
  //           if (snapshot['SPI$i'] == null) {
  //             latestsemester = i - 1;
  //             break;
  //           }
  //         }
  //       }
  //     },
  //   );
  //   return latestsemester;
  // }
}
