import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PDFHelper {
  final Dio _dio = Dio();
  
  Future<void> downloadAndOpenPDF(
      String url, String fileName, BuildContext context) async {
       
    try {
      // Check storage permissions
      if (await _checkPermission(Permission.storage)) {
        // Get the application documents directory
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String savePath = '${appDocDir.path}/$fileName';
        print('pdf download location is ______________ $savePath ___________');
        // Show downloading progress indicator
        showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child:  const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                  CircularProgressIndicator(),
                  SizedBox(height: 20.0),
                  Text("Downloading PDF..."),
              
                   //   (received / total * 100).toStringAsFixed(0) + "%");
                ],
              ),
            ),
          ),
        );

        // Download the PDF file
        await _dio.download(
          url,
          savePath,
          onReceiveProgress: (received, total) {
            print((received / total * 100).toStringAsFixed(0) + "%");
            // Update progress indicator
            if (received == total) {
              Navigator.pop(
                  context); // Close the dialog when download completes
            }
          },
        );

        // Open the downloaded PDF file
        OpenFile.open(savePath);
      } else {
        // Permission denied, show a message or request again
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Permission denied. Please grant access to storage.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<bool> _checkPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      // If permission is not granted, request it
      var result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }
}
