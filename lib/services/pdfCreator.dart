import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfCreator {
  final pdf = pw.Document();

  writeUserDataToPDF(var user) {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: <pw.Widget>[
                    pw.Text('Account data', textScaleFactor: 2),
                  ])),
          pw.Header(level: 1, text: 'UserId'),
          pw.Paragraph(text: '${user.get('userId').toString()}'),
          pw.Header(level: 1, text: 'DoctorId'),
          pw.Paragraph(text: '${user.get('doctor_id').toString()}'),
          pw.Header(level: 1, text: 'Name'),
          pw.Paragraph(text: '${user.get('name').toString()}'),
          pw.Header(level: 1, text: 'Surname'),
          pw.Paragraph(text: '${user.get('surname').toString()}'),
          pw.Header(level: 1, text: 'Pesel'),
          pw.Paragraph(text: '${user.get('pesel').toString()}'),
          pw.Header(level: 1, text: 'Phone number'),
          pw.Paragraph(text: '${user.get('phoneNumber').toString()}'),
          pw.Header(level: 1, text: 'Email'),
          pw.Paragraph(text: '${user.get('email').toString()}'),
          pw.Header(level: 1, text: 'Role'),
          pw.Paragraph(text: '${user.get('role').toString()}'),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
        ];
      },
    ));
  }

  Future saveUserDataToPDF(var user) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("${documentPath}/${user.get('userId').toString()}.pdf");
    file.writeAsBytesSync(await pdf.save());
  }

  writePrescriptionToPDF(var prescription) {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: <pw.Widget>[
                    pw.Text('Prescription data', textScaleFactor: 2),
                  ])),
          pw.Header(level: 1, text: 'PrescriptionId'),
          pw.Paragraph(
              text: '${prescription.get('prescription_id').toString()}'),
          pw.Header(level: 1, text: 'Diagnosis'),
          pw.Paragraph(text: '${prescription.get('diagnosis').toString()}'),
          pw.Header(level: 1, text: 'Description'),
          pw.Paragraph(text: '${prescription.get('description').toString()}'),
        ];
      },
    ));
  }

  Future savePrescriptionToPDF(var prescription) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File(
        "${documentPath}/prescription_${prescription.get('prescription_id').toString()}.pdf"); //
    file.writeAsBytesSync(await pdf.save());
  }
}
