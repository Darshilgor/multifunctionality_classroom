import 'package:flutter/material.dart';
import 'package:my_app/utils/constant/getlist.dart';

class TeacherCorner extends StatefulWidget {
  const TeacherCorner({super.key});

  @override
  State<TeacherCorner> createState() => _TeacherCornerState();
}

class _TeacherCornerState extends State<TeacherCorner> {
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
      body: Column(
        children: [
        ],
      ),
    );
  }

  // requestoflistofstudent() async {
  //   return FutureBuilder(
  //     future: getlist.getdocumentrequestlist(),
  //     builder: (context, future) {
  //       if (future.hasData) {}

  //       return Text("data");
  //     },
  //   );
  // }
}
