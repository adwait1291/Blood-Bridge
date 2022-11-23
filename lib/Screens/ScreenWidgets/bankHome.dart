import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankHome extends StatefulWidget {
  const BankHome({super.key});

  @override
  State<BankHome> createState() => _BankHomeState();
}

class _BankHomeState extends State<BankHome> {
  var matchedDonationID = [];
  var matchedDonationDetails = [];

  var donorName;
  var receiverName;
  var donorMob;
  var receiverMob;
  bool _isLoadingDonation = false;

  Future<void> getUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final currentUserData =
        await FirebaseFirestore.instance.doc('users/' + uid!).get();
    matchedDonationID = currentUserData['matchedDonation'];
  }

  Future<void> getDonationData() async {
    for (var dons in matchedDonationID) {
      var donor = dons['Donor'];
      var receiver = dons['Receiver'];
      final donorData =
          await FirebaseFirestore.instance.doc('users/' + donor).get();
      donorName = donorData['name'];
      donorMob = donorData['mobileNo'];

      final receiverData =
          await FirebaseFirestore.instance.doc('users/' + receiver).get();
      receiverName = receiverData['name'];
      receiverMob = receiverData['mobileNo'];

      matchedDonationDetails.add({
        'donorName': donorName,
        'donorMob': donorMob,
        'receiverName': receiverName,
        'receiverMob': receiverMob
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 1.h,
          ),
          TextButton(
              onPressed: _isLoadingDonation
                  ? null
                  : () async {
                      setState(() {
                        _isLoadingDonation = true;
                      });
                      matchedDonationDetails = [];
                      await getUserData();
                      await getDonationData();
                      setState(() {
                        _isLoadingDonation = false;
                      });
                    },
              child: _isLoadingDonation
                  ? CircularProgressIndicator()
                  : Text("Refresh")),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              children: [
                Column(
                  children: [
                    matchedDonationDetails.length == 0
                        ? Container(
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
                                  "Donation details will be shown here",
                                  style: TextStyle(color: Colors.black54),
                                )
                              ],
                            ))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: matchedDonationDetails.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(15.r),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                255, 187, 186, 186),
                                            blurRadius: 2.r,
                                            blurStyle: BlurStyle.outer,
                                            offset: const Offset(0, 2)),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Donation No: " +
                                                  (index + 1).toString(),
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
                                            Text("Donor Name :      "),
                                            SizedBox(width: 10.w),
                                            Text(matchedDonationDetails[index]
                                                ['donorName']),
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            SizedBox(width: 30.w),
                                            Text("Donor Mob :        "),
                                            SizedBox(width: 10.w),
                                            Text(matchedDonationDetails[index]
                                                ['donorMob']),
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            SizedBox(width: 30.w),
                                            Text("Receiver Name : "),
                                            SizedBox(width: 10.w),
                                            Text(matchedDonationDetails[index]
                                                ['receiverName']),
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            SizedBox(width: 30.w),
                                            Text("Receiver Mob :    "),
                                            SizedBox(width: 10.w),
                                            Text(matchedDonationDetails[index]
                                                ['receiverMob']),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h)
                                ],
                              );
                            },
                          ),
                    SizedBox(
                      height: 15.h,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
