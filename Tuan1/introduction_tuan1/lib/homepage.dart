import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang Chủ'),
      ),
      body: Center(
        child: Text('Xin chào từ trang chủ!'),
      ),
    );
  }
}
