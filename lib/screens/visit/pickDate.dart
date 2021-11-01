import 'package:clinico/screens/visit/visitone.dart';
import 'package:clinico/screens/visit/widget/pickdate.dart';
import 'package:clinico/style/colors.dart';
import 'package:flutter/material.dart';
import 'categoryDoctors.dart';
import 'doctors.dart';

class PickDate extends StatefulWidget {

  List<Doctor> doctors;
  List<Category> categories;

  PickDate({this.doctors,this.categories});
  @override
  _PickDateState createState() => _PickDateState();
}

class _PickDateState extends State<PickDate> {

  DateTime date;
  TimeOfDay time;
  DateTimeRange dataRange;

  String getFrom() {
    if(dataRange == null){
      return 'From';
    } else {
      return '${dataRange.start.month}/${dataRange.start.day}/${dataRange.start.year}';
    }
  }

  String getUntil() {
    if(dataRange == null){
      return 'Until';
    } else {
      return '${dataRange.end.month}/${dataRange.end.day}/${dataRange.end.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColors.steelTeal,
      appBar: AppBar(
        backgroundColor: MyColors.darkSkyBlue,
        elevation: 0.0,
        title: Text("3/4 Pick a Date you want"),
        actions: [
          TextButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty. all(MyColors.mountainMeadow),
            ),
            onPressed: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VisitOne(doctors: widget.doctors,categories: widget.categories,)));
              },
            child: Text(
              'Go Next',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            )
          ),
        ],
      ),
      body:Column(
        children: [
          HeaderWidget(title: 'Date Range',
          child: Row (children: [
            Expanded(
            child :ButtonWidget(text: getFrom(), onClicked: () => pickDateRange(context))),
            const SizedBox(width: 8,),
            Icon(Icons.arrow_forward,color: Colors.white,),
            const SizedBox(width: 8,),
            Expanded(
            child: ButtonWidget(text: getUntil(), onClicked: () => pickDateRange(context))),
          ],)),
        ],
      ),
    );
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(start: DateTime.now(), end: DateTime.now().add(Duration(hours: 24*3)));
    final newDateRange = await showDateRangePicker(context: context, firstDate: DateTime(DateTime.now().year-5), lastDate: DateTime(DateTime.now().year+5),initialDateRange:dataRange ?? initialDateRange);
    if (newDateRange == null) return;
    setState(() {
          dataRange = newDateRange;
        });
  }
}

