// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

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
  String? donorTime;
  List<String> donorTimeOptions = ['00:00 - 23:59'];
  List<String> receiverQuantity = ['1 unit', '2 unit', '3 unit', '4 unit'];
  String? quantity;
  var _isProcessing = false;
  void _submitToDB() async {
    setState(() {
      _isProcessing = false;
    });
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

    setState(() {
      _isProcessing = false;
    });
  }

  void showDonorOptions() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                DropDown(
                    items: donorTimeOptions,
                    dropDownHandler: _handleDonorTime,
                    text: "Select your preferred time"),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      status = "Donor";
                      statusText = "Thank you for being a donor!";
                      statusImage = "donor.png";
                      _submitToDB();
                      Navigator.of(context).pop();
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Submit',
                      textAlign: TextAlign.center,
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
                DropDown(
                    items: receiverQuantity,
                    dropDownHandler: _handleQuantity,
                    text: "Select number of units"),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      status = "Receiver";
                      statusText = "We are searching for a donor!";
                      statusImage = "receiver.png";
                      _submitToDB();
                      Navigator.of(context).pop();
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Submit',
                      textAlign: TextAlign.center,
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
          Column(
            children: [
              ElevatedButton(
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
                onPressed: () {
                  setState(() {
                    status = "Not Active";
                    statusText = "Switch to donate or receive";
                    statusImage = "notActive.png";
                    _submitToDB();
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
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
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
                              Text(statusText),
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
                    height: 10.h,
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
                    child: Column(
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
                        Text(
                          "Please select donate or receive to see the options.",
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: 130.h,
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
                        Opacity(
                          opacity: 0.8,
                          child: Image.asset(
                            'assets/images/mainScreenImage2.png',
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          "Donation centre details will be shown here.",
                          style: TextStyle(color: Colors.black54),
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
