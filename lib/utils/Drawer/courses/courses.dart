import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  final branchkey = GlobalKey<FormState>();
  final semesterkey = GlobalKey<FormState>();
  List<String> branchnames = [];
  List<DropDownValueModel> bracnhlist = [];
  late SingleValueDropDownController branchname;
  List<String> semesters = [];
  List<DropDownValueModel> semesterlist = [];
  late SingleValueDropDownController semester;
  bool validate1 = false;
  bool validate2 = false;
  @override
  void initState() {
    super.initState();
    getcourseslist();
    getsemesterlist();
    branchname = SingleValueDropDownController();
    semester = SingleValueDropDownController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Courses"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            createstudentdropdown(context, "Select Branch", bracnhlist,
                branchname, true, "Select Branch", branchkey, validate1),
            createstudentdropdown(context, "Select Semester", semesterlist,
                semester, true, "Select Semester", semesterkey, validate2),
            if (branchname.dropDownValue != null &&
                semester.dropDownValue != null)
              getsubjectlist(
                  semester.dropDownValue!.name, branchname.dropDownValue!.name),
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

  Future getsemesterlist() async {
    await FirebaseFirestore.instance.collection("Semester").get().then(
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
            print(semesters);
          },
        );
        for (int i = 0; i < semesters.length; i++) {
          setState(
            () {
              semesterlist.add(
                DropDownValueModel(
                  name: semesters[i],
                  value: semesters[i],
                ),
              );
            },
          );
        }
      },
    );
  }

  StreamBuilder getsubjectlist(String sem, String branch) {
    return StreamBuilder(
      key: Key(branchname.dropDownValue!.name + semester.dropDownValue!.name),
      stream: FirebaseFirestore.instance
          .collection("Branch")
          .doc(branch)
          .collection(sem)
          .orderBy('Subject', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Data");
        } else {
          return Column(
            children: snapshot.data!.docs.map<Widget>(
              (snap) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    onTap: () async {
                      print("OnTapped");
                      final Uri _url = Uri.parse(
                        snap['Link'],
                      );
                      await _launchUrl(_url);
                    },
                    child: TextFormField(
                      enabled: false,
                      initialValue: snap['Subject'],
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
              },
            ).toList(),
          );
        }
      },
    );
  }

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_url');
    }
    // if (canLaunchUrl(_url)) {
    //   await launchUrl(_url);
    // }
  }
}
