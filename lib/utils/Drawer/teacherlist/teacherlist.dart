import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

class TeacherList extends StatefulWidget {
  const TeacherList({super.key});

  @override
  State<TeacherList> createState() => _TeacherListState();
}

class _TeacherListState extends State<TeacherList> {
  final branchkey = GlobalKey<FormState>();
  final semesterkey = GlobalKey<FormState>();
  List<String> branchnames = [];
  List<DropDownValueModel> bracnhlist = [];
  late SingleValueDropDownController branchname;
  // List<String> semesters = [];
  // List<DropDownValueModel> semesterlist = [];
  // late SingleValueDropDownController semester;
  bool validate1 = false;
  bool validate2 = false;
  @override
  void initState() {
    super.initState();
    getcourseslist();
    // getsemesterlist();
    branchname = SingleValueDropDownController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "TeacherList",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            createstudentdropdown(context, "Select Branch", bracnhlist,
                branchname, true, "Select Branch", branchkey, validate1),
            if (branchname.dropDownValue != null) getteacherlist(),
          ],
        ),
      ),
    );
  }

  Future getcourseslist() async {
    await FirebaseFirestore.instance.collection("Branch").get().then(
      (QuerySnapshot snapshot) {
        snapshot.docs.forEach(
          (element) {
            setState(
              () {
                branchnames.add(
                  element['Branch Name'],
                );
              },
            );
          },
        );
        for (int i = 0; i < branchnames.length; i++) {
          setState(
            () {
              bracnhlist.add(
                DropDownValueModel(
                  name: branchnames[i],
                  value: branchnames[i],
                ),
              );
            },
          );
        }
      },
    );
  }

  createstudentdropdown(
      BuildContext context,
      String errormessage,
      List<DropDownValueModel> list,
      SingleValueDropDownController controller,
      bool bool,
      String labeltext,
      GlobalKey<FormState> key,
      bool validate) {
    return Column(
      children: [
        Form(
          key: key,
          child: DropDownTextField(
            onChanged: (value) {
              if (validate == true) {
                validate = false;
              } else {
                validate = true;
              }
              if (branchname.dropDownValue != null) {
                // getsubjectlist();
                print(branchname.dropDownValue!.name);
                // print(semester.dropDownValue!.name);
              }
              setState(() {});
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
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  getteacherlist() {
    String firstname = '';
    String midlename = '';
    String lastname = '';
    String teacherid = '';
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Teacher').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Data Not Available");
        }
        return Column(
          children: snapshot.data!.docs.map<Widget>(
            (snap) {
              if (snap['Department'] == branchname.dropDownValue!.name) {
                firstname = snap['First Name'];
                midlename = snap['Midle Name'];
                lastname = snap['Last Name'];
                teacherid = snap['TID'];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => TeacherDetailsList(
                    //         teacherid: teacherid.toString(),
                    //       ),
                    //     ),
                    //   );
                    // },
                    child: TextFormField(
                      enabled: false,
                      initialValue: '$firstname $midlename $lastname',
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Text("No Teacher is in this Branch");
              }
            },
          ).toList(),
        );
      },
    );
  }
}
