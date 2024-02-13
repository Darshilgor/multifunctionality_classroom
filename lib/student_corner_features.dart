import 'package:flutter/material.dart';
import 'package:my_app/check_result.dart';
import 'package:my_app/college_fee.dart';
import 'package:my_app/download_document.dart';
import 'package:my_app/download_result.dart';
import 'package:my_app/exam_fee.dart';
import 'package:my_app/request_document.dart';

class StudetnCornerFeatures extends StatefulWidget {
  const StudetnCornerFeatures({super.key});

  @override
  State<StudetnCornerFeatures> createState() => _StudetnCornerFeaturesState();
}

class _StudetnCornerFeaturesState extends State<StudetnCornerFeatures> {
  List<String> textlist = [
    'Check Result',
    'Download Result',
    'Pay College Fee',
    'Pay Exam Fee',
    'Request Document',
    'Download Document'
  ];
  List<Widget> gotopagelist = [
    Check_Result(),
    DownloadPDFScreen(),
    College_Fee(),
    Exam_fee(),
    Request_Document(),
    DownloadDocument()
  ];
  List iconlist = [
    Icon(Icons.add),
    Icon(Icons.add),
    Icon(Icons.add),
    Icon(Icons.add),
    Icon(Icons.add),
    Icon(Icons.add),
    Icon(Icons.add),
    Icon(Icons.add),
    Icon(Icons.add),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Features",
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Column(
            children: [
              boxes(textlist[index], gotopagelist[index], iconlist[index]),
            ],
          );
        },
      ),
    );
  }

  boxes(String textlist, Widget gotopagelist, iconlist) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => gotopagelist,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ),
            border: Border.all(
              color: Colors.black,
              style: BorderStyle.solid,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconlist,
              SizedBox(
                height: 10,
              ),
              Text(
                textlist,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
