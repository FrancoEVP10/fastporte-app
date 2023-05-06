import 'package:fastporte_app/widgets/user_card_information.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(height: 30),
            Text(
              'Hola Nombre',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ClipOval(
              child: Image.asset(
                'assets/imgs/user-vector.png',
                height: 120,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Transportistas Populares',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            UserCardInformation(),
            SizedBox(height: 15),
            UserCardInformation(),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Contactos Recientes',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 15),
            UserCardInformation(),
            SizedBox(height: 15),
            UserCardInformation(),
            SizedBox(height: 15),
          ]),
        ),
      ),
    );
  }
}
