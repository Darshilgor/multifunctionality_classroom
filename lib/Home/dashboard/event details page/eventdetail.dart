import 'package:flutter/material.dart';
import 'package:my_app/utils/constant/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 117),
          child: Text(eventTitle),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, style: BorderStyle.solid),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(eventCoverPhoto),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Last Date of Registration: ${eventDueDate.toString().substring(0, 10)}",
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  "Coordinator Name: $eventCoordinatorName",
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  "Coordinator Email: $eventCoordinatorEmail",
                  style: TextStyle(fontSize: 17),
                ),
                const Divider(
                  color: Colors.black,
                  height: 10,
                ),
                Text(
                  eventAbout,
                  style: TextStyle(fontSize: 19),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final Uri url = Uri.parse(eventLink!);
                      await _launchUrl(url);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
