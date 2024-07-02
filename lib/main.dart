import 'package:flutter/material.dart';

import 'screen/pdf_section/view_pdf.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PDF Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => viewPDF(context),
          child: Text('Generate and View PDF'),
        ),
      ),
    );
  }
}
