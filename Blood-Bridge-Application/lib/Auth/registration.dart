import 'dart:ffi';

import 'package:blood_bridge/Screens/mainScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Widgets/DropDown.dart';
import '../Widgets/customForm.dart';
import 'fireAuth.dart';
import 'loginPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();

  var nameHint;
  RegisterPage({required this.nameHint});
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  bool isLastPage = false;
  var gender = "Female";
  var bloodGroup = "O+";
  final List<String> genderList = [
    'Not Applicable',
    'Male',
    'Female',
  ];
  final List<String> bloodGroupList = [
    'Not Applicable',
    'O+',
    'O-',
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-'
  ];

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _locationTextController = TextEditingController();
  final _mobTextController = TextEditingController();
  final _ageTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusLocation = FocusNode();
  final _focusMob = FocusNode();
  final _focusAge = FocusNode();

  void _submitToDB() async {
    setState(() {
      _isProcessing = false;
    });
    final curUser = FirebaseAuth.instance.currentUser;
    final location = _locationTextController.text;
    final name = _nameTextController.text;
    final email = _emailTextController.text;
    final mobile = _mobTextController.text;
    final age = _ageTextController.text;
    var userChoice = "Not Active";
    var whoAreYou = widget.nameHint == 0
        ? "User"
        : widget.nameHint == 1
            ? "Hospital"
            : "Blood Bank";

    whoAreYou == 'User'
        ? await FirebaseFirestore.instance
            .collection('users')
            .doc(curUser!.uid)
            .set(
            {
              'name': name,
              'location': location,
              'mobileNo': mobile,
              'userChoice': userChoice,
              'whoAreYou': whoAreYou,
              'age': age,
              'bloodGroup': bloodGroup,
              'gender': gender,
              'matchedUser': null,
              'matchedCentre': null,
              'donorTime': null,
              'receiverQuantity': null
            },
          )
        : await FirebaseFirestore.instance
            .collection('users')
            .doc(curUser!.uid)
            .set(
            {
              'name': name,
              'email': email,
              'location': location,
              'mobileNo': mobile,
              'whoAreYou': whoAreYou,
              'matchedDonation': [],
            },
          );

    setState(() {
      _isProcessing = false;
    });
  }

  void _handleGender(var value) {
    gender = value;
  }

  void _handleBloodGroup(var value) {
    bloodGroup = value;
  }

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
        _focusLocation.unfocus();
        _focusMob.unfocus();
        _focusAge.unfocus();
        _focusAge.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              left: 24.w,
              right: 24.w,
              top: 24.h,
              bottom: 24.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Image.asset(
                    'assets/logo.png',
                    height: 60.h,
                  ),
                  Form(
                    key: _registerFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.h),
                        isLastPage == false
                            ? Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Text(widget.nameHint == 1
                                        ? "Hospital Name"
                                        : (widget.nameHint == 0
                                            ? "Name"
                                            : "Blood Bank Name")),
                                  ),
                                  CustomForm(
                                    hintTextValue: widget.nameHint == 1
                                        ? "Hospital Name"
                                        : widget.nameHint == 0
                                            ? "Name"
                                            : "Blood Bank Name",
                                    TextController: _nameTextController,
                                  ),
                                  SizedBox(height: 10.h),
                                  Container(
                                    width: double.infinity,
                                    child: Text("Address"),
                                  ),
                                  CustomForm(
                                    hintTextValue: "Address",
                                    TextController: _locationTextController,
                                  ),
                                  SizedBox(height: 10.h),
                                  Container(
                                    width: double.infinity,
                                    child: Text("Email"),
                                  ),
                                  CustomForm(
                                    hintTextValue: "Email",
                                    TextController: _emailTextController,
                                  ),
                                  SizedBox(height: 10.h),
                                  Container(
                                    width: double.infinity,
                                    child: Text("Password"),
                                  ),
                                  CustomForm(
                                    hintTextValue: "Password",
                                    TextController: _passwordTextController,
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Text("Age"),
                                  ),
                                  CustomForm(
                                    hintTextValue: "Age",
                                    TextController: _ageTextController,
                                  ),
                                  SizedBox(height: 10.h),
                                  Container(
                                    width: double.infinity,
                                    child: Text("Gender"),
                                  ),
                                  DropDown(
                                    items: genderList,
                                    dropDownHandler: _handleGender,
                                    text: "Gender",
                                  ),
                                  SizedBox(height: 10.h),
                                  Container(
                                    width: double.infinity,
                                    child: Text("Blood Group"),
                                  ),
                                  DropDown(
                                    items: bloodGroupList,
                                    dropDownHandler: _handleBloodGroup,
                                    text: "Blood Group",
                                  ),
                                  SizedBox(height: 10.h),
                                  Container(
                                    width: double.infinity,
                                    child: Text("Mobile Number"),
                                  ),
                                  CustomForm(
                                    hintTextValue: "Mobile Number",
                                    TextController: _mobTextController,
                                  ),
                                ],
                              ),
                        SizedBox(height: 20.h),
                        _isProcessing
                            ? CircularProgressIndicator()
                            : isLastPage == false
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                            ),
                                          ),
                                          onPressed: () async {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Back',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                            ),
                                          ),
                                          onPressed: () async {
                                            if (_registerFormKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                isLastPage = true;
                                              });
                                            }
                                          },
                                          child: Text(
                                            'Next',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                            ),
                                          ),
                                          onPressed: () async {
                                            setState(() {
                                              isLastPage = false;
                                            });
                                          },
                                          child: Text(
                                            'Back',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                            ),
                                          ),
                                          onPressed: () async {
                                            if (_registerFormKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                _isProcessing = true;
                                              });

                                              User? user = await FireAuth
                                                  .registerUsingEmailPassword(
                                                name: _nameTextController.text,
                                                email:
                                                    _emailTextController.text,
                                                password:
                                                    _passwordTextController
                                                        .text,
                                              );

                                              setState(() {
                                                _isProcessing = false;
                                              });

                                              if (user != null) {
                                                _submitToDB();
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MainScreen(
                                                      user: user,
                                                    ),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          child: Text(
                                            'Register',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        "Log In",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
