import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/pdf_section_cubit.dart';
import 'view_pdf.dart';

class ScreenCreatePdfDocument extends StatelessWidget {
  const ScreenCreatePdfDocument({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PdfSectionCubit(context),
      child: BlocBuilder<PdfSectionCubit, PdfSectionState>(
        builder: (context, state) {
          var cubit = context.read<PdfSectionCubit>();
          return Scaffold(
            body: Center(
              child: TextButton(onPressed: () => viewPDF(context), child: Text('Create Pdf')),
            ),
          );
        },
      ),
    );
  }
}
