import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/utils/constant/constants.dart';
import 'package:my_app/utils/constant/getlist.dart';

class TeacherCorner extends StatefulWidget {
  const TeacherCorner({super.key});

  @override
  State<TeacherCorner> createState() => _TeacherCornerState();
}

class _TeacherCornerState extends State<TeacherCorner> {
  List<Map<String, dynamic>> studentdetails = [];
  List<String> studentlist = [];
  SingleValueDropDownController documentconroller =
      SingleValueDropDownController();
  List<String> documentlist = ['Bonafite Certificate', 'Admission Later'];

  String selectediteam = 'Select Document Name';
  GetList getlist = GetList();
  String? newValue;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Teacher Corner",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          10,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            DropDownTextField(
              onChanged: (value) async {
                setState(() {});
                // if (documentconroller.dropDownValue == null) {
                //   getstudentlistfordocument(
                //       documentconroller
                //           .setDropDown(DropDownValueModel(name: "", value: "")),
                //       false);
                // }
                // if (documentconroller.dropDownValue != null) {
                //   studentlist = await getstudentlistfordocument(
                //       documentconroller.dropDownValue!.name.toString(), true);
                //   setState(() {});
                // }
                if (studentlist.isNotEmpty) {
                  studentlist.clear();
                }
                if (documentconroller.dropDownValue != null) {
                  studentlist = await getstudentlistfordocument(
                      documentconroller.dropDownValue!.name.toString(), true);
                  setState(() {});
                } else {
                  return Future(
                    () => Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                print('Student list in teacher corner is ${studentlist}');
                print('object');
              },
              controller: documentconroller,
              dropDownList: [
                DropDownValueModel(
                    name: 'Bonafite Certificate',
                    value: 'Bonafite Certificate'),
                DropDownValueModel(
                    name: 'Admission Latter', value: 'Admission Latter')
              ],
              dropDownItemCount: 10,
              dropdownRadius: 10,
              textFieldDecoration: InputDecoration(
                labelText: 'Select document',
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
            if (studentlist.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  itemCount: studentlist.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        studentdetails =
                            await getstudetdetails(studentlist[index]);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('First Name:'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          studentdetails[index]['First Name']
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Midle Name:'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          studentdetails[index]['Midle Name']
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Last Name:'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          studentdetails[index]['Last Name']
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Enrollment No:'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          studentdetails[index]['Enrollment No']
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Phone No:'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          studentdetails[index]['Phone No']
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: SwipeActionCell(
                        key: Key(studentlist[index]),
                        trailingActions: [
                          SwipeAction(
                            title: 'Deleted listtile...',
                            onTap: (handler) async {
                              studentlist.remove(index);
                              QuerySnapshot snapshot = await FirebaseFirestore
                                  .instance
                                  .collection('Teacher')
                                  .doc(uId)
                                  .collection(documentconroller
                                      .dropDownValue!.name
                                      .toString())
                                  .get();
                              snapshot.docs.forEach(
                                (element) async {
                                  if (studentlist[index] ==
                                      element['Enrollment No']) {
                                    await FirebaseFirestore.instance
                                        .collection('Teacher')
                                        .doc(uId)
                                        .collection(documentconroller
                                            .dropDownValue!.name
                                            .toString())
                                        .doc(element['Enrollment No'])
                                        .delete()
                                        .whenComplete(
                                      () {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Student ${element['Enrollment No']} request is deleted');
                                      },
                                    );
                                  }
                                },
                              );
                              setState(() {});
                              handler(true);
                            },
                          ),
                        ],
                        leadingActions: [
                          SwipeAction(
                            title: 'Deleted listtile.....',
                            onTap: (handler)async {
                             studentlist.remove(index);
                              QuerySnapshot snapshot = await FirebaseFirestore
                                  .instance
                                  .collection('Teacher')
                                  .doc(uId)
                                  .collection(documentconroller
                                      .dropDownValue!.name
                                      .toString())
                                  .get();
                              snapshot.docs.forEach(
                                (element) async {
                                  if (studentlist[index] ==
                                      element['Enrollment No']) {
                                    await FirebaseFirestore.instance
                                        .collection('Teacher')
                                        .doc(uId)
                                        .collection(documentconroller
                                            .dropDownValue!.name
                                            .toString())
                                        .doc(element['Enrollment No'])
                                        .delete()
                                        .whenComplete(
                                      () {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Student ${element['Enrollment No']} request is deleted');
                                      },
                                    );
                                  }
                                },
                              );
                              setState(() {});
                              handler(true);
                            },
                          ),
                        ],
                        child: ListTile(
                          title: Text(studentlist[index]),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 1,
                      thickness: 0.5,
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }

  Future<List<String>> getstudentlistfordocument(
      String document, bool bool) async {
    List<String> studentlistfordoucment = [];
    if (bool == false) {
      studentlistfordoucment.clear();
    } else {
      print('reacherd reacherd');
      print(document);
      await FirebaseFirestore.instance
          .collection('Teacher')
          .doc(uId)
          .collection(document)
          .get()
          .then(
        (QuerySnapshot snapshot) {
          snapshot.docs.forEach(
            (element) {
              studentlistfordoucment.add(element['Enrollment No']);
            },
          );
        },
      );
      print(studentlistfordoucment);
    }

    return studentlistfordoucment;
  }

  Future getstudetdetails(String studentlist) async {
    List<Map<String, dynamic>> list = [];
    String firstname = "";
    String midlename = "";
    String lastname = "";
    String enrollmentno = "";
    String emailid = "";
    String phoneno = "";

    await FirebaseFirestore.instance
        .collection('Student')
        .doc(studentlist)
        .get()
        .then(
      (DocumentSnapshot snapshot) {
        list.add(
          {
            'First Name': snapshot['First Name'],
            'Midle Name': snapshot['Midle Name'],
            'Last Name': snapshot['Last Name'],
            'Enrollment No': snapshot['Enrollment No'],
            'Email ID': snapshot['Email'],
            'Phone No': snapshot['Phone'],
          },
        );
      },
    );
    print(list);
    return list;
  }
}
