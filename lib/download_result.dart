import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:my_app/utils/constant/constants.dart';

class DownloadPDFScreen extends StatefulWidget {
  const DownloadPDFScreen({super.key});

  @override
  State<DownloadPDFScreen> createState() => _DownloadPDFScreenState();
}

class MyTickerProvider implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}

class _DownloadPDFScreenState extends State<DownloadPDFScreen> {
  SingleValueDropDownController semestercontroller =
      SingleValueDropDownController();

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          10,
        ),
        child: Column(
          children: [
            showdropdown(),
            SizedBox(
              height: 20,
            ),
            if (semestercontroller.dropDownValue != null)
              ElevatedButton(
                onPressed: () async {
                 
                  var downloadurl = await FirebaseStorage.instance
                      .ref()
                      .child(
                          "pdfs/results/$branch/$className/$uId/${semestercontroller.dropDownValue!.name}.pdf")
                      .getDownloadURL();

                  if (downloadurl.isNotEmpty) {
                      FileDownloader.downloadFile(
                        url: downloadurl.toString(),
                        name:
                            '${semestercontroller.dropDownValue!.name}_result',
                        onDownloadError: (errorMessage) {
                          print(errorMessage.toString());
                        },
                        onDownloadCompleted: (path) {
                          print(path);
                        },
                        onProgress: (fileName, progress) {
                         Center(child: CircularProgressIndicator(),);
                        },
                      );
                  } else {
                    
                    Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
                child: Text(
                  'Download Result',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget showdropdown() {
    List<DropDownValueModel> list = [];
    return FutureBuilder(
      future: getlist.getsemesterlistforresult(),
      builder: (context, future) {
        if (future.hasData) {
          list = future.data!;
          return DropDownTextField(
            onChanged: (value) {
              setState(() {});
            },
            isEnabled: true,
            dropDownList: list,
            controller: semestercontroller,
            dropDownItemCount: 5,
            dropdownRadius: 10,
            textFieldDecoration: InputDecoration(
              labelText: 'Select Semester',
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

    // return semestercontroller.text.toString();
  }
}


// body: ElevatedButton(
//     onPressed: () {
//       FileDownloader.downloadFile(
//         url:
//             'https://firebasestorage.googleapis.com/v0/b/myapp-2bd7a.appspot.com/o/images%2FProfile%2FStudentProfilePhoto%2FCS_43.pdf?alt=media&token=67cb0aab-555f-4178-926d-fcbc321464f3',
//         onDownloadError: (errorMessage) {
//           print(errorMessage.toString());
//         },
//         onDownloadCompleted: (path) {
//           print('object objectobjectobject object ');
//           File file=File(path);
//           print('file path is in downlaod resutl is $file');
//         },
//       );
//     },
//     child: Text('data')),
