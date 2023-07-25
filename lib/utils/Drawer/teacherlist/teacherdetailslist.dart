import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeacherDetailsList extends StatefulWidget {
  final String teacherid;
  const TeacherDetailsList({super.key, required this.teacherid});

  @override
  State<TeacherDetailsList> createState() => _TeacherDetailsListState();
}

class _TeacherDetailsListState extends State<TeacherDetailsList> {
  // final String firstname='';
  // final String firstname='';
  // final String firstname='';

  @override
  void initState() {
    super.initState();
    getteacherdetailslist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Teachers Details",
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }

  Future getteacherdetailslist() async {
    return FirebaseFirestore.instance.collection("Teacher").doc(
          widget.teacherid,
        ).get().then((value) => {

        });
  }
}
