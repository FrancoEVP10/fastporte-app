import 'dart:async';

import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _progress = 0;
  final int _duration = 5;

  void startTimer() {
    Timer.periodic(Duration(seconds: _duration), (timer) {
      setState(() {
        if (_progress == _duration) {
          timer.cancel();
        } else {
          _progress += 0.1;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FastPorte'),
      ),
      body: Center(
        child: CircularProgressIndicator(
          value: _progress,
          color: Colors.indigo,
        ),
      ),
    );
  }
}
