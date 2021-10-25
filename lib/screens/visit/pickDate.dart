import 'package:clinico/screens/visit/widget/pickdate.dart';
import 'package:clinico/style/colors.dart';
import 'package:flutter/material.dart';

class PickDate extends StatefulWidget {

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

  String getDateText(){
    if(date == null){
      return 'Select Date';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }

  String getTimeText(){
    if(time == null){
      return 'Select Time';
    } else {
      final hours = time.hour.toString().padLeft(2,'0');
      final minutes = time.minute.toString().padLeft(2,'0');
      return '${hours}:${minutes}';
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
              // Navigator.push(
              // context,
              // MaterialPageRoute(builder: (context) => PickDate(),));
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
          ButtonHeaderWidget(
            title: 'Date',
            text: getDateText(),
            onClicked: () => pickDate(context)
          ),
          ButtonHeaderWidget(
            title: 'Time',
            text: getTimeText(),
            onClicked: () => pickTime(context)
          ),
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


  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context, initialDate: date ?? initialDate, firstDate: DateTime(DateTime.now().year -5 ), lastDate: DateTime(DateTime.now().year +5) 
      );
    if(newDate == null) return;
    setState(() {
          date = newDate;
        });
  } 

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(context: context,initialTime: time ?? initialTime);
    if(newTime == null) return;
    setState(() {
          time = newTime;
        });
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

