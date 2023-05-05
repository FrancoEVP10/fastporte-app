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
              Image.asset('assets/imgs/splash.png', width: 300,),
              SizedBox(height: 90),
              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Color.fromRGBO(26, 204, 141, 1),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'select');
                },
                child: Container(
                  padding: EdgeInsets.symmetric( horizontal:40, vertical: 15),
                  child: Text('Comenzar',style: TextStyle( color: Colors.white, fontSize: 35 ))
                )
              ),
              SizedBox(height: 50),
              Container(
                  padding: EdgeInsets.symmetric( horizontal: 70, vertical: 4),
                  child: Text(
                    'Al utilizar FastPorte, acepto las condiciones de uso y las políticas de privacidad',
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