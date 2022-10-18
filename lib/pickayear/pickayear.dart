import 'package:flutter/material.dart';

class PickAyear extends StatefulWidget {
  @override
  _PickAyearState createState() => _PickAyearState();
}

class _PickAyearState extends State<PickAyear> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pick a year"),
      ),
      body: Column(
        children: [
          Text("data"),
        ],
      ),
    );
  }
}
