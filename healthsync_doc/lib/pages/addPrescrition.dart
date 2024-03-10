
// ignore_for_file: library_private_types_in_public_api

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';


enum SelectMedication { yes, no }
class RecordAddPage extends StatefulWidget {
  final String mobile;
  final String memberId;
  const RecordAddPage({
    required this.mobile,
    required this.memberId,
    Key? key,
  }) : super(key: key);

  @override
  State<RecordAddPage> createState() => _RecordAddPageState();
}

class _RecordAddPageState extends State<RecordAddPage> {
  final _addRecordFormKey = GlobalKey<FormState>();


  // select medication
  SelectMedication _medication = SelectMedication.yes;
  // select member
  String? _selectMember;
  // select measurement
  String? _selectMeasurement;

  // datetime
  DateTime _dateTime = DateTime.now();

  // controllers

  final  _sResonCtrl = TextEditingController();
  final _sBPCtrl = TextEditingController();
  final _dBPCtrl = TextEditingController();
  final _heartRateCtrl = TextEditingController();
  final _bloodGlucoseCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _waistCtrl = TextEditingController();
  final _dateTimeCtrl = TextEditingController();

  // data
  List<dynamic> _membersData = [];

  final List<String> _measurementScale = [
    'Before Breakfast',
    'After Breakfast',
    'Before Lunch',
    'After Lunch',
    'Before Dinner',
    'After Dinner',
    'Bedtime',
    'Random',
  ];

  //
  double _calculatedBMI = 0.0;
  String _resultBMI = '';

  // check if page is loaded
  bool _isPageLoaded = true;

  // has internet
  late StreamSubscription internetSubscription=true as StreamSubscription;



  // check internet
 // Future<bool> _hasInternetConnection() async {
   // return await InternetConnectionChecker().hasConnection;
  //}

  Future _loadMembersData() async {
    // check internet connectivity
 /*   final hasInternet = await _hasInternetConnection();
    if (hasInternet) {
      final membersData = await MemberService().onLoadMembers(widget.mobile);
      final message = membersData['message'];
      if (message == 'success') {
        setState(() {
          _selectMember = widget.memberId;
          _membersData = membersData['data'];
          _isPageLoaded = true;
        });
      } else {
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'No internet connection',
        toastLength: Toast.LENGTH_LONG,
      );
    }*/
  }

  @override
 /* void dispose() {
    _sBPCtrl.dispose();
    _dBPCtrl.dispose();
    _heartRateCtrl.dispose();
    _bloodGlucoseCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _waistCtrl.dispose();
    _dateTimeCtrl.dispose();
  //  internetSubscription.cancel();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var kColorBg;
    var kColorPrimary;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: kColorBg,
        appBar: PreferredSize(
          preferredSize: Size.zero,
           child: AppBar(
          title: const Text("Health Sync"),
        ),
  
        ),
        body: _isPageLoaded
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            /*Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => RecordPage(
                                  mobile: widget.mobile,
                                  memberId: _selectMember,
                                ),
                              ),
                              (Route<dynamic> route) => false,
                            );*/
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: 18,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(right: size.width * 0.06),
                            alignment: Alignment.center,
                            child: const Text(
                              'Add Prescription',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Form(
                      key: _addRecordFormKey,
                      child: ListView(
                        children: [
                         
                          AptSection(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                           /* TitleSection(
                            name: 'Neme: Sandipa',
                            location: 'Appolo Clinic, Kolkata',
                              ),*/
      
                                TextFormField(
                                  controller: _sResonCtrl,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        bottom: 24,
                                        top: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                    hintText: 'Reson for visit',
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? val) {
                                    if (val == null || val.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _sBPCtrl,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        bottom: 12,
                                        top: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                    hintText: 'Systolic blood pressure',
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? val) {
                                    if (val == null || val.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _dBPCtrl,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        bottom: 12,
                                        top: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                    hintText: 'Diastolic blood pressure',
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? val) {
                                    if (val == null || val.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _heartRateCtrl,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        bottom: 12,
                                        top: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                    hintText: 'Heart rate',
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? val) {
                                    if (val == null || val.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                               
                                TextFormField(
                                  controller: _bloodGlucoseCtrl,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        bottom: 12,
                                        top: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                    hintText: 'Blood glucose',
                                    suffixText: 'mg/dl',
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? val) {
                                    if (val == null || val.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  hint: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Select an option'),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                      left: 12,
                                      right: 12,
                                      bottom: 12,
                                      top: 12,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                    hintText: 'Blood glucose',
                                  ),
                                  value: _selectMeasurement,
                                  items: _measurementScale.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? val) =>
                                      setState(() => _selectMeasurement = val),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _heightCtrl,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: false,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        bottom: 12,
                                        top: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    hintText: 'Height',
                                    suffixText: 'ft',
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? val) {
                                    if (val == null || val.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                  onChanged: (val) => _computeBMI(),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _weightCtrl,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    decimal: false,
                                    signed: false,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                      left: 12,
                                      right: 12,
                                      bottom: 12,
                                      top: 12,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                    hintText: 'Weight',
                                    suffixText: 'kg',
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? val) {
                                    if (val == null || val.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                  onChanged: (val) => _computeBMI(),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _waistCtrl,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        bottom: 12,
                                        top: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                    hintText: 'Waist',
                                    suffixText: 'inches',
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? val) {
                                    if (val == null || val.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Compute BMI: ',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '$_calculatedBMI $_resultBMI',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: const [
                                    Expanded(
                                      child: Text(
                                        'BMI = weight in kg / height squared in meters.',
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: _selectDatetime,
                                  child: IgnorePointer(
                                    child: TextFormField(
                                      controller: _dateTimeCtrl,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.only(
                                          left: 12,
                                          right: 12,
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
                                        hintText: 'Measurement Datetime',
                                        suffixIcon: const Icon(
                                          Icons.date_range_outlined,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                 Row(
                                  children: [
                                    const Text('Medication: '),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Row(
                                      children: [
                                      /*  SizedBox(
                                          height: 20,
                                          width: 30,
                                          child: Radio(
                                            value: true,
                                            groupValue: _medication,
                                            onChanged:
                                                (SelectMedication? value) {
                                              setState(
                                                  () => _medication = value!);
                                            },
                                          ),
                                        ),*/
                                        GestureDetector(
                                          onTap: () {
                                            setState(() => _medication =
                                                SelectMedication.yes);
                                          },
                                          child: const Text('No'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 30,
                                          child: Radio(
                                              value: SelectMedication.no,
                                              groupValue: _medication,
                                              onChanged:
                                                  (SelectMedication? value) {
                                                Navigator.push(
                                                      context,
                                                   MaterialPageRoute(builder: (context) => MyMed())
                                                    );
                         
                                              }),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() => _medication =
                                                SelectMedication.no);
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                      ElevatedButton.icon(
                      onPressed: () {
                        },
                        icon: Icon(Icons.save),
                        label: Text('Save'),
                      ),

                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  //
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
    final formatTime = DateTime.now();
    //DateFormat('hh:mm a').format(dateTime);
    _dateTimeCtrl.text =
        '${dateTime.year}-${dateTime.month}-${dateTime.day} $formatTime';
    setState(() => _dateTime = dateTime);
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
  _onPressedSaveRecord() async {
    bool formValidation = _addRecordFormKey.currentState!.validate();
    if (formValidation) {
   //   showDialogBox(context);
      final message = await _onPostSaveRecord();
      _onDoneSaveRecord(message);
    }
  }

  //
  _onPostSaveRecord() async {
    // check internet connectivity
   /* final hasInternet = await _hasInternetConnection();
    if (hasInternet) {
      final time = DateFormat('hh:mm a').format(_dateTime);
      Map<String, String> recordMap = {
        "HPD_HP_ID": _selectMember!,
        "HPD_Date": '${_dateTime.year}-${_dateTime.month}-${_dateTime.day}',
        "HPD_DateTime":
            '${_dateTime.year}-${_dateTime.month}-${_dateTime.day} $time',
        "HPD_SBP": _sBPCtrl.text,
        "HPD_DBP": _dBPCtrl.text,
        "HPD_HeartRate": _heartRateCtrl.text,
        "HPD_Medication": (_medication == SelectMedication.yes) ? 'Yes' : 'No',
        "HPD_BloodGlucose": _bloodGlucoseCtrl.text,
        "HPD_GlucoseMeasured": _selectMeasurement!,
        "HPD_Height": _heightCtrl.text,
        "HPD_BMI": _calculatedBMI.toString(),
        "HPD_Type": 'all',
      };
      final message = await MemberService().onSaveMemberRecord(recordMap);
      return message;
    } else {
      return 'No internet connection';
    }*/
  }

  //
  _onDoneSaveRecord(String message) {
    /*if (message == 'Successful') {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: 'Member record has been added successfully',
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => RecordPage(
            mobile: widget.mobile,
            memberId: _selectMember,
          ),
        ),
      );
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
      );
    }*/
  }

  //
  //
  String _bmiResult(double bmi) {
    String bmiResult = '';
    if (bmi < 18.5) {
      bmiResult = 'Underweight';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      bmiResult = 'Normal weight';
    } else if (bmi >= 25 && bmi <= 29.9) {
      bmiResult = 'Overweight';
    } else {
      bmiResult = 'Obesity';
    }
    return bmiResult;
  }

  //
  _computeBMI() {
    String strHeight = _heightCtrl.text;
    String strWeight = _weightCtrl.text;
    if (strHeight.isNotEmpty && strWeight.isNotEmpty) {
      double height = double.parse(strHeight); //ft
      double weight = double.parse(strWeight); //kg
      height = height * 0.3048; // meters
      height *= height; //meter square
      double bmi = weight / height;
      final result = _bmiResult(bmi);
      setState(() {
        _resultBMI = result;
        _calculatedBMI = double.parse(bmi.toStringAsFixed(1));
      });
    }
  }

}
class AptSection extends StatelessWidget {
  const AptSection({super.key});
  final appid= 'app1234';
  final clinic= 'app1234';
  


  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           AppWithText(
            id: 'AppointmentId:App1234',
            name: 'Clinic Name:Icons.call',
            label: 'Address: kolkata-75',
          ),
          AppWithText(
            id: 'Doctor Registration No:Doc1234',
            name: 'Doctor Name : Sagarika Mallik',
            label: 'Address: kolkata-75',
          ),
          AppWithText(
            id: 'PaitentId:P1234',
            name: 'Clinic Name:Basudeb Das',
            label: 'Address: kolkata-75',
          ),
        ],
      ),
    );
  }
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
class AppWithText extends StatelessWidget {
  const AppWithText({
    super.key,
    required this.id,
    required this.name,
    required this.label,
  });

  final String id;
  final String name;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    id,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                  Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
      ],
    );
  }
}




class MyMed extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyMed> {
  final List<String> names = <String>['Dolo500','PAN D'];
  final List<String> dosg = <String>['SoS','Once a day'];
  final List<int> msgCount = <int>[2];
   String? _selectMedDose = '1';
   final List<Map<String, String>> _medicineDoseList = [
    {'key': '1', 'value': 'Once a day'},
    {'key': '2', 'value': 'Twice a day'},
    {'key': '3', 'value': 'Thrice a day'},
    {'key': '4', 'value': 'Four time a day'},
     {'key': '5', 'value': 'SOS'},
  ];

  TextEditingController nameController = TextEditingController();

  void addItemToList(){
    setState(() {
      names.insert(0,nameController.text);
     
     // dosg.insert(0,dose['value'].toString());

      //msgCount.insert(0, 0);
    });
  }
    _onChangedDose(String? val) {
    _selectMedDose = val;
 
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescribed Medicine'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Medicine Name',
              ),
            ),
          ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              isExpanded: true,
              hint: const Align(
                alignment: Alignment.centerLeft,
                child: Text('Select an option'),
              ),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(7),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(7),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              value: _selectMedDose,
              items: _medicineDoseList.map((dose) {
                return DropdownMenuItem(
                  value: dose['key'],
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          dose['value'].toString(),
                          overflow:
                              TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? val) {
                FocusScope.of(context)
                    .requestFocus(FocusNode());
                _onChangedDose(val);
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
             ElevatedButton.icon(
                onPressed: () {
                   //_selectDate(context);
                   addItemToList();
           
                },
                 icon: Icon(Icons.add),
                label: Text('Start'),
              ),           

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              //itemCount: names.length,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  margin: EdgeInsets.all(2),
                  color: msgCount[index]>=10? Colors.blue[400]:
                    msgCount[index]>3? Colors.blue[100]: Colors.grey,
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
}

///
class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<String> testData = ['One', 'Two'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Stops widgets from being moved by keyboard
      appBar: AppBar(title: Text('Health Sync')),
      body: Column(children: [
        Flexible(
            flex: 1,
            child: ListView.builder(
                itemCount: testData.length,
                itemBuilder: (context, index) {
                  return Card(child: Text(testData[index]));
                })),
        Flexible(
            flex: 1,
            child: Row(children: [
              ElevatedButton(
                  child: Text('Add'),
                  onPressed: () {
                    setState(() {
                      testData.add('Test');
                    });
                  }),
              ElevatedButton(
                  child: Text('Remove'),
                  onPressed: () {
                    setState(() {
                      if(testData.length>0){
                        testData.removeLast();
                      }
                    });
                  }),
            ])),
      ]),
    );
  }
}
