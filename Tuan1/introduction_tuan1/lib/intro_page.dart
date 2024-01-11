import 'dart:async';
import 'package:flutter/material.dart';
import 'homepage.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giới Thiệu'),
      ),
      body: const Center(
        child: Text('Dao Xuan Tri-20110581-E1511-CT5'),
      ),
    );
  }
}
