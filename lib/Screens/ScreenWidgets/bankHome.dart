import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BankHome extends StatefulWidget {
  const BankHome({super.key});

  @override
  State<BankHome> createState() => _BankHomeState();
}

class _BankHomeState extends State<BankHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Bank Home"),
    );
  }
}
