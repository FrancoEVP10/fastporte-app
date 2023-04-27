import 'package:fastporte_app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(15, 21, 163, 1),
      body: SafeArea(
        child: Center(
          child:  Column(
            children: [
              SizedBox(height: 70),
              Text('FastPorte',style: TextStyle( color: Colors.white, fontSize: 40, fontWeight: FontWeight.w400)),
              SizedBox(height: 30),
              Image.asset('assets/imgs/splash.png'),
              SizedBox(height: 90),
              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Color.fromRGBO(26, 204, 141, 1),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric( horizontal: 70, vertical: 10),
                  child: Text('Start',style: TextStyle( color: Colors.white, fontSize: 35 ))
                )
              ),
              SizedBox(height: 100),
              Container(
                  padding: EdgeInsets.symmetric( horizontal: 70, vertical: 4),
                  child: Text(
                    'By using FastPorte, I agree terms of use and privacy policies privacy',
                    textAlign: TextAlign.center,
                    style: TextStyle( color: Colors.white, fontSize: 17 ))
              ),
              //Text('y',textAlign: TextAlign.center,style: TextStyle( color: Colors.white, fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}