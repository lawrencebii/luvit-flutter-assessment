import 'package:flutter/material.dart';
import 'package:prime_template/utils/constants.dart';

class ProfilePage extends StatefulWidget {
  final name;
  const ProfilePage({super.key, this.name});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        title: Center(
          child: Text(
            widget.name,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
