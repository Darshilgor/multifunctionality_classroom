import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/Admin/adminpage.dart';

class CreateUpdateTeacher extends StatefulWidget {
  final String title;
  const CreateUpdateTeacher({super.key, required this.title});

  @override
  State<CreateUpdateTeacher> createState() => _CreateUpdateTeacherState();
}

class _CreateUpdateTeacherState extends State<CreateUpdateTeacher> {
//textformfield controller
  TextEditingController accounttypecontroller = TextEditingController();
  TextEditingController departmentcontroller = TextEditingController();
  TextEditingController emailidcontroller = TextEditingController();
  TextEditingController teacheridcontroller = TextEditingController();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController midlenamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController semestercontroller = TextEditingController();
  TextEditingController yearcontroller = TextEditingController();
//teacher id dropdowntextfield
  List<String> teacherids = [];
  List<DropDownValueModel> teacheridlist = [];
  late SingleValueDropDownController teacherid;
//different textfield key
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
  final createyearkey = GlobalKey<FormState>();
  final updateyearkey = GlobalKey<FormState>();
  final createteacheridkey = GlobalKey<FormState>();
  final updateteacheridkey = GlobalKey<FormState>();
//department dropdowntextfield
  List<String> departments = [];
  List<DropDownValueModel> departmentlist = [];
  late SingleValueDropDownController department;
//use getting value form database and store in controller
  String firstnamevalue = '';
  String midlenamevalue = '';
  String lastnamevalue = '';
  String emailidvalue = '';
  String phonenovalue = '';
  String departmentvalue = '';
  String yearvalue = '';
  String teacheridvalue = '';
//year dropdowntextfield
  List<String> years = [];
  List<DropDownValueModel> yearlist = [];
  late SingleValueDropDownController year;
  String accounttype = 'Teacher';
  bool visible = false;

  @override
  void initState() {
    super.initState();
    teacherid = SingleValueDropDownController();
    getteachernamelist(); //teacher list
    getdepartmentlist(); //department list
    getyearlist(); //year list

    department = SingleValueDropDownController();
    year = SingleValueDropDownController();
    department = SingleValueDropDownController();
    teacherid = SingleValueDropDownController();
  }

  @override
  void dispose() {
    super.dispose();
    teacherid.dispose();
  }

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
                    key: updateteacheridkey,
                    child: Column(
                      children: [
                        if (widget.title == 'Update Teacher')
                          // teacherid list in update teacher
                          dropdownenrollmentlist(context, "Select teacher id",
                              teacheridlist, teacherid, true),
                      ],
                    ),
                  ),
                  (widget.title == 'Create Teacher')
                      //firstname textfield in create teacher
                      ? createteachertextfield(
                          context,
                          'Enter teacher first name',
                          firstnamecontroller,
                          'First Name',
                          'Enter teacher first name',
                          createfirstnamekey)
                      //firstname textfield in update teacher
                      : updateteachertextfield(
                          context,
                          'Enter teacher first name',
                          firstnamecontroller,
                          'First Name',
                          'Enter teacher first name',
                          updatefirstnamekey,
                          visible),
                  (widget.title == 'Create Teacher')
                      //midlename textfield in create teacher
                      ? createteachertextfield(
                          context,
                          'Enter teacher midle name',
                          midlenamecontroller,
                          'Midle Name',
                          'Enter teacher midle name',
                          createmidlenamekey)
                      //midlename textfield in update teacher
                      : updateteachertextfield(
                          context,
                          'Enter teacher midle name',
                          midlenamecontroller,
                          'Midle Name',
                          'Enter teacher midle name',
                          updatemidlenamekey,
                          visible),
                  (widget.title == 'Create Teacher')
                      //lastname textfield in create teacher
                      ? createteachertextfield(
                          context,
                          'Enter teacher last name',
                          lastnamecontroller,
                          'Last Name',
                          'Enter teacher last name',
                          createlastnamekey)
                      //lastname textfield in update teacher
                      : updateteachertextfield(
                          context,
                          'Enter teacher last name',
                          lastnamecontroller,
                          'Last Name',
                          'Enter teacher last name',
                          updatelastnamekey,
                          visible),
                  if (widget.title == 'Create Teacher')
                    //teacher-id textfield in create teacher
                    createteachertextfield(
                        context,
                        'Enter teacher id',
                        teacheridcontroller,
                        'Teacher Id',
                        'Enter teacher teacher id',
                        createteacheridkey),
                  (widget.title == 'Create Teacher')
                      // email-id textfield in create teacher
                      ? createteachertextfield(
                          context,
                          'Enter teacher email-id',
                          emailidcontroller,
                          'Email Id',
                          'Enter teacher email-id',
                          createemailkey)
                      //email-id textfield in update teacher
                      : updateteachertextfield(
                          context,
                          'Enter teacher email-id',
                          emailidcontroller,
                          'Email-Id',
                          'Enter teacher email-id',
                          updateemailkey,
                          visible),
                  (widget.title == 'Create Teacher')
                      // phone-no textfield in create teacher
                      ? createteachertextfield(
                          context,
                          'Enter teacher phone no',
                          phonecontroller,
                          'Phone No',
                          'Enter teacher phone no',
                          createphonekey)
                      // phone-no textfield in update teacher
                      : updateteachertextfield(
                          context,
                          'Enter teacher phone no',
                          phonecontroller,
                          'Phone No',
                          'Enter teacher phone no',
                          updatephonekey,
                          visible),
                  (widget.title == "Create Teacher")
                      // department dropdown in create teacher
                      ? createteacherdropdown(
                          context,
                          "Select Department",
                          departmentlist,
                          department,
                          createdepartmentkey,
                          true,
                          "Select Department")
                      // department dropdown in update teacher
                      : updateteacherdropdown(
                          context,
                          "Select Department",
                          departmentlist,
                          department,
                          updatedepartmentkey,
                          true,
                          "Select Department",
                          visible),
                  (widget.title == "Create Teacher")
                      // year dropdown in create teacher
                      ? createteacherdropdown(context, "Select Year", yearlist,
                          year, createyearkey, true, "Select Year")
                      // year dropdown in update student
                      : updateteacherdropdown(context, "Select Year", yearlist,
                          year, updateyearkey, true, "Select Year", visible),
                  SizedBox(
                    height: 20,
                  ),
                  if (widget.title == 'Create Teacher')
                    //clear submit button in create teacher
                    clearsubmitbutton(),
                  if (widget.title == 'Update Teacher')
                    Visibility(
                      visible: visible,
                      child: Column(
                        children: [
                          // clear delete update button in update teacher
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

//method of adding teacher data in database
  Future addteacherdata(String collection, String id, String department,
      String teacheryear) async {
    await FirebaseFirestore.instance.collection(collection).doc(id).set(
      {
        'First Name': firstnamecontroller.text,
        'Midle Name': midlenamecontroller.text,
        'Last Name': lastnamecontroller.text,
        'TID': teacheridcontroller.text,
        'Account Type': collection,
        'Department': department,
        'Email': emailidcontroller.text,
        'Phone': phonecontroller.text,
        'Year': teacheryear,
      },
    );
  }

//method of updating teacher data in database
  Future updateteacherdata(String collection, String id, String department,
      String teacheryear) async {
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
                'TID': id,
                'Email': emailidcontroller.text,
                'Phone': phonecontroller.text,
                'Account Type': collection,
                'Department': department,
                'Year': teacheryear,
              },
            );
            getupdatemessage();
          } on FirebaseException catch (e) {
            Text(e.message!);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Teacher Not Found'),
            ),
          );
        }
      },
    );
  }

// method of snackbar message
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

// method of getting teacher-id list
  Future getteachernamelist() async {
    await FirebaseFirestore.instance.collection("Teacher").get().then(
      (QuerySnapshot querysnapshot) {
        querysnapshot.docs.forEach(
          (element) {
            setState(
              () {
                teacherids.add(
                  element["TID"],
                );
              },
            );
          },
        );
        for (int i = 0; i < teacherids.length; i++) {
          teacheridlist.add(
            DropDownValueModel(
              name: teacherids[i],
              value: teacherids[i],
            ),
          );
        }
      },
    );
  }

// method of dropdowntextfield
  dropdownfield(
      BuildContext context,
      String labeltext,
      List<DropDownValueModel> teacheridlist,
      SingleValueDropDownController id,
      bool controller) {
    return Column(
      children: [
        DropDownTextField(
          isEnabled: controller,
          controller: id,
          dropDownList: teacheridlist,
          dropDownItemCount: 6,
          dropdownRadius: 10,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please Select Teacher ID";
            } else {
              return null;
            }
          },
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

// method of showdialogbox
  showdialogbox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          width: 200,
          height: 300,
          child: Column(
            children: [
              Text(
                "Are you sure to delete ${teacherid.dropDownValue!.name}",
              ),
              ElevatedButton(
                onPressed: () {
                  teacheriddelete();
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "No",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// method of teacher name textfield
  creteteachertextformfield() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter Teacher First Name";
        }
        return null;
      },
      controller: firstnamecontroller,
      decoration: InputDecoration(
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
        label: const Text("First Name"),
        hintText: "Enter Teacher First Name",
        labelStyle: const TextStyle(fontSize: 20),
      ),
    );
  }

  Future teacheriddelete() async {
    Navigator.pop(context);
    return await FirebaseFirestore.instance
        .collection("Teacher")
        .doc(teacherid.dropDownValue!.name)
        .delete()
        .whenComplete(
      () {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Teacher id deleted",
            ),
          ),
        );
      },
    );
  }

// method of delete button
  deletebutton() {
    return ElevatedButton(
      onPressed: () {
        showdialogbox();
      },
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Text(
          "Delete",
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
      ),
    );
  }

// method of textfield of teacher-id
  teacheridtextfield() {
    return Column(
      children: [
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter Teacher ID";
            }
            return null;
          },
          controller: teacheridcontroller,
          decoration: InputDecoration(
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
            label: const Text("Teacher ID"),
            hintText: "Enter Teacher ID",
            labelStyle: const TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

// method of textfield of create teacher
  createteachertextfield(
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
            controller: controller,
            validator: (value) {
              if (firstnamecontroller == null) {
                return errormessage;
              } else if (firstnamecontroller.text.toString().isEmpty) {
                return errormessage;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
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
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

// method of textfield of update teacher
  updateteachertextfield(
      BuildContext context,
      String errormessage,
      TextEditingController controller,
      String labeltext,
      String hinttext,
      GlobalKey<FormState> key,
      bool visible) {
    return Column(
      children: [
        Visibility(
          visible: visible,
          child: Form(
            key: key,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (firstnamecontroller == null) {
                  return errormessage;
                } else if (firstnamecontroller.text.toString().isEmpty) {
                  return errormessage;
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
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
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

// method of dropdown of create teacher
  createteacherdropdown(
      BuildContext context,
      String errormessage,
      List<DropDownValueModel> list,
      SingleValueDropDownController controller,
      GlobalKey<FormState> key,
      bool bool,
      String labeltext) {
    return Column(
      children: [
        Form(
          key: key,
          child: DropDownTextField(
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

// method of dropdown of update teacher
  updateteacherdropdown(
      BuildContext context,
      String errormessage,
      List<DropDownValueModel> list,
      SingleValueDropDownController controller,
      GlobalKey<FormState> key,
      bool bool,
      String labeltext,
      bool visible) {
    return Column(
      children: [
        Visibility(
          visible: visible,
          child: Form(
            key: key,
            child: DropDownTextField(
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
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

// method of getting department list
  Future getdepartmentlist() async {
    await FirebaseFirestore.instance.collection("Branch").get().then(
      (QuerySnapshot snapshot) {
        snapshot.docs.forEach(
          (element) {
            setState(() {
              departments.add(
                element['Branch Name'],
              );
            });
          },
        );
        for (int i = 0; i < departments.length; i++) {
          setState(() {
            departmentlist.add(
              DropDownValueModel(
                name: departments[i],
                value: departments[i],
              ),
            );
          });
        }
      },
    );
  }

// method of getting year list
  Future getyearlist() async {
    await FirebaseFirestore.instance.collection("Year").get().then(
      (QuerySnapshot snapshot) {
        snapshot.docs.forEach(
          (element) {
            setState(() {
              years.add(
                element['Year'],
              );
            });
          },
        );
        for (int i = 0; i < years.length; i++) {
          setState(() {
            yearlist.add(
              DropDownValueModel(
                name: years[i],
                value: years[i],
              ),
            );
          });
        }
      },
    );
  }

// clear submit button
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

// cleat update delete button
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

// button process
  button(BuildContext context, String labeltext) {
    return ElevatedButton(
      onPressed: () {
        if (labeltext == 'Clear')
          clear();
        else if (labeltext == 'Delete') {
          deleteteacher(teacherid.dropDownValue!.name.toString());
        } else if (labeltext == 'Update') {
          updatestudentdetail(
              context, teacherid.dropDownValue!.name.toString());
        } else if (labeltext == 'Submit') {
          submit(context, teacheridcontroller.text.toString());
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

// clear method
  void clear() {
    firstnamecontroller.clear();
    midlenamecontroller.clear();
    lastnamecontroller.clear();
    teacheridcontroller.clear();
    emailidcontroller.clear();
    phonecontroller.clear();
    department.clearDropDown();
    year.clearDropDown();
  }

// method of update student details
  Future updatestudentdetail(BuildContext context, String id) async {
    if (updatefirstnamekey.currentState!.validate() &&
        updatemidlenamekey.currentState!.validate() &&
        updatelastnamekey.currentState!.validate() &&
        updateemailkey.currentState!.validate() &&
        updatephonekey.currentState!.validate() &&
        updatedepartmentkey.currentState!.validate() &&
        updateyearkey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection("Teacher").doc(id).set(
        {
          'First Name': firstnamecontroller.text.toString(),
          'Midle Name': midlenamecontroller.text.toString(),
          'Last Name': lastnamecontroller.text.toString(),
          'Phone': phonecontroller.text.toString(),
          'Year': year.dropDownValue!.name.toString(),
          'TID': teacherid.dropDownValue!.name.toString(),
          'Email': emailidcontroller.text.toString(),
          'Department': department.dropDownValue!.name.toString(),
          'Account Type': accounttype.toString(),
        },
      ).whenComplete(
        () {
          Navigator.pop(context);
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Teacher updated",
          ),
        ),
      );
    }
  }

// method of submit process
  Future submit(BuildContext context, String id) async {
    if (createfirstnamekey.currentState!.validate() &&
        createmidlenamekey.currentState!.validate() &&
        createlastnamekey.currentState!.validate() &&
        createteacheridkey.currentState!.validate() &&
        createemailkey.currentState!.validate() &&
        createphonekey.currentState!.validate() &&
        createdepartmentkey.currentState!.validate() &&
        createyearkey.currentState!.validate()) {
      String profilephotourl =
          'https://firebasestorage.googleapis.com/v0/b/myapp-2bd7a.appspot.com/o/images%2FProfile%2FDefaultProfilePhoto%2Fldpr_logo.png?alt=media&token=86477a33-6c6c-4dcc-b9e1-b70529bfbc45';
      await FirebaseFirestore.instance.collection("Teacher").doc(id).set(
        {
          'Profile Photo': profilephotourl.toString(),
          'First Name': firstnamecontroller.text.toString(),
          'Midle Name': midlenamecontroller.text.toString(),
          'Last Name': lastnamecontroller.text.toString(),
          'TID': teacheridcontroller.text.toString(),
          'Email': emailidcontroller.text.toString(),
          'Phone': phonecontroller.text.toString(),
          'Department': department.dropDownValue!.name.toString(),
          'Year': year.dropDownValue!.name.toString(),
          'Account Type': accounttype.toString(),
        },
      ).whenComplete(
        () async {
          try {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: emailidcontroller.text.toString(), password: '123456');
          } catch (e) {
            return;
          }
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Student teacher",
              ),
            ),
          );
        },
      );
    }
  }

// method of enrollment lsit
  dropdownenrollmentlist(
      BuildContext context,
      String labeltext,
      List<DropDownValueModel> studentenrollmentlist,
      SingleValueDropDownController controller,
      bool bool) {
    return Column(
      children: [
        DropDownTextField(
          onChanged: (value) async {
            visible = true;
            if (teacherid.dropDownValue != null) {
              // get teacher details
              await getteacherdetail(teacherid.dropDownValue!.name.toString());
            }
            // set controller value
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

            year.setDropDown(
              DropDownValueModel(
                name: yearvalue.toString(),
                value: yearvalue.toString(),
              ),
            );

            setState(() {});
          },
          isEnabled: bool,
          dropDownList: studentenrollmentlist,
          validator: (value) {
            if (teacherid.dropDownValue == null) {
              return "Select enrollment";
            } else if (teacherid.dropDownValue!.name.isEmpty) {
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
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

// method of gettin teacher details
  Future getteacherdetail(String id) async {
    await FirebaseFirestore.instance.collection("Teacher").doc(id).get().then(
      (value) {
        if (value.exists) {
          setState(
            () {
              firstnamevalue = value.data()!['First Name'];
              midlenamevalue = value.data()!['Midle Name'];
              lastnamevalue = value.data()!['Last Name'];
              emailidvalue = value.data()!['Email'];
              phonenovalue = value.data()!['Phone'];
              departmentvalue = value.data()!['Department'];
              yearvalue = value.data()!['Year'];
            },
          );
        }
      },
    );
  }

// delete teacher method
  Future deleteteacher(String id) async {
    await FirebaseFirestore.instance
        .collection("Teacher")
        .doc(id)
        .delete()
        .whenComplete(
      () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Teacher deleted",
            ),
          ),
        );
        Navigator.pop(context);
      },
    );
  }
}
