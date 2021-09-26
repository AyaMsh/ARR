import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import 'homePage.dart';


class Driver extends StatefulWidget {
  @override
  Driver_DriverState createState() => Driver_DriverState();
}

enum SingingCharacter { lafayette, jefferson }

class Driver_DriverState extends State<Driver> {

  String _birthDate = " ";
  String? _insurance_type;
  String? _car_class;
  String? _color;

  int _passengers_number = 1;

  DateTime selectedDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  String timeText = 'Select Time';
  String? dateUTC;
  String? date_Time;


  Future<void> selectDate(BuildContext context ,int value) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(3000),
    ).then(
          (date) {
        setState(
              () {
            selectedDate = date!;
            String formattedDate =
            DateFormat('dd-MM-yyyy').format(selectedDate);
            switch(value)
            {
              case 1 :_manufacture_date = formattedDate;
              break;

              case 2 :_insurance_date = formattedDate;
              break;

              case 3 :_insurance_expire = formattedDate;
              break;

              case 4 :_birthDate = formattedDate;
              break;

            }
            dateUTC = DateFormat('yyyy-MM-dd').format(selectedDate);
          },
        );
      },
    );
  }

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  TextEditingController _firstName =  TextEditingController();
  TextEditingController _secondName =  TextEditingController();
  TextEditingController _fatherName =  TextEditingController();
  TextEditingController _motherName =  TextEditingController();
  TextEditingController _userName =  TextEditingController();
  TextEditingController _password =  TextEditingController();
  TextEditingController _nationalNumber =  TextEditingController();
  TextEditingController _id=  TextEditingController();
  TextEditingController _mobileNumber=  TextEditingController();
  TextEditingController _watsappNumber =  TextEditingController();
  TextEditingController _address =  TextEditingController();
  TextEditingController _driverLicence=  TextEditingController();

   String? _city;
   String? _licenceType;
   String? _licenceClass;

  SingingCharacter _gender = SingingCharacter.lafayette;

  TextEditingController _brand=  TextEditingController();
  TextEditingController _moudel=  TextEditingController();
  TextEditingController _vin=  TextEditingController();
  TextEditingController _car_number=  TextEditingController();
  String _manufacture_date =  "";
  String _insurance_date =  "";
  String _insurance_expire =  "";
  TextEditingController _car_type	=  TextEditingController();







  File? _image;


  final ImagePicker _picker = ImagePicker();


  _imgFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 50,

    );

    setState(() {
      _image = File(pickedFile!.path) ;
    });
  }

  _imgFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child:  Wrap(
                children: <Widget>[
                  ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('اختر صورة'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('التقط صورة'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: new Icon(Icons.delete),
                    title: new Text('حذف الصورة'),
                    onTap: () {
                      setState(() {
                        _image = null;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.topLeft,
            colors: [
              Color(0xffc0dae6),
              Color(0xffebf3f7),
              Color(0xffffffff),
              Color(0xffffffff),
            ],
          ),
        ),
        child: Stepper(
            controlsBuilder: (BuildContext context,
                {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) =>
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _currentStep == 0 ? Text("")
                            : RaisedButton(
                            shape: RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(20))),
                            textColor: Colors.white,
                            color:Color(0xff1b4679),
                            onPressed: onStepCancel,
                            child: Text("السابق")
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(20))),
                          textColor: Colors.white,
                          color:Color(0xff1b4679),
                          onPressed: onStepContinue,
                          child: _currentStep >= 1 ? Text("حفظ") : Text("التالي")
                          ,
                        ),
                      ],
                    ),
                  ),
                ),
            type: stepperType,
            physics: ScrollPhysics(),
            currentStep: _currentStep,
            onStepTapped: (step) => setState(() => _currentStep = step),
            onStepContinue: _currentStep < 1 ? () => setState(() => _currentStep += 1) : save ,
            onStepCancel: _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
            steps: <Step>[
              Step(title: Text('معلومات السائق'),
                  content:  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: GestureDetector(
                          onTap:() {
                            _showPicker(context);
                          },
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Color(0xff1b4679),
                            child:GestureDetector(
                              onTap: () {
                                _showPicker(context);
                              },
                              child: _image != null
                                  ?  CircleAvatar(
                                radius: 78,
                                backgroundColor: Colors.white,
                                backgroundImage: FileImage(_image!),
                              )
                                  : CircleAvatar(
                                   radius: 78,
                                   backgroundColor: Colors.white,
                                    child: Icon(
                                  Icons.camera_alt,
                                  color: Color(0xff1b4679),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _firstName,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.right,
                            cursorColor: Color(0xff1b4679),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person_outline,
                                color: Color(0xff1b4679),
                              ),
                              hintText: 'الاسم',
                              hintStyle: TextStyle(
                                color: Color(0xff1b4679),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _secondName,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.right,
                            cursorColor: Color(0xff1b4679),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person_outline,
                                color: Color(0xff1b4679),
                              ),
                              hintText: 'الكنية',
                              hintStyle: TextStyle(
                                color: Color(0xff1b4679),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _fatherName,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.right,
                            cursorColor: Color(0xff1b4679),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person_outline,
                                color: Color(0xff1b4679),
                              ),
                              hintText: 'اسم الأب',
                              hintStyle: TextStyle(
                                color: Color(0xff1b4679),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _motherName,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.right,
                            cursorColor: Color(0xff1b4679),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person_outline,
                                color: Color(0xff1b4679),
                              ),
                              hintText: 'اسم الأم',
                              hintStyle: TextStyle(
                                color: Color(0xff1b4679),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: GestureDetector(
                          child: Container(
                            height: 60,
                            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Color(0xff1b4679),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(" $_birthDate"),
                                ),
                                Expanded(
                                    child: Text(
                                      " تاريخ الميلاد",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Color(0xff1b4679)),
                                    )),
                              ],
                            ),
                          ),
                          onTap: () => selectDate(context,4),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10,top: 10),
                                  child: Text(
                                    "الجنس",
                                    style: TextStyle(color: Color(0xff1b4679)),
                                  ),
                                ),
                                RadioListTile(
                                  title:  Text(
                                    'أنثى',
                                    style: TextStyle(color: Color(0xff1b4679)),
                                  ),

                                  secondary: Icon(Icons.female,color: Color(0xff1b4679)),
                                  activeColor: Color(0xff1b4679),
                                  value: SingingCharacter.lafayette,
                                  groupValue: _gender,
                                  onChanged: (SingingCharacter? value) {
                                    setState(() {
                                      _gender = value!;
                                    });
                                  },
                                ),
                                RadioListTile(
                                  title:  Text(
                                    'ذكر',
                                    style: TextStyle(color: Color(0xff1b4679)),
                                  ),
                                  secondary: Icon(Icons.male,color:Color(0xff1b4679)),
                                  activeColor: Color(0xff1b4679),
                                  value: SingingCharacter.jefferson,
                                  groupValue: _gender,
                                  onChanged: (SingingCharacter? value) {
                                    setState(() {
                                      _gender = value!;
                                    });
                                  },
                                ),
                              ],
                            )

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _userName,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.right,
                            cursorColor: Color(0xff1b4679),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person_outline,
                                color: Color(0xff1b4679),
                              ),
                              hintText: 'اسم المستخدم',
                              hintStyle: TextStyle(
                                color: Color(0xff1b4679),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _password,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            textAlign: TextAlign.right,
                            cursorColor: Color(0xff1b4679),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.lock_outline,
                                color: Color(0xff1b4679),
                              ),
                              hintText: 'كلمة المرور',
                              hintStyle: TextStyle(
                                color: Color(0xff1b4679),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _nationalNumber,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            cursorColor: Color(0xff1b4679),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.account_box_outlined,
                                color: Color(0xff1b4679),
                              ),
                              hintText: 'الرقم الوطني',
                              hintStyle: TextStyle(
                                color: Color(0xff1b4679),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _id,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            cursorColor: Color(0xff1b4679),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.account_box_outlined,
                                color: Color(0xff1b4679),
                              ),
                              hintText: 'رقم الهوية',
                              hintStyle: TextStyle(
                                color: Color(0xff1b4679),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _mobileNumber,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            cursorColor: Color(0xff1b4679),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.phone_outlined,
                                color: Color(0xff1b4679),
                              ),
                              hintText: 'رقم الموبايل',
                              hintStyle: TextStyle(
                                color: Color(0xff1b4679),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _watsappNumber,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            cursorColor: Color(0xff1b4679),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.phone_outlined,
                                color: Color(0xff1b4679),
                              ),
                              hintText: 'رقم الواتس',
                              hintStyle: TextStyle(
                                color: Color(0xff1b4679),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_city_outlined,
                                color: Color(0xff1b4679),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 10),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Color(0xff1b4679),
                                      ),
                                      value: _city,
                                      items: <String>[
                                        "حلب",
                                        "دمشق",
                                        "القنيطرة",
                                        "درعا",
                                        "السويداء",
                                        "حمص",
                                        "ريف دمشق",
                                        "طرطوس",
                                        "اللاذقية",
                                        "حماة",
                                        "ادلب",
                                        "الرقة",
                                        "دير الزور",
                                        "الحسكة"
                                      ].map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(value)),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _city = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "المحافظة",
                                style: TextStyle(color: Color(0xff1b4679)),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _address,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.right,
                            cursorColor: Color(0xff1b4679),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.home_work_outlined,
                                color: Color(0xff1b4679),
                              ),
                              hintText: 'منطقة السكن',
                              hintStyle: TextStyle(
                                color: Color(0xff1b4679),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _driverLicence,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            cursorColor: Color(0xff1b4679),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.directions_car_outlined,
                                color: Color(0xff1b4679),
                              ),
                              hintText: 'رقم شهادة السواقة',
                              hintStyle: TextStyle(
                                color: Color(0xff1b4679),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.directions_car_outlined,
                                color: Color(0xff1b4679),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 10),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Color(0xff1b4679),
                                      ),
                                      value: _licenceType,
                                      items: <String>[
                                        "عمومي",
                                        "خصوصي",
                                      ].map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(value)),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _licenceType = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "نوع الشهادة",
                                style: TextStyle(color: Color(0xff1b4679)),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.directions_car_outlined,
                                color: Color(0xff1b4679),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 10),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Color(0xff1b4679),
                                      ),
                                      value: _licenceClass,
                                      items: <String>[
                                        "A",
                                        "B",
                                        "C",
                                        "D",
                                      ].map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(value)),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _licenceClass = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "فئة الشهادة",
                                style: TextStyle(color: Color(0xff1b4679)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                isActive: _currentStep >= 0,
              ),
              Step(title: Text("معلومات السيارة"),
                  content: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _brand,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.right,
                            cursorColor: Color(0xff1b4679),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.directions_car_outlined,
                                color: Color(0xff1b4679),
                              ),
                              hintText: 'اسم الماركة',
                              hintStyle: TextStyle(
                                color: Color(0xff1b4679),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _moudel,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.right,
                            cursorColor: Color(0xff1b4679),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.directions_car_outlined,
                                color: Color(0xff1b4679),
                              ),
                              hintText: 'الموديل',
                              hintStyle: TextStyle(
                                color: Color(0xff1b4679),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _vin,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            cursorColor: Color(0xff1b4679),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.directions_car_outlined,
                                color: Color(0xff1b4679),
                              ),
                              hintText: 'رقم الشاسيه',
                              hintStyle: TextStyle(
                                color: Color(0xff1b4679),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _car_number,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            cursorColor: Color(0xff1b4679),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.directions_car_outlined,
                                color: Color(0xff1b4679),
                              ),
                              hintText: 'نمرة السيارة',
                              hintStyle: TextStyle(
                                color: Color(0xff1b4679),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: GestureDetector(
                          child: Container(
                            height: 60,
                            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Color(0xff1b4679),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("$_manufacture_date"),
                                ),
                                Expanded(
                                    child: Text(
                                      "عام الصنع",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Color(0xff1b4679)),
                                    )),
                              ],
                            ),
                          ),
                          onTap: () => selectDate(context,1),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: GestureDetector(
                          child: Container(
                            height: 60,
                            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Color(0xff1b4679),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(" $_insurance_date",
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                      "تاريخ التأمين",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Color(0xff1b4679)),
                                    )),
                              ],
                            ),
                          ),
                          onTap: () => selectDate(context,2),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: GestureDetector(
                          child: Container(
                            height: 60,
                            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Color(0xff1b4679),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(" $_insurance_expire",
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                      "تاريخ انتهاء التأمين",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(color: Color(0xff1b4679)),
                                    )),
                              ],
                            ),
                          ),
                          onTap: () => selectDate(context,3),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.directions_car_outlined,
                                color: Color(0xff1b4679),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 10),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Color(0xff1b4679),
                                      ),
                                      value: _insurance_type,
                                      items: <String>[
                                        "1",
                                        "2",
                                        "3",
                                      ].map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(value)),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _insurance_type = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "نوع التأمين",
                                style: TextStyle(color: Color(0xff1b4679)),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _car_type,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.right,
                            cursorColor: Color(0xff1b4679),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.directions_car_outlined,
                                color: Color(0xff1b4679),
                              ),
                              hintText: 'تصنيف السيارة',
                              hintStyle: TextStyle(
                                color: Color(0xff1b4679),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.directions_car_outlined,
                                color: Color(0xff1b4679),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 10),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Color(0xff1b4679),
                                      ),
                                      value: _car_class,
                                      items: <String>[
                                        "Taxi",
                                        "Van",
                                        "VIP",
                                      ].map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(value)),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _car_class = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "المجموعة التابعة لها",
                                style: TextStyle(color: Color(0xff1b4679)),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.color_lens_outlined,
                                color: Color(0xff1b4679),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 10),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Color(0xff1b4679),
                                      ),
                                      value: _color,
                                      items: <String>[
                                        "أسود",
                                        "أبيض",
                                        "فضي",
                                        "أصفر",
                                        "أخضر",
                                        "أحمر",
                                        "برتقالي",
                                      ].map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(value)),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _color = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "اللون",
                                style: TextStyle(color: Color(0xff1b4679)),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.people_outline,
                                color: Color(0xff1b4679),
                              ),
                              Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only( right: 20),
                                    child: Text('$_passengers_number',textAlign: TextAlign.right,)
                                ),
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    child: Icon(
                                      Icons.keyboard_arrow_up,
                                      color: Color(0xff1b4679),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if(_passengers_number < 25)
                                          _passengers_number++;
                                      });
                                    },
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color(0xff1b4679),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if(_passengers_number > 1)
                                          _passengers_number--;
                                      });
                                    },
                                  ),

                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  "عدد الركاب",
                                  style: TextStyle(color: Color(0xff1b4679)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                isActive: _currentStep >= 0,
              )
            ]
        ),

        ),
    );
  }
  save() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }
}
