import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_auth/Auth/fire_auth.dart';
import 'package:learn_auth/Auth/widgets/customForm.dart';
import 'package:learn_auth/Screens/profile.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();

  var nameHint;
  RegisterPage({required this.nameHint});
}

class _RegisterPageState extends State<RegisterPage> {
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
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(24.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _registerFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 30.h),
                        Image.asset(
                          'assets/images/LOGO.png',
                          height: 90.h,
                        ),
                        SizedBox(height: 30.h),
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: Text(widget.nameHint == 1
                                  ? "Hospital Name"
                                  : (widget.nameHint == 0
                                      ? "Name"
                                      : "Blood Bank Name")),
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
                                          borderRadius:
                                              BorderRadius.circular(15.h),
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
                                            email: _emailTextController.text,
                                            password:
                                                _passwordTextController.text,
                                          );

                                          setState(() {
                                            _isProcessing = false;
                                          });

                                          if (user != null) {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfilePage(user: user),
                                              ),
                                              ModalRoute.withName('/'),
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
