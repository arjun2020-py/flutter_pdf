import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ScreenPdfViwer extends StatefulWidget {
  const ScreenPdfViwer({super.key});

  @override
  State<ScreenPdfViwer> createState() => _ScreenPdfViwerState();
}

class _ScreenPdfViwerState extends State<ScreenPdfViwer> {
  final PdfViewerController pdfViewerController = PdfViewerController();
  //convert pdf  file to  the  
  Uint8List? pdfBytes;

  Future<void> openPdfFile() async {
    //pick pdf  file only from  our mobile
    FilePickerResult? filePickerResult = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (filePickerResult != null) {
      if (kIsWeb) {
        pdfBytes = filePickerResult.files.single.bytes;
      } else {
        pdfBytes =
            await File(filePickerResult.files.single.path!).readAsBytesSync();
      }
    }
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [ElevatedButton(onPressed: ()=> openPdfFile(), child: Text('open pdf'))],
      ),
      body: pdfBytes !=null ? SfPdfViewer.memory(pdfBytes!,controller: pdfViewerController,):
      Center(child: Text('choose  file  from device '),)
    );
  }
}
