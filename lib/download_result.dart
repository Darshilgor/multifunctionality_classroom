import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Download_Result extends StatefulWidget {
  const Download_Result({super.key});

  @override
  State<Download_Result> createState() => _Download_DResult();
}

class _Download_DResult extends State<Download_Result> {
  String _downloadStatus = '';
  Future<void> _downloadDocument() async {
    Future<void> _downloadPDF() async {
      // Obtain the download URL of the PDF file from Google Cloud Storage
      String pdfUrl =
          'https://storage.googleapis.com/myapp-2bd7a.appspot.com/images/Profile/StudentProfilePhoto/CS_43.pdf';

      try {
        // Download the PDF file data from the URL
        http.Response response = await http.get(Uri.parse(pdfUrl));

        // Define the directory where you want to save the downloaded PDF file
        Directory directory = await getApplicationDocumentsDirectory();
        String savePath = '${directory.path}/document.pdf';

        // Save the downloaded PDF file data to a file on the local device
        File pdfFile = File(savePath);
        pdfFile.writeAsBytesSync(response.bodyBytes);

        setState(() {
          _downloadStatus = 'PDF downloaded successfully';
        });
      } catch (e) {
        print('Error downloading PDF: $e');
        setState(() {
          _downloadStatus = 'Error downloading PDF: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download Result'),
        centerTitle: true,
      ),
      body: ElevatedButton(
          onPressed: () {
            _downloadDocument();
          },
          child: Text('Donwload result')),
    );
  }
}
