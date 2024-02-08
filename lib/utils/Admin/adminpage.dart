import 'package:flutter/material.dart';
import 'package:my_app/utils/Admin/Admin%20Pages/addevent.dart';
import 'package:my_app/utils/Admin/Admin%20Pages/createupdateclass.dart';
import 'package:my_app/utils/Admin/Admin%20Pages/createupdatestudent.dart';
import 'package:my_app/utils/Admin/Admin%20Pages/createupdateteacher.dart';
import 'package:my_app/utils/Admin/Admin%20Pages/enterresult.dart';
import 'package:my_app/utils/Admin/Admin%20Pages/updateevent.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<String> admintext = [
    'Create Teacher',
    'Update Teacher',
    'Create Student',
    'Update Student',
    'Create Event',
    'Update Event',
    'Create Class',
    'Update Class',
    'Enter Result',
  ];
  List adminicon = [
    const Icon(
      Icons.add,
      size: 50,
    ),
    const Icon(
      Icons.add,
      size: 50,
    ),
    const Icon(
      Icons.add,
      size: 50,
    ),
    const Icon(
      Icons.add,
      size: 50,
    ),
    const Icon(
      Icons.add,
      size: 50,
    ),
    const Icon(
      Icons.add,
      size: 50,
    ),
    const Icon(
      Icons.add,
      size: 50,
    ),
    const Icon(
      Icons.add,
      size: 50,
    ),
    const Icon(
      Icons.add,
      size: 50,
    ),
  ];
  List<Widget> createupdatepagelist = [
    const CreateUpdateTeacher(title: 'Create Teacher'),
    const CreateUpdateTeacher(title: 'Update Teacher'),
    CreateUpdateStudent(title: 'Create Student'),
    CreateUpdateStudent(title: 'Update Student'),
    AddEvent(title: 'Create Event'),
    UpdateEvent(title: 'Update Event'),
    CreateUpdateClass(title: 'Create Class'),
    CreateUpdateClass(title: 'Update Class'),
    EnterResult(title: 'Enter Result'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(
            left: 95,
          ),
          child: Text('Admin Page'),
        ),
      ),
      //define admin page item using gridview builder
      body: GridView.builder(
        itemCount: admintext.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Container(
            child: buildbox(
              admintext[index],
              adminicon[index],
              createupdatepagelist[index],
            ),
          );
        },
      ),
    );
  }

  //design of gridview button
  Widget buildbox(
    String admintext,
    Icon adminicon,
    Widget createupdatepagelist,
  ) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => createupdatepagelist,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                width: 1, color: Colors.black, style: BorderStyle.solid),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 45,
              ),
              adminicon,
              const SizedBox(
                height: 30,
              ),
              Text(
                admintext,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
