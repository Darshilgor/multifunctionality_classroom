import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

class StudentsList extends StatefulWidget {
  const StudentsList({super.key});

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  final branchkey = GlobalKey<FormState>();
  final semesterkey = GlobalKey<FormState>();

  List<String> semesters = [];
  List<DropDownValueModel> semesterlist = [];
  late SingleValueDropDownController semester;
  List<String> branchnames = [];
  List<DropDownValueModel> bracnhlist = [];
  late SingleValueDropDownController branchname;
  bool validate1 = false;
  bool validate2 = false;
  @override
  void initState() {
    super.initState();
    getsemesterlist();
    getcourseslist();

    semester = SingleValueDropDownController();
    branchname = SingleValueDropDownController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Students List",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            createstudentdropdown(context, "Select Branch", bracnhlist,
                branchname, true, "Select Branch", branchkey, validate1),
            createstudentdropdown(context, "Select Semester", semesterlist,
                semester, true, "Select Semester", semesterkey, validate2),
            if (semester.dropDownValue != null &&
                branchname.dropDownValue != null)
              getteacherlist(),
          ],
        ),
      ),
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
              if (semester.dropDownValue != null) {
                // getsubjectlist();
                // print(branchname.dropDownValue!.name);
                print(semester.dropDownValue!.name);
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

  getteacherlist() {
    String firstname = '';
    String midlename = '';
    String lastname = '';
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Student').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Data Not Available");
        }
        return Column(
          children: snapshot.data!.docs.map<Widget>(
            (snap) {
              if (snap['Branch'] == branchname.dropDownValue!.name) {
                firstname = snap['First Name'];
                midlename = snap['Midle Name'];
                lastname = snap['Last Name'];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InkWell(
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
}
