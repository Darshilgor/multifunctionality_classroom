import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:my_app/utils/constant/constants.dart';

class DownloadDocument extends StatefulWidget {
  const DownloadDocument({super.key});

  @override
  State<DownloadDocument> createState() => _DownloadDocumentState();
}

class _DownloadDocumentState extends State<DownloadDocument> {
  SingleValueDropDownController documentcontroller =
      SingleValueDropDownController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download document'),
        centerTitle: true,
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
            if (documentcontroller.dropDownValue != null)
              ElevatedButton(
                onPressed: () async {
                  var downloadurl = await FirebaseStorage.instance
                      .ref()
                      .child(
                          "pdfs/documents/${documentcontroller.dropDownValue!.name.toString()}/$branch/$className/${documentcontroller.dropDownValue!.name}_${uId}.pdf")
                      .getDownloadURL();
                  if (downloadurl.isNotEmpty) {
                    FileDownloader.downloadFile(
                      url: downloadurl.toString(),
                      name: '${documentcontroller.dropDownValue!.name}_$uId',
                      onDownloadError: (errorMessage) {
                        print(errorMessage.toString());
                      },
                      onDownloadCompleted: (path) {
                        print(path);
                      },
                      onProgress: (fileName, progress) {
                        Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  } else {
                    Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
                child: Text(
                  'Download Document',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget showdropdown() {
    return DropDownTextField(
      onChanged: (value) {
        setState(() {});
      },
      isEnabled: true,
      dropDownList: [
        DropDownValueModel(name: 'Admission Latter', value: 'Admission Latter'),
        DropDownValueModel(
            name: 'Bonafite Certificate', value: 'Bonafite Certificate'),
      ],
      controller: documentcontroller,
      dropDownItemCount: 5,
      dropdownRadius: 10,
      textFieldDecoration: InputDecoration(
        labelText: 'Select Document',
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

    // return semestercontroller.text.toString();
  }
}
