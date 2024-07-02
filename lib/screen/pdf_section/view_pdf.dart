import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'pdf_viwer_page.dart';

void viewPDF(BuildContext context) async {
  Future<Uint8List> createPDF() async {
    String email = 'unkown@gmail.com';
    // Create a new PDF document.
    final PdfDocument document = PdfDocument();

    // Add a page to the document.
    final PdfPage page = document.pages.add();

    // Create a PDF graphics object.
    final PdfGraphics graphics = page.graphics;

    // Create a PDF font object.
    final PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 20);
    final PdfFont font0 = PdfStandardFont(PdfFontFamily.helvetica, 14,
        style: PdfFontStyle.regular);

    //1) Draw text on the PDF page.

    // graphics.drawString('Hello World', font,
    //     bounds: const Rect.fromLTWH(0, 0, 200, 30));

    //2)  Draw a rectangle.

    // graphics.drawRectangle(
    //     bounds: const Rect.fromLTWH(0, 30, 200, 20),
    //     pen: PdfPen(PdfColor(255, 0, 0)));

    // Draw an ellipse.

    // graphics.drawEllipse(Rect.fromLTWH(0, 60, 200, 20),
    //     pen: PdfPen(PdfColor(0, 255, 0)));

    // Draw an image.
    final ByteData data = await rootBundle.load('assets/images/doctor-1.png');
    final Uint8List bytes = data.buffer.asUint8List();
    final PdfBitmap image = PdfBitmap(bytes);
    graphics.drawImage(image, const Rect.fromLTWH(0, 30, 80, 80));

    graphics.drawString('KUMARAKOM', font,
        bounds: const Rect.fromLTWH(350, 50, 200, 30));

    graphics.drawString('kottayam,kerala ', font0,
        bounds: Rect.fromLTWH(350, 80, 200, 30));

    graphics.drawString('email ', font0,
        bounds: Rect.fromLTWH(350, 100, 200, 30));
    graphics.drawString('unkown@gmail.com', font0,
        bounds: Rect.fromLTWH(390, 100, 200, 30));

    //Draw a line on PDF document
    graphics.drawLine(
    PdfPen(PdfColor(165, 42, 42), width: 5),
    Offset(10, 100),
    Offset(10, 100));
    // Save the document.
    final List<int> bytesList = await document.save();
    document.dispose();

    // Return the bytes of the PDF document.
    return Uint8List.fromList(bytesList);
  }

  Future<void> savePDF() async {
    final Uint8List pdfData = await createPDF();
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/output.pdf';
    final File file = File(path);
    await file.writeAsBytes(pdfData, flush: true);
  }

  final Uint8List pdfData = await createPDF();
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PDFViewerPage(pdfData: pdfData),
    ),
  );
}
