import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_auth/Auth/Registration.dart';

import '../Screens/profile.dart';

class RegistrationOptions extends StatefulWidget {
  @override
  State<RegistrationOptions> createState() => _RegistrationOptionsState();
}

class _RegistrationOptionsState extends State<RegistrationOptions> {
  var checkedValue = -1;
  Widget unCheckedBox = Icon(
    Icons.circle_outlined,
    color: Colors.black,
  );
  Widget checkedBox = Icon(
    Icons.circle,
    color: Colors.black,
  );

  List<Widget> checkBox = <Widget>[
    Icon(
      Icons.circle_outlined,
      color: Colors.black,
    ),
    Icon(
      Icons.circle_outlined,
      color: Colors.black,
    ),
    Icon(
      Icons.circle_outlined,
      color: Colors.black,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(24.h),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Image.asset(
                'assets/images/LOGO.png',
                height: 90.h,
              ),
              SizedBox(height: 50.h),
              Text(
                "Who are you?",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 30.h,
                    fontWeight: FontWeight.w600),
                // textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.h),
              SizedBox(
                height: 60.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      checkedValue = 0;
                      checkBox[0] = checkedBox;
                      checkBox[1] = unCheckedBox;
                      checkBox[2] = unCheckedBox;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD7FDFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.h),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      checkBox[0],
                      Text(
                        "User",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        textScaleFactor: 1.5,
                      ),
                      Icon(
                        Icons.person,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                height: 60.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      checkedValue = 1;
                      checkBox[0] = unCheckedBox;
                      checkBox[1] = checkedBox;
                      checkBox[2] = unCheckedBox;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD1FFC1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.h),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      checkBox[1],
                      Text(
                        "Hospital",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        textScaleFactor: 1.5,
                      ),
                      Icon(
                        Icons.local_hospital_sharp,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                height: 60.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      checkedValue = 2;
                      checkBox[0] = unCheckedBox;
                      checkBox[1] = unCheckedBox;
                      checkBox[2] = checkedBox;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFD4D4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.h),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      checkBox[2],
                      Text(
                        "Blood Bank",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        textScaleFactor: 1.5,
                      ),
                      Icon(
                        Icons.bloodtype_sharp,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
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
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(
                              nameHint: checkedValue,
                            ),
                          ),
                          ModalRoute.withName('/'),
                        );
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 75.w,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
