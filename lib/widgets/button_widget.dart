import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(15, 21, 163, 1),
          foregroundColor: Colors.white, shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        onPressed: onClicked,
        child: Text(text),
      );
}