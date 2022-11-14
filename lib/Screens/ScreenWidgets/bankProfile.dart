import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../Auth/loginPage.dart';

class BankProfile extends StatefulWidget {
  const BankProfile({super.key});

  @override
  State<BankProfile> createState() => _BankProfileState();
}

class _BankProfileState extends State<BankProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Bank Profile"),
          TextButton(
            onPressed: () async {
              
              await FirebaseAuth.instance.signOut();
              setState(() {
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
    );
  }
}
