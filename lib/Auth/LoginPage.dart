import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blood_bridge/Auth/fireAuth.dart';
import 'package:blood_bridge/Auth/registrationOptions.dart';
import 'package:blood_bridge/Screens/mainScreen.dart';
import 'package:blood_bridge/Auth/widgets/customForm.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _nameTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MainScreen(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: EdgeInsets.only(left: 24.h, right: 24.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 35.h,
                            ),
                            Image.asset(
                              'assets/images/login.png',
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Text(
                              "Log In",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 30.h,
                                  fontWeight: FontWeight.w600),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  CustomForm(
                                    hintTextValue: "Email",
                                    TextController: _emailTextController,
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  CustomForm(
                                    hintTextValue: "Password",
                                    TextController: _passwordTextController,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  _isProcessing
                                      ? CircularProgressIndicator()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.h),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegistrationOptions(),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  'Register',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 24.w,
                                            ),
                                            Expanded(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xFFE57373),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.h),
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  _focusEmail.unfocus();
                                                  _focusPassword.unfocus();

                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      _isProcessing = true;
                                                    });

                                                    User? user = await FireAuth
                                                        .signInUsingEmailPassword(
                                                      email:
                                                          _emailTextController
                                                              .text,
                                                      password:
                                                          _passwordTextController
                                                              .text,
                                                    );

                                                    setState(() {
                                                      _isProcessing = false;
                                                    });

                                                    if (user != null) {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    MainScreen(
                                                                      user:
                                                                          user,
                                                                    )),
                                                      );
                                                    }
                                                  }
                                                },
                                                child: Text(
                                                  'Sign In',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  Image.asset(
                                    'assets/images/LOGO.png',
                                    height: 60.h,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
