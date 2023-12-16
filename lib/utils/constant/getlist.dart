import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:my_app/utils/constant/constants.dart';

class GetList {
  Future<List<DropDownValueModel>> getteachernamelist() async {
    List<DropDownValueModel> teacheridlist = [];
    List<String> teacherids = [];
    await FirebaseFirestore.instance.collection("Teacher").get().then(
      (QuerySnapshot querysnapshot) {
        querysnapshot.docs.forEach(
          (element) {
            teacherids.add(
              element["TID"],
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
    print(teacheridlist);
    return teacheridlist;
  }

  Future<List<DropDownValueModel>> getmentorlist(String collection) async {
    List<String> mentorfirstname = [];
    List<String> mentormidlename = [];
    List<String> mentorlastname = [];
    List<DropDownValueModel> mentorlist = [];

    await FirebaseFirestore.instance.collection(collection).get().then(
      (QuerySnapshot querysnapshot) {
        querysnapshot.docs.forEach(
          (element) {
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
        for (int i = 0; i < mentorfirstname.length; i++) {
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
        }
      },
    );
    return mentorlist;
  }

  Future<List<String>> getstudentlist(
      String collection, String branchname, int semestername) async {
    List<String> firstname = [];
    List<String> midlename = [];
    List<String> lastname = [];
    List<String> studentlist = [];
    await FirebaseFirestore.instance.collection(collection).get().then(
      (QuerySnapshot snapshot) {
        snapshot.docs.forEach(
          (element) {
            if (branchname == element['Branch'] &&
                semestername == element['Semester']) {
              firstname.add(element['First Name']);
              midlename.add(element['Midle Name']);
              lastname.add(element['Last Name']);
            }
          },
        );
        for (int i = 0; i < firstname.length; i++) {
          studentlist.add('${firstname[i]}  ${midlename[i]}  ${lastname[i]}');
        }
      },
    );
    print(studentlist);
    return studentlist;
  }

  Future<List<DropDownValueModel>> getdepartmentlist() async {
    List<String> departments = [];
    List<DropDownValueModel> departmentlist = [];

    await FirebaseFirestore.instance.collection("Branch").get().then(
      (QuerySnapshot snapshot) {
        snapshot.docs.forEach(
          (element) {
            departments.add(
              element['Branch Name'],
            );
          },
        );
        for (int i = 0; i < departments.length; i++) {
          departmentlist.add(
            DropDownValueModel(
              name: departments[i],
              value: departments[i],
            ),
          );
        }
      },
    );
    return departmentlist;
  }

  Future<List<DropDownValueModel>> getclasslist(String branchname) async {
    List<String> classlist = [];
    List<DropDownValueModel> classdropdownlist = [];
    await FirebaseFirestore.instance
        .collection('Branch')
        .doc(branchname)
        .collection('Classes')
        .get()
        .then(
      (QuerySnapshot snapshot) {
        snapshot.docs.forEach(
          (element) {
            classlist.add(
              element['Class Name'],
            );
          },
        );
      },
    );

    for (int i = 0; i < classlist.length; i++) {
      classdropdownlist.add(
        DropDownValueModel(
          name: classlist[i],
          value: classlist[i],
        ),
      );
    }
    print(classdropdownlist);
    return classdropdownlist;
  }

  // Future getclassnamelist() async {
  //   List<String> classnames = [];
  //   List<DropDownValueModel> classnamelist = [];
  //   await FirebaseFirestore.instance.collection(collectionvalue).get().then(
  //     (QuerySnapshot querysnapshot) {
  //       querysnapshot.docs.forEach(
  //         (element) {
  //           classnames.add(
  //             element['Class Name'],
  //           );
  //         },
  //       );
  //       for (int i = 0; i < classnames.length; i++) {
  //         classnamelist.add(
  //           DropDownValueModel(
  //             name: classnames[i],
  //             value: classnames[i],
  //           ),
  //         );
  //       }
  //     },
  //   );
  //   return classnamelist;
  // }

  Future<List<DropDownValueModel>> getsemesterlist() async {
    List<String> semesters = [];
    List<DropDownValueModel> semesterlist = [];
    await FirebaseFirestore.instance.collection("Semester").get().then(
      (QuerySnapshot snapshot) {
        snapshot.docs.forEach(
          (element) {
            semesters.add(
              element['Semester No'],
            );
          },
        );
        for (int i = 0; i < semesters.length; i++) {
          semesterlist.add(
            DropDownValueModel(
              name: semesters[i],
              value: semesters[i],
            ),
          );
        }
      },
    );
    return semesterlist;
  }

  Future<List<DropDownValueModel>> getyearlist() async {
    List<String> years = [];
    List<DropDownValueModel> yearlist = [];
    await FirebaseFirestore.instance.collection("Year").get().then(
      (QuerySnapshot snapshot) {
        snapshot.docs.forEach(
          (element) {
            years.add(
              element['Year'],
            );
          },
        );
        for (int i = 0; i < years.length; i++) {
          yearlist.add(
            DropDownValueModel(
              name: years[i],
              value: years[i],
            ),
          );
        }
      },
    );
    return yearlist;
  }

  Future<List<DropDownValueModel>> getstudentenrollmentlist() async {
    List<String> studentenrollments = [];
    List<DropDownValueModel> studentenrollmentlist = [];
    await FirebaseFirestore.instance.collection("Student").get().then(
      (QuerySnapshot snapshot) {
        snapshot.docs.forEach(
          (element) {
            studentenrollments.add(
              element['Enrollment No'],
            );
            print(studentenrollments);
          },
        );
        for (int i = 0; i < studentenrollments.length; i++) {
          studentenrollmentlist.add(
            DropDownValueModel(
              name: studentenrollments[i],
              value: studentenrollments[i],
            ),
          );
        }
      },
    );
    return studentenrollmentlist;
  }

  Future<List<DropDownValueModel>> getspecificbranchstudent(
      SingleValueDropDownController department) async {
    List<String> specificbranchstudentlist = [];
    List<DropDownValueModel> dropdownvaluemodellist = [];

    await FirebaseFirestore.instance.collection('Student').get().then(
      (QuerySnapshot snapshot) {
        snapshot.docs.forEach(
          (element) {
            if (department.dropDownValue!.name == element['Branch']) {
              specificbranchstudentlist.add(
                element['Enrollment No'],
              );
            } else {
              return;
            }
          },
        );
        for (int i = 0; i < specificbranchstudentlist.length; i++) {
          dropdownvaluemodellist.add(
            DropDownValueModel(
              name: specificbranchstudentlist[i],
              value: specificbranchstudentlist[i],
            ),
          );
        }
      },
    );
    print(dropdownvaluemodellist);
    return dropdownvaluemodellist;
  }

  Future<List<String>> getlistsubjectlist(
      SingleValueDropDownController department,
      int semester,
      String studentid) async {
    List<String> subjectlist = [];

    if (department.dropDownValue != null) {
      await FirebaseFirestore.instance
          .collection('Branch')
          .doc(department.dropDownValue!.name.toString())
          .collection(semester.toString())
          .get()
          .then(
        (QuerySnapshot snapshot) {
          snapshot.docs.forEach(
            (element) {
              subjectlist.add(
                element['Subject'],
              );
            },
          );
        },
      );
    }

    // for (int i = 0; i < subjectlist.length; i++) {
    //   await FirebaseFirestore.instance
    //       .collection('Student')
    //       .doc(studentid)
    //       .collection(semester.toString())
    //       .doc(subjectlist[i])
    //       .set(
    //     {
    //       subjectlist[i].toString(): 0,
    //     },
    //   );
    // }
    print(subjectlist);
    return subjectlist;
  }

  Future<List<DropDownValueModel>> getsemesterlistforresult() async {
    List<String> semesterListForResult = [];
    List<String> semesterlistwithrange = [];
    List<DropDownValueModel> dropdownsemesterlist = [];
    await FirebaseFirestore.instance.collection('Semester').get().then(
      (QuerySnapshot snapshot) {
        snapshot.docs.forEach(
          (element) {
            semesterListForResult.add(element["Semester No"].toString());
          },
        );
      },
    );
    semesterlistwithrange =
        semesterListForResult.getRange(0, semester).toList();
    print('Semester List With Range in GetList Is ${semesterlistwithrange}');

    for (int i = 0; i < semesterlistwithrange.length; i++) {
      dropdownsemesterlist.add(
        DropDownValueModel(
          name: semesterlistwithrange[i],
          value: semesterlistwithrange[i],
        ),
      );
    }
// List<dropdownva> dropdownValueModels = semesterListForResult.map((e) => DropdownValueModel(e)).toList();
    // List semesterlistforresult = [];
    // List dropdownsemesterlistforresult = [];
    // await FirebaseFirestore.instance.collection('Semester').get().then(
    //   (QuerySnapshot snapshot) {
    //     snapshot.docs.forEach(
    //       (element) {
    //         semesterlistforresult.add(
    //           element['Semester No'],
    //         );
    //       },
    //     );
    // semesterlistforresult.getRange(1, semester);
    // semesterlistforresult.addAll(
    //   await FirebaseFirestore.instance.collection('Semester').get().then(
    //     (QuerySnapshot snapshot) {
    //       return snapshot.docs
    //           .map((doc) => doc.data())
    //           .toList()
    //           .getRange(1, min(semester, snapshot.docs.length))
    //           .toList();
    //     },
    //   ),
    // );
    // print('Semester List for Specific Student$semesterlistforresult');
    // for (int i = 0; i < semesterlistforresult.length; i++) {
    //   dropdownsemesterlistforresult.add(
    //     DropDownValueModel(
    //       name: '',
    //       value: semesterlistforresult[i],
    //     ),
    //   );
    // }
    return dropdownsemesterlist;
  }

  Future addsubjectresult(String enrollment, String semester,
      List<String> subjectlist, List<TextEditingController> marklist) async {
    for (int i = 0; i < subjectlist.length; i++) {
      print('Gor Is Already Reached Here Dont Worry.');

      FirebaseFirestore.instance
          .collection('Student')
          .doc(enrollment)
          .collection(semester)
          .doc(subjectlist[i])
          .set(
        {
          'Subject': subjectlist[i],
          'Marks': int.parse(marklist[i].text),
        },
      ).whenComplete(
        () {
          print('Also Gor Is Already Reached Here Dont Worry.');
          getlist.calculatespi(enrollment, semester);
        },
      );
    }
  }

  Future<double> calculatespi(String enrollment, String semester) async {
    double marks = 0;
    double spi = 0;
    int snapshotlength = 0;
    await FirebaseFirestore.instance
        .collection('Student')
        .doc(enrollment)
        .collection(semester)
        .get()
        .then(
      (QuerySnapshot snapshot) {
        snapshot.docs.forEach(
          (element) {
            snapshotlength = snapshot.docs.length;
            marks += element['Marks'];
          },
        );
        spi = ((marks / snapshotlength) / 10);
        print('SPI Is In GetList By Darshil Is $spi');
      },
    ).whenComplete(
      () async {
        await FirebaseFirestore.instance
            .collection('Student')
            .doc(enrollment)
            .update(
          {
            'SPI$semester': spi,
          },
        );
      },
    );
    double sumofspi = 0;
    double cpi = 0;
    await FirebaseFirestore.instance
        .collection('Student')
        .doc(enrollment)
        .get()
        .then(
      (value) {
        for (int i = 1; i <= int.parse(semester); i++) {
          sumofspi += value['SPI$i'];
          print('Sum Of Marks is In GetList $sumofspi');
        }
        ;
      },
    ).whenComplete(
      () async {
        cpi = sumofspi / int.parse(semester);
        await FirebaseFirestore.instance
            .collection('Student')
            .doc(enrollment)
            .update(
          {
            'CPI': cpi,
          },
        );
      },
    );
    print('CPI Is In GetList Is $cpi');
    print('SPI Added Successfully in GetList......');
    return spi;
  }

//   Future getrequesteddocumentlist()
//  async {
//   await FirebaseFirestore.instance.collection('Teacher').doc(uId).collection('Document Request').doc('Bonafite Certificate').

//   }
}
