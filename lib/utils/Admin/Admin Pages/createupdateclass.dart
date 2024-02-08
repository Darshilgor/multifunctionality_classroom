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
  late SingleValueDropDownController branchname;

//for semester dropdowntextfield
  late SingleValueDropDownController semester;

//for mentor dropdowntextfield
  SingleValueDropDownController mentorname = SingleValueDropDownController();

//for classname dropdowntextfield

  late SingleValueDropDownController classname;

  GetList getlist = GetList();

  @override
  void initState() {
    super.initState();
    branchname = SingleValueDropDownController();
    // mentorname = SingleValueDropDownController();
    classname = SingleValueDropDownController();
    mentorname.dropDownValue =
        DropDownValueModel(name: 'jfds;', value: 'djkld');
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
                            : Text('Please select mentor name'),
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
          list = future.data!;
          return DropDownTextField(
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
        // classnamecontroller.clear();
        // branchname.clearDropDown();
        // semester.clearDropDown();
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
                  setState(() {});
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
                  mentorname.setDropDown(
                    DropDownValueModel(
                      name: mentorvalue.toString(),
                      value: mentorvalue.toString(),
                    ),
                  );
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
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }

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
          // mentorname.dropDownValue = snapshot['Mentor'];
          // print(mentorname.dropDownValue!.name);
          // print('mentor name$mentorvalue');
          mentorname.setDropDown(DropDownValueModel(
              name: snapshot['Mentor'], value: snapshot['Mentor']));
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
