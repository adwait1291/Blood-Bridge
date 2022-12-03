// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Auth/loginPage.dart';

class UserProfile extends StatefulWidget {
  static const routeName = '/menu';
  final User user;
  UserProfile({required this.user});
  @override
  State<UserProfile> createState() => _MenuPageState();
}

class _MenuPageState extends State<UserProfile> {
  bool _isSigningOut = false;
  String bloodGroup = 'unknown';
  String phone = 'unkonwn';
  String location = 'unknown';
  String age = "unknown";
  String gender = "";
  getUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final currentUserData =
        await FirebaseFirestore.instance.doc('users/' + uid!).get();
    location = currentUserData['location'];
    phone = currentUserData['mobileNo'];
    bloodGroup = currentUserData['bloodGroup'];
    age = currentUserData['age'];
    gender = currentUserData['gender'];

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Color(0xFFF8E1E7),
                      radius: 70.r,
                      child: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        radius: 60.r,
                        backgroundImage: gender == "Male"
                            ? AssetImage('assets/images/boy.png')
                            : gender == "Female"
                                ? AssetImage('assets/images/girl.png')
                                : AssetImage('assets/images/user.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "${widget.user.displayName}",
                    style: TextStyle(
                        color: Color(0xFBD85585),
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 82.h,
                    decoration: BoxDecoration(
                        color: Color(0xFFF8E1E7),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            Container(
                              width: 100.w,
                              child: Text(
                                "Age",
                                style: TextStyle(
                                    fontSize: 13.sp, color: Colors.black54),
                              ),
                            ),
                            Container(
                              child: Text(
                                age,
                                style: TextStyle(fontSize: 13.sp),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Color(0xFFD1AAB1),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            Container(
                              width: 100.w,
                              child: Text(
                                "Blood Group",
                                style: TextStyle(
                                    fontSize: 13.sp, color: Colors.black54),
                              ),
                            ),
                            Container(
                              child: Text(
                                bloodGroup,
                                style: TextStyle(fontSize: 13.sp),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Color(0xFFD1AAB1),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            Container(
                              width: 100.w,
                              child: Text(
                                "Location",
                                style: TextStyle(
                                    fontSize: 13.sp, color: Colors.black54),
                              ),
                            ),
                            Container(
                              child: Text(
                                location.length > 20
                                    ? location.substring(0, 17) + "..."
                                    : location,
                                style: TextStyle(fontSize: 13.sp),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Color(0xFFD1AAB1),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            Container(
                              width: 100.w,
                              child: Text(
                                "Phone no.",
                                style: TextStyle(
                                    fontSize: 13.sp, color: Colors.black54),
                              ),
                            ),
                            Container(
                              child: Text(
                                phone,
                                style: TextStyle(fontSize: 13.sp),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Opacity(
                    opacity: 0.7,
                    child: Image.asset(
                      'assets/images/profileImage.png',
                      colorBlendMode: BlendMode.color,
                      height: 70.h,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Thank you for being a part of our Blood Bridge",
                    style: TextStyle(fontSize: 13.sp),
                  ),
                  _isSigningOut
                      ? CircularProgressIndicator()
                      : TextButton(
                          onPressed: () async {
                            setState(() {
                              _isSigningOut = true;
                            });
                            await FirebaseAuth.instance.signOut();
                            setState(() {
                              _isSigningOut = false;
                            });
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Log out',
                            style: TextStyle(color: Color(0xFBD85585)),
                          ),
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
