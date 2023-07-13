import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEvent extends StatefulWidget {
  final String title;
  const AddEvent({super.key, required this.title});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController eventnamecontroller = TextEditingController();
  TextEditingController cordinatornamecontroller = TextEditingController();
  TextEditingController cordinatormailcontroller = TextEditingController();
  TextEditingController aboutcontroller = TextEditingController();
  TextEditingController linkcontroller = TextEditingController();
  DateTime dateTime = DateTime.now();
  String lableDate = "";
  DateTime? date;
  bool _link = false;
  File? _imagefile;
  String _photoUrl = "";
  DateTime? _duedate = DateTime.now();

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 90),
          child: Text("Add Event"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: eventnamecontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Event Name";
                  }
                  return null;
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
                  label: const Text("Event Name"),
                  labelStyle: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: cordinatornamecontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Cordinator Name";
                  }
                  return null;
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
                  label: const Text("Cordinator Name"),
                  labelStyle: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: cordinatormailcontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Cordinator Email";
                  }
                  return null;
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
                  label: const Text("Cordinator Email"),
                  labelStyle: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                    "Choose Date:",
                    style: TextStyle(fontSize: 23),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.7,
                            style: BorderStyle.solid,
                            color: Colors.black),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15)),
                    alignment: Alignment.bottomLeft,
                    // width: 220,
                    width: MediaQuery.of(context).size.width * 0.53,
                    height: 50,
                    child: MaterialButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        "${dateTime.day}-${dateTime.month}-${dateTime.year}",
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutcontroller,
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Event Information";
                  }
                  return null;
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
                  label: const Text(
                    "About Event",
                  ),
                  labelStyle: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                leading: Icon(Icons.link),
                title: Text(
                  "Regestration Link",
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Switch.adaptive(
                  value: _link,
                  onChanged: (value) => setState(
                    () {
                      _link = value;
                    },
                  ),
                ),
              ),
              Visibility(
                visible: _link,
                child: TextFormField(
                  controller: linkcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Event Link";
                    }
                    return null;
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
                    label: const Text(
                      "Event Link",
                    ),
                    labelStyle: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: _imagefile != null
                              ? FileImage(File(_imagefile!.path))
                                  as ImageProvider
                              : AssetImage("assets/upload_image.webp"),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        btn(context, Icons.cancel, "Remove", remove),
                        btn(context, Icons.upload, "Upload", upload),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      btnn("Clear"),
                      btnn("Submit"),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  remove() {
    setState(
      () {
        _imagefile = null;
      },
    );
  }

  Future upload() async {
    final pickedfile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      setState(() {
        _imagefile = File(pickedfile.path);
      });
    }
  }

  btn(context, IconData icon, String lable, Function function) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 44.5,
            ),
            InkWell(
              onTap: () async {
                await function();
              },
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(icon), Text(lable)],
                ),
              ),
            ),
          ],
        ),
      ],
    );
    // );
  }

  btnn(String buttontext) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                if (buttontext == "Clear")
                  clear();
                else if (buttontext == "Submit") submiteventdetail();
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      buttontext,
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then(
      (value) {
        setState(() {
          dateTime = value!;
        });
      },
    );
  }

  Future submit() async {
    try {
      final file = File(_imagefile!.path);

      final storageRef = FirebaseStorage.instance.ref().child(
          'images/Events/CoverPhotos/${eventnamecontroller.text.toString()}');
      storageRef.putFile(file).whenComplete(
        () async {
          _photoUrl = await FirebaseStorage.instance
              .ref()
              .child(
                  'images/Events/CoverPhotos/${eventnamecontroller.text.toString()}')
              .getDownloadURL();
        },
      ).then(
        (value) async => await set(),
      );
    } catch (e) {
      ScaffoldMessenger(
        child: Text("Error"),
      );
    }
  }

  set() async {
    await FirebaseFirestore.instance
        .collection('Events')
        .doc(eventnamecontroller.text)
        .set(
      {
        "Creation Time": Timestamp.now(),
        "Event Name": eventnamecontroller.text,
        "Coordinator Name": cordinatornamecontroller.text,
        "Coordinator Email": cordinatormailcontroller.text,
        "Due Date": _duedate,
        "About": aboutcontroller.text,
        "Link": _link ? linkcontroller.text : null,
        "Cover Photo": _photoUrl,
      },
    ).whenComplete(
      () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('New Event Created'),
          ),
        );
      },
    );
  }

  clear() {
    setState(() {
      eventnamecontroller.clear();
      cordinatornamecontroller.clear();
      cordinatormailcontroller.clear();
      aboutcontroller.clear();
      linkcontroller.clear();
      dateTime = _duedate!;
    });
  }

  submiteventdetail() {
    try {
      final file = File(_imagefile!.path);

      final storageRef = FirebaseStorage.instance.ref().child(
          'images/Events/CoverPhotos/${eventnamecontroller.text.toString()}');
      storageRef.putFile(file).whenComplete(
        () async {
          _photoUrl = await FirebaseStorage.instance
              .ref()
              .child(
                  'images/Events/CoverPhotos/${eventnamecontroller.text.toString()}')
              .getDownloadURL();
        },
      ).then(
        (value) async => await set(),
      );
    } catch (e) {
      ScaffoldMessenger(
        child: Text("Error"),
      );
    }
  }
}
