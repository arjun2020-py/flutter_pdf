import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
part 'pdf_section_state.dart';

class PdfSectionCubit extends Cubit<PdfSectionState> {
  PdfSectionCubit(this.context) : super(PdfSectionInitial());

  BuildContext context;

  //1)  create  pdf  dcoument  in flutter

  Future<void> createPdf() async {
    // create  new  pdf  dcoument
    PdfDocument document = PdfDocument();

    //add new page and draw  text
    document.pages
        .add()
        .graphics
        .drawString('Hello Medq', PdfStandardFont(PdfFontFamily.helvetica, 20),
            brush: PdfSolidBrush(
              PdfColor(0, 0, 0),
            ),
            bounds: Rect.fromLTWH(0, 0, 500, 50));

    //save the document
    List<int> bytes = await document.save();

    // dispose  the  document

    document.dispose();
  }

  //2) create and  open  pdf document  in  mobile

  Future<void> createOpenPdf() async {
    print('_____________________p1');
    // create  a new  pdf  document
    PdfDocument document = PdfDocument();

    print('_____________________p2');

    //add  new  page  and  draw text

    document.pages.add().graphics.drawString(
        'Hello Medq', PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: Rect.fromLTWH(0, 0, 400, 50));
    // //add  new page and  draw the image.
    // document.pages.add().graphics.drawImage(
    //     PdfBitmap(File('assets/images/doctor-1.png').readAsBytesSync()),
    //     Rect.fromLTWH(0, 0, 400, 50));

    print('_____________________p3');

    //save  the document
    List<int> bytes = await document.save();

    //disose  the  document
    document.dispose();

    //Get the external storage
    final dictory = await getApplicationSupportDirectory();

    //Create dictory path
    final path = dictory.path;

    print('file path ====== $path ================');

    //Create a empty file to write pdf data
    File file = File('$path/Output.pdf');

    //Write  pdf data
    await file.writeAsBytes(bytes, flush: true);

    //open pdf document in mbile
    OpenFile.open('$path/Output.pdf');
  }
  //3) create sample pdf document

  Future<Uint8List> createPDF() async {
    // Create a new PDF document.
    final PdfDocument document = PdfDocument();

    // Add a page to the document.
    final PdfPage page = document.pages.add();

    // Create a PDF graphics object.
    final PdfGraphics graphics = page.graphics;

    // Create a PDF font object.
    final PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 12);

    // Draw text on the PDF page.
    graphics.drawString('Hello World!', font,
        bounds: const Rect.fromLTWH(0, 0, 200, 20));

    // Draw a rectangle.
    graphics.drawRectangle(
        bounds: const Rect.fromLTWH(0, 30, 200, 20),
        pen: PdfPen(PdfColor(255, 0, 0)));

    // Draw an ellipse.
    graphics.drawEllipse(Rect.fromLTWH(0, 60, 200, 20),
        pen: PdfPen(PdfColor(0, 255, 0)));

    // Draw an image.
    final ByteData data = await rootBundle.load('assets/flutter_logo.png');
    final Uint8List bytes = data.buffer.asUint8List();
    final PdfBitmap image = PdfBitmap(bytes);
    graphics.drawImage(image, const Rect.fromLTWH(0, 90, 100, 100));

    // Save the document.
    final List<int> bytesList = await document.save();
    document.dispose();

    // Return the bytes of the PDF document.
    return Uint8List.fromList(bytesList);
  }



}
