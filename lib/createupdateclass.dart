import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:my_app/adminpage.dart';

class CreateUpdateClass extends StatefulWidget {
  final String title;
  const CreateUpdateClass({super.key, required this.title});

  @override
  State<CreateUpdateClass> createState() => _CreateUpdateClassState();
}

class _CreateUpdateClassState extends State<CreateUpdateClass> {
  bool visibility = false;

//use variable to getting value from database
  String branchnamevalue = '';
  String semestervalue = '';
  String startingyearvalue = '';
  String endingyearvalue = '';
  String mentorvalue = '';

//use for validate textformfield is empty or not
  bool validated = true;

//different textformfield form key
  final loginformkey = GlobalKey<FormState>();
  final classnametextkey = GlobalKey<FormState>();
  final classnamedropkey = GlobalKey<FormState>();
  final branchnamekey = GlobalKey<FormState>();
  final semesterkey = GlobalKey<FormState>();
  final startingyearkey = GlobalKey<FormState>();
  final endingyearkey = GlobalKey<FormState>();
  final mentorkey = GlobalKey<FormState>();

  final String collectionvalue = 'Classes';

  TextEditingController classnamecontroller = new TextEditingController();

//for branch dropdowntextfield
  List<String> branchnames = [];
  List<DropDownValueModel> branchnamelist = [];
  late SingleValueDropDownController branchname;

//for semester dropdowntextfield
  List<String> semesters = [];
  List<DropDownValueModel> Semesterlist = [];
  late SingleValueDropDownController semester;

  TextEditingController startingyear =
      new TextEditingController(); //starting year textformfield controller
  TextEditingController endingyear =
      new TextEditingController(); //ending year textformfield controller

//for mentor dropdowntextfield
  List<DropDownValueModel> mentorlist = [];
  late SingleValueDropDownController mentorname;
  List<String> mentorfirstname = [];
  List<String> mentormidlename = [];
  List<String> mentorlastname = [];

//for classname dropdowntextfield
  List<String> classnames = [];
  List<DropDownValueModel> classnamelist = [];
  late SingleValueDropDownController classname;
  String tempclassname = '';

  @override
  void initState() {
    super.initState();
    branchname = SingleValueDropDownController();
    semester = SingleValueDropDownController();
    mentorname = SingleValueDropDownController();
    classname = SingleValueDropDownController();
    getcoursenamelist(); //getting course list
    getsemesternamelist(); //getting semester list
    getmentorlist(); //getting mentor list
    getclassnamelist(); //getting class list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: loginformkey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  if (widget.title == 'Create Class')
                    //textformfield for enter classname in create class
                    Form(
                      key: classnametextkey,
                      child: Column(
                        children: [
                          classnametextformfield(),
                        ],
                      ),
                    ),
                  if (widget.title == 'Update Class')
                    //dropdowntextformfield for select classname in update class
                    Form(
                      key: classnamedropkey,
                      child: Column(
                        children: [
                          classnamedropdownmenu(context, "Select class name",
                              classnamelist, classname, true),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 15,
                  ),
                  Form(
                    child: Column(
                      children: [
                        if (widget.title == 'Create Class')
                          //dropdowntextformfield for select branch in create clss
                          Form(
                            key: branchnamekey,
                            child: Column(
                              children: [
                                dropdowntextfield(context, "Select Branch",
                                    branchnamelist, branchname, true),
                              ],
                            ),
                          ),
                        Visibility(
                          visible: visibility,
                          //dropdowntextformfield for select branch in update class
                          child: Form(
                            key: branchnamekey,
                            child: Column(
                              children: [
                                dropdowntextfield(context, "Select Branch",
                                    branchnamelist, branchname, true),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        if (widget.title == 'Create Class')
                          //dorpdowntextfromfield for select semester in create class
                          Form(
                            key: semesterkey,
                            child: Column(
                              children: [
                                dropdowntextfield(context, "Select Semester",
                                    Semesterlist, semester, true),
                              ],
                            ),
                          ),
                        //dropdowntextformfield for select semester in update class
                        Visibility(
                          visible: visibility,
                          child: Form(
                            key: semesterkey,
                            child: Column(
                              children: [
                                dropdowntextfield(context, "Select Semester",
                                    Semesterlist, semester, true),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        if (widget.title == 'Create Class')
                          //textformfield for enter staring year in create class
                          Form(
                            key: startingyearkey,
                            child: Column(
                              children: [
                                textformfield(
                                    context,
                                    startingyear,
                                    "Staring Year",
                                    "Starting Year",
                                    "Please enter the starting year"),
                              ],
                            ),
                          ),
                        //textformfield for enter staring year in update class
                        Visibility(
                          visible: visibility,
                          child: Form(
                            key: startingyearkey,
                            child: Column(
                              children: [
                                textformfield(
                                    context,
                                    startingyear,
                                    "Staring Year",
                                    "Starting Year",
                                    "Please enter the starting year"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        if (widget.title == 'Create Class')
                          //textformfield for enter ending year in create class
                          Form(
                            key: endingyearkey,
                            child: Column(
                              children: [
                                textformfield(
                                    context,
                                    endingyear,
                                    "Ending Year",
                                    "Ending Year",
                                    "Please enter the ending year"),
                              ],
                            ),
                          ),
                        //textformfield for enter ending year in update class
                        Visibility(
                          visible: visibility,
                          child: Form(
                            key: endingyearkey,
                            child: Column(
                              children: [
                                textformfield(
                                    context,
                                    endingyear,
                                    "Ending Year",
                                    "Ending Year",
                                    "Please enter the ending year"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        if (widget.title == 'Create Class')
                          //dropdowntextformfield for select mentor in crete class
                          Form(
                            key: mentorkey,
                            child: Column(
                              children: [
                                dropdowntextfield(context, "Select Mentor",
                                    mentorlist, mentorname, true),
                              ],
                            ),
                          ),
                        //dropdowntextformfield for select mentor in update class
                        Visibility(
                          visible: visibility,
                          child: Form(
                            key: mentorkey,
                            child: Column(
                              children: [
                                dropdowntextfield(context, "Select Mentor",
                                    mentorlist, mentorname, true),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        if (widget.title == 'Create Class')
                          clearsubmitbutton(), //clear submit button in create class
                        Visibility(
                          visible: visibility,
                          child: Column(
                            children: [
                              if (widget.title == 'Update Class')
                                cleardeletesubmitbutton(), //clear delete update button in update class
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

//create textformfield method
  textformfield(BuildContext context, TextEditingController controller,
      String hinttext, String label, String validatortext) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please fill the detail";
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 23,
        ),
        floatingLabelStyle: TextStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        label: Text(
          label.toString(),
        ),
        hintText: hinttext,
        labelStyle: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

//get courselist method
  Future getcoursenamelist() async {
    await FirebaseFirestore.instance.collection("Branch").get().then(
      (QuerySnapshot querysnapshot) {
        querysnapshot.docs.forEach(
          (element) {
            setState(
              () {
                branchnames.add(
                  element["Branch Name"],
                );
              },
            );
          },
        );
        for (int i = 0; i < branchnames.length; i++) {
          setState(() {
            branchnamelist.add(DropDownValueModel(
              name: '${branchnames[i]}',
              value: '${branchnames[i]}',
            ));
          });
        }
      },
    );
  }

//create dropdowntextformfield method
  dropdowntextfield(
      BuildContext context,
      String labeltext,
      List<DropDownValueModel> branchnamelist,
      SingleValueDropDownController name,
      bool controller) {
    return Column(
      children: [
        DropDownTextField(
          validator: (value) {
            if (name.dropDownValue == null) {
              return "Please fill the detail";
            } else if (name.dropDownValue!.name.isEmpty) {
              return "Please fill the detail";
            } else {
              return null;
            }
          },
          isEnabled: controller,
          controller: name,
          dropDownList: branchnamelist,
          dropDownItemCount: 6,
          dropdownRadius: 10,
          textFieldDecoration: InputDecoration(
            labelText: labeltext.toString(),
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
      ],
    );
  }

//get semester list method
  Future getsemesternamelist() async {
    await FirebaseFirestore.instance.collection("Semester").get().then(
      (QuerySnapshot querysnapshot) {
        querysnapshot.docs.forEach(
          (element) {
            setState(
              () {
                semesters.add(
                  element['Semester'],
                );
              },
            );
          },
        );
        for (int i = 0; i < semesters.length; i++) {
          setState(() {
            Semesterlist.add(
              DropDownValueModel(
                name: '${semesters[i]}',
                value: '${semesters[i]}',
              ),
            );
          });
        }
      },
    );
  }

//get mentor list method
  Future getmentorlist() async {
    await FirebaseFirestore.instance.collection("Teacher").get().then(
      (QuerySnapshot querysnapshot) {
        querysnapshot.docs.forEach(
          (element) {
            setState(
              () {
                mentorfirstname.add(
                  element['First Name'],
                );
                mentormidlename.add(
                  element['Midle Name'],
                );
                mentorlastname.add(
                  element['Last Name'],
                );
              },
            );
          },
        );
        for (int i = 0; i < mentorfirstname.length; i++) {
          setState(() {
            mentorlist.add(
              DropDownValueModel(
                name: '${mentorfirstname[i]}'
                    ' '
                    '${mentormidlename[i]}'
                    ' '
                    '${mentorlastname[i]}',
                value: '${mentorfirstname[i]}'
                    ' '
                    '${mentormidlename[i]}'
                    ' '
                    '${mentorlastname[i]}',
              ),
            );
          });
        }
      },
    );
  }

//button design method
  button(BuildContext context, String labeltext) {
    return ElevatedButton(
      onPressed: () {
        if (labeltext == 'Clear')
          clear();
        else if (labeltext == 'Delete') {
          deleteclass();
        } else if (labeltext == 'Update') {
          updateclassdetails(context);
        } else {
          submit(context, classnamecontroller.text.toString());
        }
      },
      child: Container(
        width: 100,
        height: 60,
        child: Center(
          child: Text(
            labeltext,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

//clear data method
  Future clear() async {
    setState(
      () {
        classnamecontroller.clear();
        branchname.clearDropDown();
        semester.clearDropDown();
        startingyear.clear();
        endingyear.clear();
        mentorname.clearDropDown();
      },
    );
  }

//submit process method
  Future submit(context, String id) async {
    if (classnametextkey.currentState!.validate() &&
        branchnamekey.currentState!.validate() &&
        semesterkey.currentState!.validate() &&
        startingyearkey.currentState!.validate() &&
        endingyearkey.currentState!.validate() &&
        mentorkey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection(collectionvalue).doc(id).set(
        {
          'Class Name': id,
          'Branch': branchname.dropDownValue!.name.toString(),
          'Semester': semester.dropDownValue!.name.toString(),
          'Starting Year': startingyear.text.toString(),
          'Ending Year': endingyear.text.toString(),
          'Mentor': mentorname.dropDownValue!.name.toString(),
        },
      ).then(
        (value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminPage(),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Class Created"),
            ),
          );
        },
      );
    }
  }

//textfromfield method of classname
  classnametextformfield() {
    return textformfield(context, classnamecontroller, "Class Name",
        "Class Name", "Please enter the class name");
  }

//dropdowntextfield method of classname
  classnamedropdownmenu(
    BuildContext context,
    String labeltext,
    List<DropDownValueModel> classnamelist,
    SingleValueDropDownController controller,
    bool bool,
  ) {
    return Column(
      children: [
        DropDownTextField(
          onChanged: (value) async {
            visibility = true;

            if (classname.dropDownValue != null) {
              print(
                classname.dropDownValue!.name.toString(),
              );
              await getclassdetail(
                  classname.dropDownValue!.name.toString()); //get class details
            }
            //set controller value for intial value
            branchname.setDropDown(
              DropDownValueModel(
                name: branchnamevalue.toString(),
                value: branchnamevalue.toString(),
              ),
            );
            semester.setDropDown(
              DropDownValueModel(
                name: semestervalue.toString(),
                value: semestervalue.toString(),
              ),
            );
            mentorname.setDropDown(
              DropDownValueModel(
                name: mentorvalue.toString(),
                value: mentorvalue.toString(),
              ),
            );
            startingyear.text = startingyearvalue;
            endingyear.text = endingyearvalue;

            setState(() {});
          },
          validator: (value) {
            if (classname.dropDownValue!.name.toString() == null) {
              return "Please fill the detail";
            } else if (classname.dropDownValue!.name.isEmpty) {
              return "Please fill the detail";
            } else {
              return null;
            }
          },
          isEnabled: bool,
          controller: controller,
          dropDownList: classnamelist,
          dropDownItemCount: 10,
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
      ],
    );
  }

//get class list method
  Future getclassnamelist() async {
    await FirebaseFirestore.instance.collection(collectionvalue).get().then(
      (QuerySnapshot querysnapshot) {
        querysnapshot.docs.forEach(
          (element) {
            setState(() {
              classnames.add(
                element['Class Name'],
              );
            });
          },
        );
        for (int i = 0; i < classnames.length; i++) {
          setState(() {
            classnamelist.add(
              DropDownValueModel(
                name: classnames[i],
                value: classnames[i],
              ),
            );
          });
        }
      },
    );
  }

//method of update class details
  Future updateclassdetails(BuildContext context) async {
    if (classnamedropkey.currentState!.validate() &&
        branchnamekey.currentState!.validate() &&
        semesterkey.currentState!.validate() &&
        startingyearkey.currentState!.validate() &&
        endingyearkey.currentState!.validate() &&
        mentorkey.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection(collectionvalue)
          .doc(classname.dropDownValue!.name.toString())
          .get()
          .then(
        (snapshot) {
          if (snapshot.exists) {
            FirebaseFirestore.instance
                .collection(collectionvalue)
                .doc(classname.dropDownValue!.name.toString())
                .update(
              {
                'Branch': branchname.dropDownValue!.name.toString(),
                'Ending Year': endingyear.text.toString(),
                'Mentor': mentorname.dropDownValue!.name.toString(),
                'Semester': semester.dropDownValue!.name.toString(),
                'Starting Year': startingyear.text.toString(),
              },
            );
          }
          ;
        },
      ).whenComplete(
        () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Class Updated"),
            ),
          );
        },
      );
    }
  }

//delete class method
  Future deleteclass() async {
    if (classnamedropkey.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection("Classes")
          .doc(classname.dropDownValue!.name.toString())
          .delete()
          .whenComplete(
        () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Class Deleted"),
            ),
          );
        },
      );
    }
  }

//clear submit button method
  clearsubmitbutton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        button(context, "Clear"),
        SizedBox(
          width: 50,
        ),
        button(context, "Submit"),
      ],
    );
  }

//clear submit update button method
  cleardeletesubmitbutton() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            button(context, "Clear"),
            SizedBox(
              width: 50,
            ),
            button(context, "Delete"),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            button(context, "Update"),
          ],
        )
      ],
    );
  }

//get class details method
  Future getclassdetail(String id) async {
    await FirebaseFirestore.instance.collection("Classes").doc(id).get().then(
      (value) {
        if (value.exists) {
          setState(
            () {
              branchnamevalue = value.data()!['Branch'];
              semestervalue = value.data()!['Semester'];
              startingyearvalue = value.data()!['Starting Year'];
              endingyearvalue = value.data()!['Ending Year'];
              mentorvalue = value.data()!['Mentor'];
            },
          );
        }
      },
    );
  }

  setdropdown() {
    if (visibility) {
      setState(() {
        classname.setDropDown(
          DropDownValueModel(
            name: branchnamevalue.toString(),
            value: branchnamevalue.toString(),
          ),
        );
      });
    }
  }
}
