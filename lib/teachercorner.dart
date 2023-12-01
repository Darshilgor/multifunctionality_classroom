import 'package:flutter/material.dart';

class TeacherCorner extends StatefulWidget {
  const TeacherCorner({super.key});

  @override
  State<TeacherCorner> createState() => _TeacherCornerState();
}

class _TeacherCornerState extends State<TeacherCorner> {
  List<String> documentlist = ['Bonafite Certificate', 'Admission Later'];
  String selectediteam = 'Select Document Name';
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
          SizedBox(
            height: 10,
          ),
          selectdocumentdropdown(),
        ],
      ),
    );
  }

  selectdocumentdropdown() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.06,
        padding: EdgeInsets.all(
          15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: DropdownButton<String>(
          value: selectediteam,
          onChanged: (newValue) {
            setState(() {
              selectediteam = newValue!;
            });
          },
          items: <String>['Select iteam', 'iteam1', 'iteam2']
              .map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
