
// ignore_for_file: library_private_types_in_public_api

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';


enum SelectMedication { yes, no }
class AppointmentScreen extends StatefulWidget {
  final String mobile;
  final String memberId;
  const AppointmentScreen({
    required this.mobile,
    required this.memberId,
    Key? key,
  }) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}


class _AppointmentScreenState extends State<AppointmentScreen> {
  final List<String> names = <String>['Apt Date Time-'];
  final List<String> dosg = <String>['Apt Id'];
  final List<String> place = <String>['Clinic'];
  final List<int> msgCount = <int>[2];

final items = List<ListItem>.generate(
  1000,
  (i) => i % 6 == 0
      ? HeadingItem('Heading $i')
      : MessageItem('Sender $i', 'Message body $i'),
);

  TextEditingController nameController = TextEditingController();
  final _dateTimeCtrl = TextEditingController();
  final _dateTimeCtrl1 = TextEditingController();
  DateTime _dateTime = DateTime.now();
  final formDateTime = DateTime.now();
  final toTimeTo = DateTime.now();
   void addItemToList(){
    setState(() {
     names.insert(1,'2024/03/24');
     
     // dosg.insert(0,dose['value'].toString());

      //msgCount.insert(0, 0);
    });
  }
 /*() void addItemToList(){
    setState(() {
      
      
      names.insert(0,'2024/03/24');
      dosg.insert(0,'Applo Clinic');
        names.insert(1,'2024/03/24');
      dosg.insert(1,'Applo Clinic');
     
     // dosg.insert(0,dose['value'].toString());

      //msgCount.insert(0, 0);
    });
  }*/
    Future _selectDatetime() async {
    DateTime? date = await _pickDate();
    if (date == null) return; // pressed CANCEL
    TimeOfDay? time = await _pickTime();
    if (time == null) return; // pressed CANCEL
    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    //DateFormat('hh:mm a').format(dateTime);
    _dateTimeCtrl.text =
        '${dateTime.year}-${dateTime.month}-${dateTime.day} $formDateTime';
    setState(() => _dateTime = dateTime);
  }
     // ignore: unused_element
    Future _selectDatetimeTo() async {
    DateTime? date = await _pickDate();
    if (date == null) return; // pressed CANCEL
    TimeOfDay? time = await _pickTime();
    if (time == null) return; // pressed CANCEL
    final dateTime1 = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    //DateFormat('hh:mm a').format(dateTime);
    _dateTimeCtrl1.text =
        '${dateTime1.year}-${dateTime1.month}-${dateTime1.day} $toTimeTo';
    setState(() => _dateTime = dateTime1);
  }
    //
  Future<DateTime?> _pickDate() => showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );
  //
  Future<TimeOfDay?> _pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: _dateTime.hour, minute: _dateTime.minute),
      );
  //
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Manage Your Appointment'),
      ),
      body: Column(
        children: <Widget>[
                   InkWell(
        onTap: _selectDatetime,
        child: IgnorePointer(

           child: TextFormField(
            controller: _dateTimeCtrl,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.only(
                left: 5,
                right: 6,
                bottom: 12,
                top: 12,
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              hintText: 'Form Date',
              //counterText: '30 characters',
              //suffixIcon: const Icon(
            //   Icons.date_range_outlined,
            //  ),
            ),
          ),
           
        ),
      ),

            const SizedBox(
              height: 10,
            ),
             InkWell(
              onTap: _selectDatetimeTo,
              child: IgnorePointer(
                
                child: TextFormField(
                  controller: _dateTimeCtrl1,
              decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.only(
                left: 5,
                right: 6,
                bottom: 12,
                top: 12,
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              hintText: 'To Date',
              //counterText: '30 characters',
              //suffixIcon: const Icon(
            //   Icons.date_range_outlined,
            //  ),
            ),
            
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
              ElevatedButton.icon(
                onPressed: () {
                   //_selectDate(context);
                   addItemToList();
                },
                 icon: Icon(Icons.show_chart),
                label: Text('Show'),
              ),
 
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: names.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  margin: EdgeInsets.all(2),
                  color: msgCount[index]>=10? Colors.blue[400]:
                    msgCount[index]>3? Colors.blue[100]: const Color.fromARGB(255, 221, 111, 111),
                  child: Center(
                 
                      child: Text('${names[index]} (${dosg[index]})'
                     // style: TextStyle(fontSize: 18),
                    )
                  ),
                );
              }
            )
          )
        ]
      )
    );
  }
  /// The base class for the different types of items the list can contain.

}
/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}
/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}
