import 'package:flutter/material.dart';

class ContenctAdmin extends StatefulWidget {
  const ContenctAdmin({super.key});

  @override
  State<ContenctAdmin> createState() => _ContenctAdminState();
}

class _ContenctAdminState extends State<ContenctAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text("Contenct Admin"),
        ),
      ),
    );
  }
}
