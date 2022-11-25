// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:blood_bridge/Widgets/DropDown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  var statusImage = "notActive.png";
  var statusText = "Switch to donate or receive";
  var status = "Not Active";
  var donorTime = '00:00-23:59';
  var quantity = "1 unit";
  var centreMatched = "Unknown";
  var centreLoc = "Unknown";
  var centreMob = "Unknown";
  var userMatched = "Unknown";
  var userLoc = "Unknown";
  var userMob = "Unknown";
  var _isProcessing = false;

  List<String> donorTimeOptions = [
    '00:00 - 6:00',
    '06:00 - 12:00',
    '12:00 - 18:00',
    '18:00 - 00:00'
  ];
  List<String> receiverQuantity = ['1 unit', '2 unit', '3 unit', '4 unit'];

  var statusDict = [
    ["notActive.png", "Switch to donate or receive"],
    ["receiver.png", "We are searching for a donor!"],
    ["donor.png", "Thank you for being a donor!"],
  ];

  Future<void> getUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final currentUserData =
        await FirebaseFirestore.instance.doc('users/' + uid!).get();

    status = currentUserData['userChoice'];
    updateStatus();
    var centreIdMatched = currentUserData['matchedCentre'];
    var userIdMatched = currentUserData['matchedUser'];

    if ((centreIdMatched != null)) {
      final matchedCentreData = await FirebaseFirestore.instance
          .doc('users/' + centreIdMatched)
          .get();
      centreMatched = matchedCentreData['name'];
      centreLoc = matchedCentreData['location'];
      centreMob = matchedCentreData['mobileNo'];
    } else {
      centreMatched = "Unknown";
    }

    if ((userIdMatched != null)) {
      final matchedUserData =
          await FirebaseFirestore.instance.doc('users/' + userIdMatched).get();
      userMatched = matchedUserData['name'];
      userLoc = matchedUserData['location'];
      userMob = matchedUserData['mobileNo'];
    } else {
      userMatched = "Unknown";
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> _submitToDB() async {
    final curUser = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(curUser!.uid)
        .update(
      {
        'userChoice': status,
        'receiverQuantity': quantity,
        'donorTime': donorTime,
      },
    );
    setState(() {});
  }

  Future<void> _setMatchToNull() async {
    final curUser = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(curUser!.uid)
        .update(
      {
        'matchedUser': null,
        'matchedCentre': null,
      },
    );
    setState(() {});
  }

  void updateStatus() {
    if (status == 'Not Active') {
      statusText = statusDict[0][1];
      statusImage = statusDict[0][0];
    }
    if (status == 'Donor') {
      statusText = statusDict[2][1];
      statusImage = statusDict[2][0];
    }
    if (status == 'Receiver') {
      statusText = statusDict[1][1];
      statusImage = statusDict[1][0];
    }
    setState(() {});
  }

  void showDonorOptions() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: DropDown(
                        items: donorTimeOptions,
                        dropDownHandler: _handleDonorTime,
                        text: "Select your preferred time"),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF15F79),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          status = "Donor";
                          updateStatus();
                          _submitToDB();
                          _setMatchToNull();
                          getUserData();
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        width: 50.w,
                        child: Text(
                          'Submit',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
  }

  void showReceiverOptions() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                Padding(
                  padding: EdgeInsets.only(top: 22.h),
                  child: DropDown(
                      items: receiverQuantity,
                      dropDownHandler: _handleQuantity,
                      text: "Select number of units"),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF15F79),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          status = "Receiver";
                          updateStatus();
                          _submitToDB();
                          _setMatchToNull();
                          getUserData();
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        width: 50.w,
                        child: Text(
                          'Submit',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
  }

  void _handleDonorTime(var value) {
    donorTime = value;
  }

  void _handleQuantity(var value) {
    quantity = value;
  }

  void switchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          Container(
            width: 400.w,
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF15F79),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  onPressed: () {
                    showDonorOptions();
                  },
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Donate Blood',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF15F79),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  onPressed: () {
                    showReceiverOptions();
                  },
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Receive Blood',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF15F79),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      status = "Not Active";
                      updateStatus();
                      _submitToDB();
                      _setMatchToNull();
                      getUserData();
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Not Available',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Done',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 187, 186, 186),
                            blurRadius: 2.r,
                            blurStyle: BlurStyle.outer,
                            offset: const Offset(0, 2)),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Opacity(
                                opacity: 0.8,
                                child: Image.asset(
                                  'assets/images/' + statusImage,
                                  height: 20.h,
                                ),
                              ),
                              Text(
                                statusText,
                                textScaleFactor: 0.8.w,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  switchDialog();
                                },
                                child: Text("Switch"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  TextButton(
                      onPressed: () async {
                        await getUserData();
                      },
                      child: Text("Refresh")),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 187, 186, 186),
                            blurRadius: 2.r,
                            blurStyle: BlurStyle.outer,
                            offset: const Offset(0, 2)),
                      ],
                    ),
                    child: (userMatched == 'Unknown') |
                            (userMatched == Null) |
                            (status == 'Not Active')
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Opacity(
                                opacity: 0.8,
                                child: Image.asset(
                                  'assets/images/mainScreenImage.png',
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              status == 'Not Active'
                                  ? Text(
                                      "Stay Healthy",
                                      style: TextStyle(color: Colors.black54),
                                    )
                                  : status == 'Receiver'
                                      ? Text(
                                          "Donor details will be shown here",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        )
                                      : Text(
                                          "Receiver details will be shown here")
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    status == 'Receiver'
                                        ? "Matched Donor"
                                        : "Matched Receiver",
                                    style: TextStyle(
                                        color: Color(0xFBD85585),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 30.w),
                                  Icon(Icons.person),
                                  SizedBox(width: 10.w),
                                  Text(userMatched),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  SizedBox(width: 30.w),
                                  Icon(Icons.call),
                                  SizedBox(width: 10.w),
                                  Text(userMob),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  SizedBox(width: 30.w),
                                  Icon(Icons.location_pin),
                                  SizedBox(width: 10.w),
                                  Text(
                                    userLoc.length > 20
                                        ? userLoc.substring(0, 27) + "..."
                                        : userLoc,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              )
                            ],
                          ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 187, 186, 186),
                            blurRadius: 2.r,
                            blurStyle: BlurStyle.outer,
                            offset: const Offset(0, 2)),
                      ],
                    ),
                    child: (centreMatched == 'Unknown') |
                            (centreMatched == Null) |
                            (status == 'Not Active')
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Opacity(
                                opacity: 0.8,
                                child: Image.asset(
                                  'assets/images/mainScreenImage2.png',
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              status == 'Not Active'
                                  ? Text("Stay Healthy")
                                  : Text(
                                      "Donation centre details will be shown here.",
                                      style: TextStyle(color: Colors.black54),
                                    )
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Donation Centre",
                                    style: TextStyle(
                                        color: Color(0xFBD85585),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 30.w),
                                  Icon(Icons.local_hospital),
                                  SizedBox(width: 10.w),
                                  Text(centreMatched),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  SizedBox(width: 30.w),
                                  Icon(Icons.call),
                                  SizedBox(width: 10.w),
                                  Text(centreMob),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  SizedBox(width: 30.w),
                                  Icon(Icons.location_pin),
                                  SizedBox(width: 10.w),
                                  Text(
                                    centreLoc.length > 20
                                        ? centreLoc.substring(0, 27) + "..."
                                        : centreLoc,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              )
                            ],
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
