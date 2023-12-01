import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/Admin/adminpage.dart';
import 'package:my_app/utils/constant/getlist.dart';

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
  late SingleValueDropDownController teacherid;
  // class
  late SingleValueDropDownController classvalue;
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
  final createteacheridkey = GlobalKey<FormState>();
  final updateteacheridkey = GlobalKey<FormState>();
  final createclasskey = GlobalKey<FormState>();
  final updateclasskey = GlobalKey<FormState>();

//department dropdowntextfield

  late SingleValueDropDownController department;
//use getting value form database and store in controller
  String firstnamevalue = '';
  String midlenamevalue = '';
  String lastnamevalue = '';
  String emailidvalue = '';
  num phonenovalue = 0;
  String departmentvalue = '';
  String yearvalue = '';
  String teacheridvalue = '';
  String classes = '';

  String accounttype = 'Teacher';
  bool visible = false;
  GetList getlist = GetList();
  @override
  void initState() {
    super.initState();
    teacherid = SingleValueDropDownController();
    department = SingleValueDropDownController();
    classvalue = SingleValueDropDownController();
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
                        // teacherid list in update teacher
                        if (widget.title == 'Update Teacher')
                          dropdownenrollmentlist(
                              context, "Select teacher id", teacherid, true),
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
                          department,
                          createdepartmentkey,
                          true,
                          "Select Department")
                      // department dropdown in update teacher
                      : updateteacherdropdown(
                          context,
                          "Select Department",
                          department,
                          updatedepartmentkey,
                          true,
                          "Select Department",
                          visible),
                  (widget.title == "Create Teacher" &&
                          department.dropDownValue != null)
                      // department dropdown in create teacher
                      ? createteacherdropdown(context, "Select Class",
                          classvalue, createclasskey, true, "Select Class")
                      // department dropdown in update teacher
                      : updateteacherdropdown(
                          context,
                          "Select Class",
                          classvalue,
                          updateclasskey,
                          true,
                          "Select Class",
                          visible),
                  SizedBox(
                    height: 10,
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
            maxLength: (labeltext == 'Phone No') ? 10 : 1000,
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
              counterText: "",
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
              maxLength: (labeltext == 'Phone No') ? 10 : 1000,
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
      SingleValueDropDownController controller,
      GlobalKey<FormState> key,
      bool bool,
      String labeltext) {
    return Column(
      children: [
        Form(
          key: key,
          child: FutureBuilder(
              future: (labeltext == 'Select Department')
                  ? getlist.getdepartmentlist()
                  : getlist.getclasslist(department.dropDownValue!.name),
              builder: (context, future) {
                if (future.hasData) {
                  List<DropDownValueModel>? list = future.data;
                  if (list != null) {
                    return DropDownTextField(
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
                  }
                }
                return Center(
                  child: Text(
                    "Something went wrong",
                  ),
                );
              }),
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
            child: FutureBuilder(
                future: (labeltext == 'Select Department')
                    ? getlist.getdepartmentlist()
                    : (department.dropDownValue != null)
                        ? getlist.getclasslist(department.dropDownValue!.name)
                        : getlist.getdepartmentlist(),
                builder: (context, future) {
                  if (future.hasData) {
                    List<DropDownValueModel>? list = future.data;
                    if (list != null) {
                      return DropDownTextField(
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
                    }
                  }
                  return Center(
                    child: Text(
                      "Something went wrong",
                    ),
                  );
                }),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
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
          updateteacherdetails(
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
    // year.clearDropDown();
  }

// method of update student details
  Future updateteacherdetails(BuildContext context, String id) async {
    if (updatefirstnamekey.currentState!.validate() &&
        updatemidlenamekey.currentState!.validate() &&
        updatelastnamekey.currentState!.validate() &&
        updateemailkey.currentState!.validate() &&
        updatephonekey.currentState!.validate() &&
        updatedepartmentkey.currentState!.validate() &&
        updateclasskey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection("Teacher").doc(id).update(
        {
          'First Name': firstnamecontroller.text.toString(),
          'Midle Name': midlenamecontroller.text.toString(),
          'Last Name': lastnamecontroller.text.toString(),
          'Phone': int.parse(phonecontroller.text),
          'TID': teacherid.dropDownValue!.name.toString(),
          'Email': emailidcontroller.text.toString(),
          'Department': department.dropDownValue!.name.toString(),
          'Account Type': accounttype.toString(),
          'Class': classvalue.dropDownValue!.name.toString()
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
        createclasskey.currentState!.validate()) {
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
          'Phone': int.parse(phonecontroller.text),
          'Department': department.dropDownValue!.name.toString(),
          'Account Type': accounttype.toString(),
          'Class': classvalue.dropDownValue!.name.toString(),
        },
      ).whenComplete(
        () async {
          try {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: emailidcontroller.text.toString(), password: '123456');
          } catch (e) {
            return;
          } finally {
            Navigator.pop(context);
          }
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Teacher Added",
          ),
        ),
      );
    }
  }

// method of enrollment lsit
  dropdownenrollmentlist(BuildContext context, String labeltext,
      SingleValueDropDownController teacherid, bool bool) {
    return Column(
      children: [
        FutureBuilder(
            future: getlist.getteachernamelist(),
            builder: (context, future) {
              if (future.hasData) {
                return DropDownTextField(
                  isEnabled: bool,
                  dropDownList: future.data!,
                  onChanged: (value) async {
                    setState(
                      () {
                        visible = true;
                        print(visible);
                      },
                    );

                    if (teacherid.dropDownValue != null) {
                      // get teacher details
                      await getteacherdetail(
                          teacherid.dropDownValue!.name.toString());
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
                    classvalue.setDropDown(
                      DropDownValueModel(
                        name: classes,
                        value: classes,
                      ),
                    );
                  },
                  validator: (value) {
                    if (teacherid.dropDownValue == null) {
                      return "Select enrollment";
                    } else if (teacherid.dropDownValue!.name.isEmpty) {
                      return "Select enrollment";
                    } else {
                      return null;
                    }
                  },
                  controller: teacherid,
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
                child: Text("Something went wrong"),
              );
            }),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

// method of gettin teacher details
  Future getteacherdetail(String id) async {
    await FirebaseFirestore.instance.collection("Teacher").doc(id).get().then(
      (DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          firstnamevalue = snapshot['First Name'];
          midlenamevalue = snapshot['Midle Name'];
          lastnamevalue = snapshot['Last Name'];
          emailidvalue = snapshot['Email'];
          phonenovalue = snapshot['Phone'];
          departmentvalue = snapshot['Department'];
          classes = snapshot['Class'];

          print(firstnamevalue);
          print(midlenamevalue);
          print(lastnamevalue);
          print(emailidvalue);
          print('phonenumber$phonenovalue');
          // print('type of phone number'+);
          if (phonenovalue.runtimeType == num) {
            print('truetrue');
          }
          setState(() {});
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
