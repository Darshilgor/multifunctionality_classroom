import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/utils/Admin/adminpage.dart';
import 'package:my_app/utils/constant/getlist.dart';

class CreateUpdateStudent extends StatefulWidget {
  final String title;
  const CreateUpdateStudent({super.key, required this.title});

  @override
  State<CreateUpdateStudent> createState() => _CreateUpdateStudentState();
}

class _CreateUpdateStudentState extends State<CreateUpdateStudent> {
  GetList getlist = GetList();
//textformfield controller
  TextEditingController accounttypecontroller = TextEditingController();
  TextEditingController departmentcontroller = TextEditingController();
  TextEditingController emailidcontroller = TextEditingController();
  TextEditingController studentenrollment = TextEditingController();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController midlenamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController semestercontroller = TextEditingController();
  TextEditingController yearcontroller = TextEditingController();

  String studentname = '';

//student dropdowntextfield
  late SingleValueDropDownController enrollment;

//depart dropdowntextfield
  late SingleValueDropDownController department;

//semester dropdowntextfield
  late SingleValueDropDownController semester;

//year dropdowntextfield

  late SingleValueDropDownController year;

  late SingleValueDropDownController classvalue;

//getting value from database and store in controller
  String firstnamevalue = '';
  String midlenamevalue = '';
  String lastnamevalue = '';
  String emailidvalue = '';
  num phonenovalue = 0;
  String departmentvalue = '';
  int semestervalue = 0;
  int yearvalue = 0;
  String gettingclassvalue = '';
  bool visible = false; //visibility

//different textformfield key
  final createenrollmentkey = GlobalKey<FormState>();
  final updateenrollmentkey = GlobalKey<FormState>();
  final createfirstnamekey = GlobalKey<FormState>();
  final updatefirstnamekey = GlobalKey<FormState>();
  final createmidlenamekey = GlobalKey<FormState>();
  final updatemidlenamekey = GlobalKey<FormState>();
  final createlastnamekey = GlobalKey<FormState>();
  final updatelastnamekey = GlobalKey<FormState>();
  final createemailkey = GlobalKey<FormState>();
  final updateemailkey = GlobalKey<FormState>();
  final createphonekey = GlobalKey<FormState>();
  final updatephonekey = GlobalKey<FormState>();
  final createdepartmentkey = GlobalKey<FormState>();
  final updatedepartmentkey = GlobalKey<FormState>();
  final createsemesterkey = GlobalKey<FormState>();
  final updatesemesterkey = GlobalKey<FormState>();
  final createyearkey = GlobalKey<FormState>();
  final updateyearkey = GlobalKey<FormState>();
  final createclasskey = GlobalKey<FormState>();
  final updateclasskey = GlobalKey<FormState>();

  final String collection = "Student";

  @override
  void initState() {
    super.initState();

    enrollment = SingleValueDropDownController();
    department = SingleValueDropDownController();
    semester = SingleValueDropDownController();
    year = SingleValueDropDownController();
    classvalue = SingleValueDropDownController();
  }

  File? profileimage;
  final ImagePicker _picker = ImagePicker();
  String profilephotourl = '';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: 80),
            child: Text(widget.title),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Form(
                    key: updateenrollmentkey,
                    child: Column(
                      children: [
                        if (widget.title == 'Update Student')
                          //dropdowntextfield for enrollment in update student
                          dropdownenrollmentlist(context,
                              "Select student enrollment", enrollment, true),
                      ],
                    ),
                  ),
                  (widget.title == 'Create Student')
                      //textformfield for firstname in create student
                      ? createstudenttextfield(
                          context,
                          "Enter first name",
                          firstnamecontroller,
                          "First Name",
                          "Enter student first name",
                          createfirstnamekey)
                      //textformfield for firstname in update student
                      : updatestudenttextfield(
                          context,
                          "Enter first name",
                          firstnamecontroller,
                          "First Name",
                          "Enter student first name",
                          updatefirstnamekey),
                  (widget.title == 'Create Student')
                      //textformfield for midlename in create student
                      ? createstudenttextfield(
                          context,
                          "Enter midle name",
                          midlenamecontroller,
                          "Midle Name",
                          "Enter student midle name",
                          createmidlenamekey)
                      //textformfield for mildename in update student
                      : updatestudenttextfield(
                          context,
                          "Enter midle name",
                          midlenamecontroller,
                          "Midle Name",
                          "Enter student midle name",
                          updatemidlenamekey),
                  (widget.title == 'Create Student')
                      //textformfield for lastname in create student
                      ? createstudenttextfield(
                          context,
                          "Enter last name",
                          lastnamecontroller,
                          "Last Name",
                          "Enter student last name",
                          createlastnamekey)
                      //textformfield for lastname in update student
                      : updatestudenttextfield(
                          context,
                          "Enter last name",
                          lastnamecontroller,
                          "Last Name",
                          "Enter student last name",
                          updatelastnamekey),
                  if (widget.title == 'Create Student')
                    //textformfield for enrollment in create student
                    createstudenttextfield(
                        context,
                        "Enter enrollment",
                        studentenrollment,
                        "Student Enrollment",
                        "Enter student enrollment",
                        createenrollmentkey),
                  (widget.title == 'Create Student')
                      //textformfield for email-id in create student
                      ? createstudenttextfield(
                          context,
                          "Enter Email id",
                          emailidcontroller,
                          "Email Id",
                          "Enter student email id",
                          createemailkey)
                      //textformfield for enrollment in update student
                      : updatestudenttextfield(
                          context,
                          "Enter Email id",
                          emailidcontroller,
                          "Email Id",
                          "Enter student email id",
                          updateemailkey),
                  (widget.title == 'Create Student')
                      //textformfield for phoneno in create student
                      ? createstudenttextfield(
                          context,
                          "Enter Phone No",
                          phonecontroller,
                          "Phone No",
                          "Enter student phone no",
                          createphonekey)
                      //textformfield for phoneno in update student
                      : updatestudenttextfield(
                          context,
                          "Enter Phone no",
                          phonecontroller,
                          "Phone No",
                          "Enter student phone no",
                          updatephonekey),
                  (widget.title == "Create Student")
                      // dropdowntextfield for branch in create student
                      ? createstudentdropdown(
                          context,
                          "Select Branch",
                          department,
                          createdepartmentkey,
                          true,
                          "Select Branch")
                      // dropdowntextfield for branch in update student
                      : updatestudentdropdown(
                          context,
                          "Select Branch",
                          department,
                          updatedepartmentkey,
                          true,
                          "Select Branch"),
                  (widget.title == "Create Student")
                      // dropdowntextfield for semester in create student
                      ? createstudentdropdown(context, "Select Semester",
                          semester, createsemesterkey, true, "Select Semester")
                      // dropdowntextfield for semester in update student
                      : updatestudentdropdown(context, "Select Semester",
                          semester, updatesemesterkey, true, "Select Semester"),
                  (widget.title == 'Create Student')
                      ? createstudentdropdown(context, "Select Class",
                          classvalue, createclasskey, true, "Select Class")
                      : updatestudentdropdown(context, "Select Class",
                          classvalue, updateclasskey, true, "Select Class"),
                  (widget.title == "Create Student")
                      // dropdowntextfield for year in create student
                      ? createstudentdropdown(context, "Select Year", year,
                          createyearkey, true, "Select Year")
                      //dropdowntextfield for year in update student
                      : updatestudentdropdown(context, "Select Year", year,
                          updateyearkey, true, "Select Year"),
                  if (widget.title == 'Create Student')
                    //clear submit button in create student
                    clearsubmitbutton(),
                  if (widget.title == 'Update Student')
                    Visibility(
                      visible: visible,
                      child: Column(
                        children: [
                          // clear delete update button in update student
                          cleardeleteupdatebutton(),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ));
  }

//add student data in database method
  Future addstudentdata(
      String collection,
      String id,
      String branch,
      String studentsemester,
      String studentyear,
      String collectionvalue) async {
    await FirebaseFirestore.instance.collection(collection).doc(id).set(
      {
        'First Name': firstnamecontroller.text,
        'Midle Name': midlenamecontroller.text,
        'Last Name': lastnamecontroller.text,
        'Enrollment No': studentenrollment.text,
        'Email': emailidcontroller.text,
        'Phone': phonecontroller.text,
        'Account Type': collection,
        'Branch': branch,
        'Semester': studentsemester,
        'Year': studentyear,
      },
    );
  }

//update student data in database method
  Future updatestudentdata(
    String collection,
    String id,
    String branch,
    String studentsemester,
    String studentyear,
    String collectionvalue,
  ) async {
    await FirebaseFirestore.instance.collection(collection).doc(id).get().then(
      (snapshot) async {
        if (snapshot.exists) {
          try {
            await FirebaseFirestore.instance
                .collection(collection)
                .doc(id)
                .update(
              {
                'First Name': firstnamecontroller.text,
                'Midle Name': midlenamecontroller.text,
                'Last Name': lastnamecontroller.text,
                'Enrollment No': studentenrollment.text,
                'Email': emailidcontroller.text,
                'Phone': phonecontroller.text,
                'Account Type': collection,
                'Branch': branch,
                'Semester': studentsemester,
                'Year': studentyear,
              },
            );
            getupdatemessage();
          } on FirebaseException catch (e) {
            Text(e.message!);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Student Not Found'),
            ),
          );
        }
      },
    );
  }

//snackbar message method
  void getupdatemessage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminPage(),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data Updated'),
      ),
    );
  }

//dropdowntextfield of enrollment list in update student
  dropdownenrollmentlist(BuildContext context, String labeltext,
      SingleValueDropDownController controller, bool bool) {
    return Column(
      children: [
        FutureBuilder(
            future: getlist.getstudentenrollmentlist(),
            builder: (context, future) {
              if (future.hasData) {
                return DropDownTextField(
                  onChanged: (value) async {
                    visible = true;
                    if (enrollment.dropDownValue != null) {
                      //getting student details from database
                      await getstudentdetail(
                          enrollment.dropDownValue!.name.toString());
                    }
                    //set controller value
                    firstnamecontroller.text = firstnamevalue.toString();
                    midlenamecontroller.text = midlenamevalue.toString();
                    lastnamecontroller.text = lastnamevalue.toString();
                    emailidcontroller.text = emailidvalue.toString();
                    phonecontroller.text = phonenovalue.toString();
                    department.setDropDown(
                      DropDownValueModel(
                        name: departmentvalue.toString(),
                        value: departmentvalue.toString(),
                      ),
                    );
                    semester.setDropDown(
                      DropDownValueModel(
                        name: semestervalue.toString(),
                        value: semestervalue.toString(),
                      ),
                    );
                    year.setDropDown(
                      DropDownValueModel(
                        name: yearvalue.toString(),
                        value: yearvalue.toString(),
                      ),
                    );
                    classvalue.setDropDown(
                      DropDownValueModel(
                        name: gettingclassvalue.toString(),
                        value: gettingclassvalue.toString(),
                      ),
                    );
                  },
                  isEnabled: bool,
                  dropDownList: future.data!,
                  validator: (value) {
                    if (enrollment.dropDownValue == null) {
                      return "Select enrollment";
                    } else if (enrollment.dropDownValue!.name.isEmpty) {
                      return "Select enrollment";
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
            }),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

//getting student detail method
  Future getstudetndetail(String id) async {
    await FirebaseFirestore.instance.collection("Student").doc(id).get().then(
      (value) {
        if (value.exists) {
          firstnamevalue = value.data()!['First Name'];
          midlenamevalue = value.data()!['Midle Name'];
          lastnamevalue = value.data()!['Last Name'];
          emailidvalue = value.data()!['Email'];
          phonenovalue = value.data()!['Phone'];
          departmentvalue = value.data()!['Branch'];
          semestervalue = value.data()!['Semester'];
          yearvalue = value.data()!['Year'];
        }
      },
    );
  }

//select department method
  dropdowndepartment(
      BuildContext context,
      String labeltext,
      List<DropDownValueModel> departmentlist,
      SingleValueDropDownController controller,
      bool bool) {
    return Column(
      children: [
        DropDownTextField(
          isEnabled: bool,
          dropDownList: departmentlist,
          validator: (value) {
            if (department.dropDownValue == null) {
              return "Select department";
            } else if (department.dropDownValue!.name.isEmpty) {
              return "Select department";
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
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

//select semester method
  dropdownsemester(
      BuildContext context,
      String labeltext,
      List<DropDownValueModel> semesterlist,
      SingleValueDropDownController controller,
      bool bool) {
    return Column(
      children: [
        DropDownTextField(
          isEnabled: bool,
          dropDownList: semesterlist,
          validator: (value) {
            if (semester.dropDownValue == null) {
              return "Select semester";
            } else if (semester.dropDownValue!.name.isEmpty) {
              return "Select semester";
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
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

//select year method
  dropdownyear(
      BuildContext context,
      String labeltext,
      List<DropDownValueModel> yearlist,
      SingleValueDropDownController controller,
      bool bool) {
    return Column(
      children: [
        DropDownTextField(
          isEnabled: bool,
          dropDownList: yearlist,
          validator: (value) {
            if (year.dropDownValue == null) {
              return "Select year";
            } else if (year.dropDownValue!.name.isEmpty) {
              return "Select year";
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
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

//getting student detail from database
  Future getstudentdetail(String id) async {
    await FirebaseFirestore.instance.collection("Student").doc(id).get().then(
      (value) {
        if (value.exists) {
          setState(
            () {
              firstnamevalue = value.data()!['First Name'];
              midlenamevalue = value.data()!['Midle Name'];
              lastnamevalue = value.data()!['Last Name'];
              emailidvalue = value.data()!['Email'];
              phonenovalue = value.data()!['Phone'];
              departmentvalue = value.data()!['Branch'];
              semestervalue = value.data()!['Semester'];
              yearvalue = value.data()!['Year'];
              gettingclassvalue = value.data()!['Class'];
            },
          );
        }
      },
    );
  }

//clear submit method
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

// button design method
  button(BuildContext context, String labeltext) {
    return ElevatedButton(
      onPressed: () {
        if (labeltext == 'Clear')
          clear();
        else if (labeltext == 'Delete') {
          deletestudent(enrollment.dropDownValue!.name.toString());
        } else if (labeltext == 'Update') {
          updatestudentdetail(
              context, enrollment.dropDownValue!.name.toString());
        } else if (labeltext == 'Submit') {
          submit(context, studentenrollment.text.toString());
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

//clear method
  void clear() {
    firstnamecontroller.clear();
    midlenamecontroller.clear();
    lastnamecontroller.clear();
    emailidcontroller.clear();
    phonecontroller.clear();
    department.clearDropDown();
    semester.clearDropDown();
    year.clearDropDown();
    setState(() {});
  }

// delete student method
  Future deletestudent(String id) async {
    await FirebaseFirestore.instance
        .collection("Student")
        .doc(id)
        .delete()
        .whenComplete(
      () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Student deleted",
            ),
          ),
        );
      },
    );
  }

//update student detail method
  Future updatestudentdetail(BuildContext context, String id) async {
    if (updateenrollmentkey.currentState!.validate() &&
        updatefirstnamekey.currentState!.validate() &&
        updatemidlenamekey.currentState!.validate() &&
        updatelastnamekey.currentState!.validate() &&
        updateemailkey.currentState!.validate() &&
        updatephonekey.currentState!.validate() &&
        updatedepartmentkey.currentState!.validate() &&
        updatesemesterkey.currentState!.validate() &&
        updateyearkey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection("Student").doc(id).update(
        {
          'First Name': firstnamecontroller.text.toString(),
          'Midle Name': midlenamecontroller.text.toString(),
          'Last Name': lastnamecontroller.text.toString(),
          'Email': emailidcontroller.text.toString(),
          'Phone': int.parse(phonecontroller.text),
          'Branch': department.dropDownValue!.name.toString(),
          'Semester': int.parse(semester.dropDownValue!.name),
          'Year': int.parse(year.dropDownValue!.name),
        },
      ).whenComplete(
        () {
          Navigator.pop(context);
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Update Student",
          ),
        ),
      );
    }
  }

//submit button process method
  Future submit(BuildContext context, String id) async {
    if (createfirstnamekey.currentState!.validate() &&
        createmidlenamekey.currentState!.validate() &&
        createlastnamekey.currentState!.validate() &&
        createenrollmentkey.currentState!.validate() &&
        createemailkey.currentState!.validate() &&
        createphonekey.currentState!.validate() &&
        createdepartmentkey.currentState!.validate() &&
        createsemesterkey.currentState!.validate() &&
        createyearkey.currentState!.validate() &&
        createclasskey.currentState!.validate()) {
      String profilephotourl =
          'https://firebasestorage.googleapis.com/v0/b/myapp-2bd7a.appspot.com/o/images%2FProfile%2FDefaultProfilePhoto%2Fldpr_logo.png?alt=media&token=86477a33-6c6c-4dcc-b9e1-b70529bfbc45';
      await FirebaseFirestore.instance.collection("Student").doc(id).set(
        {
          'Profile Photo': profilephotourl.toString(),
          'Account Type': collection.toString(),
          'First Name': firstnamecontroller.text.toString(),
          'Midle Name': midlenamecontroller.text.toString(),
          'Last Name': lastnamecontroller.text.toString(),
          'Enrollment No': studentenrollment.text.toString(),
          'Email': emailidcontroller.text.toString(),
          'Phone': int.parse(phonecontroller.text),
          'Branch': department.dropDownValue!.name.toString(),
          'Semester': int.parse(semester.dropDownValue!.name),
          'Year': int.parse(year.dropDownValue!.name),
        },
      ).whenComplete(
        () async {
          try {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: emailidcontroller.text.toString(), password: '123456');
          } catch (e) {
            return;
          }
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Student created",
          ),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminPage(),
        ),
      );
    }
  }

//update student button design
  cleardeleteupdatebutton() {
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

//textformfield of create student
  createstudenttextfield(
      BuildContext context,
      String errormessage,
      TextEditingController controller,
      String labeltext,
      String hinttext,
      GlobalKey<FormState> key) {
    return Column(
      children: [
        Form(
          key: key,
          child: TextFormField(
            maxLength: (labeltext == 'Phone No') ? 10 : 1000,
            validator: (value) {
              if (controller.text.toString() == null) {
                return errormessage;
              } else if (controller.text.toString().isEmpty) {
                return errormessage;
              } else {
                return null;
              }
            },
            controller: controller,
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
              label: Text(labeltext),
              hintText: hinttext,
              labelStyle: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

// textformfield of update student
  updatestudenttextfield(
      BuildContext context,
      String errormessage,
      TextEditingController controller,
      String labletext,
      String hinttext,
      GlobalKey<FormState> key) {
    return Column(
      children: [
        Form(
          key: key,
          child: Visibility(
            visible: visible,
            child: TextFormField(
              maxLength: (labletext == 'Phone No') ? 10 : 100,
              validator: (value) {
                if (controller.text.toString() == null) {
                  return errormessage;
                } else if (controller.text.toString().isEmpty) {
                  return errormessage;
                } else {
                  return null;
                }
              },
              controller: controller,
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
                label: Text(labletext),
                hintText: hinttext,
                labelStyle: const TextStyle(fontSize: 20),
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

//dropdowntextfield of create student
  createstudentdropdown(
      BuildContext context,
      String errormessage,
      SingleValueDropDownController controller,
      GlobalKey<FormState> key,
      bool bool,
      String labeltext) {
    return Column(
      children: [
        Form(
          key: key,
          child: FutureBuilder(
            future: (labeltext == 'Select Branch')
                ? getlist.getdepartmentlist()
                : ((labeltext == 'Select Semester')
                    ? getlist.getsemesterlist()
                    : (labeltext == 'Select Class' &&
                            department.dropDownValue != null)
                        ? getlist.getclasslist(
                            department.dropDownValue!.name.toString())
                        : getlist.getyearlist()),
            builder: (context, future) {
              if (future.hasData) {
                return DropDownTextField(
                  isEnabled: bool,
                  dropDownList: future.data!,
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

// dropdowntextfield of update student
  updatestudentdropdown(
      BuildContext context,
      String errormessage,
      SingleValueDropDownController controller,
      GlobalKey<FormState> key,
      bool bool,
      String labeltext) {
    return Column(
      children: [
        Visibility(
          visible: visible,
          child: Form(
            key: key,
            child: FutureBuilder(
              future: (labeltext == 'Select Branch')
                  ? getlist.getdepartmentlist()
                  : ((labeltext == 'Select Semester')
                      ? getlist.getsemesterlist()
                      : (labeltext == 'Select Class' &&
                              department.dropDownValue != null)
                          ? getlist.getclasslist(
                              department.dropDownValue!.name.toString())
                          : getlist.getyearlist()),
              builder: (context, future) {
                if (future.hasData) {
                  return DropDownTextField(
                    isEnabled: bool,
                    dropDownList: future.data!,
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
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
