import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/constants.dart';
import 'package:my_app/eventdetail.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        //getting event data
        stream: FirebaseFirestore.instance
            .collection("Events")
            .orderBy("Creation Time", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              //display event on decending order of creation time
              children: snapshot.data!.docs.map(
                (snap) {
                  return InkWell(
                    //display event details
                    onTap: () async {
                      eventTitle = snap["Event Name"];
                      eventCoordinatorName = snap["Coordinator Name"];
                      eventCoordinatorEmail = snap["Coordinator Email"];
                      timestamp = snap["Due Date"];
                      eventDueDate = timestamp?.toDate();
                      eventAbout = snap["About"];
                      eventLink = snap["Link"];
                      eventCoverPhoto = snap["Cover Photo"];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetails(),
                        ),
                      );
                    },
                    child: Padding(
                      //event cover photo and title
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      child: Container(
                        height: 170,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            opacity: 0.7,
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              snap["Cover Photo"],
                            ),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20),
                          child: Text(
                            snap["Event Name"],
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
