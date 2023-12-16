import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/Admin/adminpage.dart';
import 'package:my_app/utils/constant/getlist.dart';

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
  final createclassnamekey = GlobalKey<FormState>();
  final updateclassnamekey = GlobalKey<FormState>();
  final createbranchnamekey = GlobalKey<FormState>();
  final updatebranchnamekey = GlobalKey<FormState>();
  final creatementornamekey = GlobalKey<FormState>();
  final updatementornamekey = GlobalKey<FormState>();

  final String collectionvalue = 'Classes';

  TextEditingController classnamecontroller = TextEditingController();

//for branch dropdowntextfield
  // List<String> branchnames = [];
  // List<DropDownValueModel> branchnamelist = [];
  late SingleValueDropDownController branchname;

//for semester dropdowntextfield
  // List<String> semesters = [];
  // List<DropDownValueModel> Semesterlist = [];
  late SingleValueDropDownController semester;

  // TextEditingController startingyear =
  //     new TextEditingController(); //starting year textformfield controller
  // TextEditingController endingyear =
  //     new TextEditingController(); //ending year textformfield controller

//for mentor dropdowntextfield
  late SingleValueDropDownController mentorname;
  // List<String> mentorfirstname = [];
  // List<String> mentormidlename = [];
  // List<String> mentorlastname = [];

//for classname dropdowntextfield

  late SingleValueDropDownController classname;
  // String tempclassname = '';

  GetList getlist = GetList();

  @override
  void initState() {
    super.initState();

    // getlist.getsemesterlist();
    // getlist.getmentorlist();
    branchname = SingleValueDropDownController();
    semester = SingleValueDropDownController();
    mentorname = SingleValueDropDownController();
    classname = SingleValueDropDownController();
    print("ghfhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    // getcoursenamelist(); //getting course list
    // getsemesternamelist(); //getting semester list
    // getmentorlist(); //getting mentor list
    // getclassnamelist(); //getting class list
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                if (widget.title == 'Create Class')
                  //textformfield for enter classname in create class
                  Form(
                    key: createclassnamekey,
                    child: textformfield(
                        context,
                        classnamecontroller,
                        "Class Name",
                        "Class Name",
                        "Please enter the class name"),
                  ),
                if (widget.title == 'Update Class')
                  Form(
                    key: updatebranchnamekey,
                    child: dropdowntextfield(
                        context, "Select Branch", branchname, true),
                  ),
                SizedBox(
                  height: 15,
                ),
                if (branchname.dropDownValue != null)
                  Text(branchname.dropDownValue!.name),
                if (widget.title == 'Update Class' &&
                    branchname.dropDownValue != null)

                  // dropdowntextformfield for select classname in update class
                  Form(
                    key: updateclassnamekey,
                    child: classnamedropdownmenu(
                        context, "Select class name", classname, true),
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
                          key: createbranchnamekey,
                          child: Column(
                            children: [
                              dropdowntextfield(
                                  context, "Select Branch", branchname, true),
                            ],
                          ),
                        ),
                      // Visibility(
                      //   visible: visibility,
                      //   //dropdowntextformfield for select branch in update class
                      //   child: Form(
                      //     key: branchnamekey,
                      //     child: Column(
                      //       children: [
                      //         dropdowntextfield(context, "Select Branch",
                      //             branchnamelist, branchname, true),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 15,
                      ),
                      // if (widget.title == 'Create Class')
                      //   //dorpdowntextfromfield for select semester in create class
                      //   Form(
                      //     key: semesterkey,
                      //     child: Column(
                      //       children: [
                      //         dropdowntextfield(
                      //             context, "Select Semester", semester, true),
                      //       ],
                      //     ),
                      //   ),
                      //dropdowntextformfield for select semester in update class
                      // Visibility(
                      //   visible: visibility,
                      //   child: Form(
                      //     key: semesterkey,
                      //     child: Column(
                      //       children: [
                      //         dropdowntextfield(context, "Select Semester",
                      //             Semesterlist, semester, true),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // if (widget.title == 'Create Class')
                      //   //textformfield for enter staring year in create class
                      //   Form(
                      //     key: startingyearkey,
                      //     child: Column(
                      //       children: [
                      //         textformfield(
                      //             context,
                      //             startingyear,
                      //             "Staring Year",
                      //             "Starting Year",
                      //             "Please enter the starting year"),
                      //       ],
                      //     ),
                      //   ),
                      // //textformfield for enter staring year in update class
                      // Visibility(
                      //   visible: visibility,
                      //   child: Form(
                      //     key: startingyearkey,
                      //     child: Column(
                      //       children: [
                      //         textformfield(
                      //             context,
                      //             startingyear,
                      //             "Staring Year",
                      //             "Starting Year",
                      //             "Please enter the starting year"),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // if (widget.title == 'Create Class')
                      //   //textformfield for enter ending year in create class
                      //   Form(
                      //     key: endingyearkey,
                      //     child: Column(
                      //       children: [
                      //         textformfield(
                      //             context,
                      //             endingyear,
                      //             "Ending Year",
                      //             "Ending Year",
                      //             "Please enter the ending year"),
                      //       ],
                      //     ),
                      //   ),
                      // //textformfield for enter ending year in update class
                      // Visibility(
                      //   visible: visibility,
                      //   child: Form(
                      //     key: endingyearkey,
                      //     child: Column(
                      //       children: [
                      //         textformfield(
                      //             context,
                      //             endingyear,
                      //             "Ending Year",
                      //             "Ending Year",
                      //             "Please enter the ending year"),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 15,
                      ),
                      if (widget.title == 'Create Class')
                        //dropdowntextformfield for select mentor in crete class
                        Form(
                          key: creatementornamekey,
                          child: Column(
                            children: [
                              dropdowntextfield(
                                  context, "Select Mentor", mentorname, true),
                            ],
                          ),
                        ),
                      // dropdowntextformfield for select mentor in update class
                      Form(
                        key: updatementornamekey,
                        child: Visibility(
                          visible: visibility,
                          child: dropdowntextfield(
                              context, "Select Mentor", mentorname, true),
                        ),
                      ),
                      if (mentorname.dropDownValue != null)
                        Text(mentorname.dropDownValue!.name),
                      SizedBox(
                        height: 25,
                      ),
                      if (widget.title == 'Create Class' &&
                          classnamecontroller.text.toString() != null &&
                          branchname.dropDownValue != null &&
                          mentorname.dropDownValue != null)
                        clearsubmitbutton(
                            classnamecontroller.text.toString(),
                            branchname.dropDownValue!.name,
                            mentorname.dropDownValue!
                                .name), //clear submit button in create class
                      Visibility(
                        visible: visibility,
                        child: (widget.title == 'Update Class' &&
                                classname.dropDownValue != null &&
                                branchname.dropDownValue != null &&
                                mentorname.dropDownValue != null)
                            ? cleardeletesubmitbutton(
                                branchname.dropDownValue!.name,
                                classname.dropDownValue!.name,
                                mentorname.dropDownValue!.name)
                            : Text('Something went wrong'),
                      )
                    ],
                  ),
                ),
              ],
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
  // Future getcoursenamelist() async {
  //   await FirebaseFirestore.instance.collection("Branch").get().then(
  //     (QuerySnapshot querysnapshot) {
  //       querysnapshot.docs.forEach(
  //         (element) {
  //           setState(
  //             () {
  //               branchnames.add(
  //                 element["Branch Name"],
  //               );
  //             },
  //           );
  //         },
  //       );
  //       for (int i = 0; i < branchnames.length; i++) {
  //         setState(() {
  //           branchnamelist.add(DropDownValueModel(
  //             name: '${branchnames[i]}',
  //             value: '${branchnames[i]}',
  //           ));
  //         });
  //       }
  //     },
  //   );
  // }

//create dropdowntextformfield method
  dropdowntextfield(BuildContext context, String labeltext,
      SingleValueDropDownController name, bool controller) {
    List<DropDownValueModel> list = [];
    return FutureBuilder(
      future: (labeltext == 'Select Branch')
          ? getlist.getdepartmentlist()
          : (labeltext == 'Select Semester')
              ? getlist.getsemesterlist()
              : getlist.getmentorlist('Teacher'),
      builder: (context, future) {
        if (future.hasData) {
          print(future.data);
          list = future.data!;
          return DropDownTextField(
            // initialValue: (labeltext == 'Select Mentor') ? mentorvalue : '',
            validator: (value) {
              if (name.dropDownValue == null) {
                return "Please fill the detail";
              } else if (name.dropDownValue!.name.isEmpty) {
                return "Please fill the detail";
              } else {
                return null;
              }
            },
            onChanged: (value) {
              setState(() {
                print(
                    'Branch Name${branchname.dropDownValue!.name.toString()}');
              });
              setState(() {});
            },
            isEnabled: controller,
            controller: name,
            dropDownList: list,
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
          );
        }
        return Text(list.toString());
      },
    );
  }

//get semester list method
  // Future getsemesternamelist() async {
  //   await FirebaseFirestore.instance.collection("Semester").get().then(
  //     (QuerySnapshot querysnapshot) {
  //       querysnapshot.docs.forEach(
  //         (element) {
  //           setState(
  //             () {
  //               semesters.add(
  //                 element['Semester'],
  //               );
  //             },
  //           );
  //         },
  //       );
  //       for (int i = 0; i < semesters.length; i++) {
  //         setState(() {
  //           Semesterlist.add(
  //             DropDownValueModel(
  //               name: '${semesters[i]}',
  //               value: '${semesters[i]}',
  //             ),
  //           );
  //         });
  //       }
  //     },
  //   );
  // }

//get mentor list method
  // Future getmentorlist() async {
  //   await FirebaseFirestore.instance.collection("Teacher").get().then(
  //     (QuerySnapshot querysnapshot) {
  //       querysnapshot.docs.forEach(
  //         (element) {
  //           setState(
  //             () {
  //               mentorfirstname.add(
  //                 element['First Name'],
  //               );
  //               mentormidlename.add(
  //                 element['Midle Name'],
  //               );
  //               mentorlastname.add(
  //                 element['Last Name'],
  //               );
  //             },
  //           );
  //         },
  //       );
  //       for (int i = 0; i < mentorfirstname.length; i++) {
  //         setState(() {
  //           mentorlist.add(
  //             DropDownValueModel(
  //               name: '${mentorfirstname[i]}'
  //                   ' '
  //                   '${mentormidlename[i]}'
  //                   ' '
  //                   '${mentorlastname[i]}',
  //               value: '${mentorfirstname[i]}'
  //                   ' '
  //                   '${mentormidlename[i]}'
  //                   ' '
  //                   '${mentorlastname[i]}',
  //             ),
  //           );
  //         });
  //       }
  //     },
  //   );
  // }

//button design method
  button(BuildContext context, String labeltext, String branchname,
      String classname, String mentorname) {
    return ElevatedButton(
      onPressed: () {
        if (labeltext == 'Clear')
          clear();
        else if (labeltext == 'Delete') {
          deleteclass(context, branchname, classname);
        } else if (labeltext == 'Update') {
          updateclassdetails(context, branchname, classname, mentorname);
        } else {
          submit(context, classname, branchname, mentorname);
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
        mentorname.clearDropDown();
      },
    );
  }

//submit process method
  Future submit(
      context, String id, String branchname, String mentorname) async {
    if (createclassnamekey.currentState!.validate() &&
        createbranchnamekey.currentState!.validate() &&
        creatementornamekey.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection('Branch')
          .doc(branchname)
          .collection('Classes')
          .doc(id)
          .set(
        {
          'Class Name': id,
          'Branch': branchname,
          'Mentor': mentorname,
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
    SingleValueDropDownController controller,
    bool bool,
  ) {
    List<DropDownValueModel>? list = [];
    return Column(
      children: [
        FutureBuilder(
          future:
              getlist.getclasslist(branchname.dropDownValue!.name.toString()),
          builder: (context, future) {
            if (future.hasData) {
              list = future.data;
              return DropDownTextField(
                onChanged: (value) async {
                  visibility = true;
                  setState(() {
                    print(classname.dropDownValue!.name);
                  });
                  if (classname.dropDownValue != null &&
                      branchname.dropDownValue != null) {
                    setState(() {
                      print(classname.dropDownValue!.name.toString());
                      getclassdetail(
                          classname.dropDownValue, branchname.dropDownValue);
                      // get class details
                      print('Mentor Name Is$mentorvalue');
                    });
                  }
                  //set controller value for intial value
                  // branchname.setDropDown(
                  //   DropDownValueModel(
                  //     name: branchnamevalue.toString(),
                  //     value: branchnamevalue.toString(),
                  //   ),
                  // );
                  // semester.setDropDown(
                  //   DropDownValueModel(
                  //     name: semestervalue.toString(),
                  //     value: semestervalue.toString(),
                  //   ),
                  // );
                  mentorname.setDropDown(
                    DropDownValueModel(
                      name: mentorvalue.toString(),
                      value: mentorvalue.toString(),
                    ),
                  );
                  // startingyear.text = startingyearvalue;
                  // endingyear.text = endingyearvalue;

                  setState(() {});
                },
                validator: (value) {
                  if (classname.dropDownValue!.name.isEmpty) {
                    return "Please fill the detail";
                  } else {
                    return null;
                  }
                },
                isEnabled: bool,
                controller: controller,
                dropDownList: list!,
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
              );
            }
            return Text('Class is selected in update method');
          },
        ),
      ],
    );
  }

//get class list method
  // Future getclassnamelist() async {
  //   await FirebaseFirestore.instance.collection(collectionvalue).get().then(
  //     (QuerySnapshot querysnapshot) {
  //       querysnapshot.docs.forEach(
  //         (element) {
  //           setState(() {
  //             classnames.add(
  //               element['Class Name'],
  //             );
  //           });
  //         },
  //       );
  //       for (int i = 0; i < classnames.length; i++) {
  //         setState(() {
  //           classnamelist.add(
  //             DropDownValueModel(
  //               name: classnames[i],
  //               value: classnames[i],
  //             ),
  //           );
  //         });
  //       }
  //     },
  //   );
  // }

//method of update class details
  Future updateclassdetails(BuildContext context, String branchname,
      String classname, String mentorname) async {
    if (updateclassnamekey.currentState!.validate() &&
        updatebranchnamekey.currentState!.validate() &&
        updatementornamekey.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection('Branch')
          .doc(branchname)
          .collection('Classes')
          .doc(classname)
          .update(
        {
          'Mentor': mentorname,
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
  Future deleteclass(
      BuildContext context, String branchname, String classname) async {
    if (updateclassnamekey.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection('Branch')
          .doc(branchname)
          .collection('Classes')
          .doc(classname)
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
  clearsubmitbutton(String classname, String branchname, String mentorname) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        button(context, "Clear", branchname, classname, mentorname),
        SizedBox(
          width: 50,
        ),
        button(context, "Submit", branchname, classname, mentorname),
      ],
    );
  }

//clear submit update button method
  cleardeletesubmitbutton(
      String branchname, String classname, String mentorname) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            button(context, "Clear", branchname, classname, mentorname),
            SizedBox(
              width: 50,
            ),
            button(context, "Delete", branchname, classname, mentorname),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            button(context, "Update", branchname, classname, mentorname),
          ],
        )
      ],
    );
  }

//get class details method
  Future getclassdetail(
      DropDownValueModel? classname, DropDownValueModel? branchname) async {
    await FirebaseFirestore.instance
        .collection('Branch')
        .doc(branchname!.name.toString())
        .collection('Classes')
        .doc(classname!.name.toString())
        .get()
        .then(
      (DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          mentorvalue = snapshot['Mentor'];
          print('mentor name$mentorvalue');
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
