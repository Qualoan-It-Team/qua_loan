import 'package:flutter/material.dart';
import 'package:qualoan/reusable_widgets/common_back_header.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  final String pdfUrl;

  const PdfViewerScreen({super.key, required this.pdfUrl,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize:Size(0, 90),
        child: CommonBackHeader()),
      body: SfPdfViewer.network(pdfUrl,),
    );
  }
}