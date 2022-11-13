import 'package:blood_bridge/Screens/mainScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blood_bridge/Auth/fireAuth.dart';
import 'package:blood_bridge/Auth/widgets/customForm.dart';
import 'package:blood_bridge/Unused%20files/profile.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();

  var nameHint;
  UserDetails({required this.nameHint});
}

class _UserDetailsState extends State<UserDetails> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _locationTextController = TextEditingController();
  final _mobTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusLocation = FocusNode();
  final _focusMob = FocusNode();

  void _submitToDB() async {
    setState(() {
      _isProcessing = false;
    });
    final curUser = FirebaseAuth.instance.currentUser;
    final location = _locationTextController.text;
    final name = _nameTextController.text;
    final email = _emailTextController.text;
    final mobile = _mobTextController.text;
    final userChoice = "Not Active";
    var whoAreYou = widget.nameHint == 0
        ? "User"
        : widget.nameHint == 1
            ? "Hospital"
            : "Blood Bank";

    await FirebaseFirestore.instance.collection('users').doc(curUser!.uid).set(
      {
        'name': name,
        'phone': email,
        'location': location,
        'mobileNo': mobile,
        'userChoice': userChoice,
        'whoAreYou': whoAreYou
      },
    );

    setState(() {
      _isProcessing = false;
    });
  }

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _registerFormKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.h),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(widget.nameHint == 1
                        ? "Hospital Name"
                        : (widget.nameHint == 0 ? "Name" : "Blood Bank Name")),
                  ),
                ],
              ),
              CustomForm(
                hintTextValue: widget.nameHint == 1
                    ? "Hospital Name"
                    : widget.nameHint == 0
                        ? "Name"
                        : "Blood Bank Name",
                TextController: _nameTextController,
              ),
              SizedBox(height: 30.h),
              Container(
                width: double.infinity,
                child: Text("Addres"),
              ),
              CustomForm(
                hintTextValue: "Address",
                TextController: _locationTextController,
              ),
              SizedBox(height: 30.h),
              Container(
                width: double.infinity,
                child: Text("Email"),
              ),
              CustomForm(
                hintTextValue: "Email",
                TextController: _emailTextController,
              ),
              SizedBox(height: 30.h),
              Container(
                width: double.infinity,
                child: Text("Password"),
              ),
              CustomForm(
                hintTextValue: "Password",
                TextController: _passwordTextController,
              ),
              SizedBox(height: 30.h),
              Container(
                width: double.infinity,
                child: Text("Mobile Number"),
              ),
              CustomForm(
                hintTextValue: "Mobile Number",
                TextController: _mobTextController,
              ),
              SizedBox(height: 30.h),
              _isProcessing
                  ? CircularProgressIndicator()
                  : Row(
                      children: [
                        SizedBox(
                          width: 75.w,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.h),
                              ),
                            ),
                            onPressed: () async {
                              if (_registerFormKey.currentState!.validate()) {
                                setState(() {
                                  _isProcessing = true;
                                });
                                User? user =
                                    await FireAuth.registerUsingEmailPassword(
                                  name: _nameTextController.text,
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text,
                                );

                                setState(() {
                                  _isProcessing = false;
                                  print("OOOOKKKKK:(");
                                  print(user);
                                });

                                if (user != null) {
                                  _submitToDB(); //Submit to database
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            // ProfilePage(
                                            //     user: user),
                                            MainScreen(
                                              user: user,
                                            )),
                                  );
                                }
                              }
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 75.w,
                        ),
                      ],
                    )
            ],
          ),
        ),
      ],
    );
  }
}
