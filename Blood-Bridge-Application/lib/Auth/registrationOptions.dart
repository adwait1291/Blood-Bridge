import 'package:blood_bridge/Auth/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blood_bridge/Auth/Registration.dart';
import 'package:blood_bridge/Screens/mainScreen.dart';

class RegistrationOptions extends StatefulWidget {
  @override
  State<RegistrationOptions> createState() => _RegistrationOptionsState();
}

class _RegistrationOptionsState extends State<RegistrationOptions> {
  var checkedValue = 0;
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
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            top: 24.h,
            bottom: 24.h,
          ),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Image.asset(
                'assets/logo.png',
                height: 60.h,
              ),
              SizedBox(height: 20.h),
              Text(
                "Who are you?",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w500),
                // textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              SizedBox(
                height: 40.h,
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
                      borderRadius: BorderRadius.circular(10.r),
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
                height: 15.h,
              ),
              SizedBox(
                height: 40.h,
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
                height: 15.h,
              ),
              SizedBox(
                height: 40.h,
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
                height: 15.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.h),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Back',
                        style: TextStyle(color: Colors.white),
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
                          borderRadius: BorderRadius.circular(15.h),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(
                              nameHint: checkedValue,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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
