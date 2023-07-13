import 'package:flutter/material.dart';
import 'package:my_app/variable.dart';

class Subject extends StatefulWidget {
  const Subject({super.key});

  @override
  State<Subject> createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(children: [
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
              },
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://media.istockphoto.com/id/589575914/photo/textbooks-stacked-on-school-desk-with-chalkboard-background.jpg?b=1&s=170667a&w=0&k=20&c=zgohXjoTYkayq33TjxTEryYJn9nojveuzNdmh25oRA0="),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.green),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
                  child: Text(
                    subject1,
                    style: TextStyle(fontSize: 28, color: Colors.black87),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Container(
              height: 180,
              width: 250,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: NetworkImage(
                          "https://media.istockphoto.com/id/185226826/photo/book-isolated.jpg?b=1&s=170667a&w=0&k=20&c=voNhKV6n-5qUtus9B9AZDxYkIsLBoQi1QUraXFEDnao="),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.green),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
                child: Text(
                  subject2,
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Container(
              height: 180,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35), color: Colors.green),
            ),
            SizedBox(
              height: 17,
            ),
            Container(
              height: 180,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35), color: Colors.green),
            ),
            SizedBox(
              height: 17,
            ),
            Container(
              height: 180,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Colors.green,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ]),
        ),
      ),
    );
  }
}
