import 'package:flutter/material.dart';
import 'package:fastporte_app/globals.dart' as globals;

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/imgs/fondo.jpg'),
          fit: BoxFit.fill,
        )),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Iniciar Sesión como',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset('assets/imgs/forgot-password.png'),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                    color: Color.fromRGBO(26, 204, 141, 1),
                    onPressed: () {
                      globals.role = 'cliente';
                      Navigator.pushNamed(context, 'login');
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                        child: Text('Cliente',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)))),
                SizedBox(
                  height: 15,
                ),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                    color: Color.fromRGBO(26, 204, 141, 1),
                    onPressed: () {
                      globals.role = 'transportista';
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        child: Text('Transportista',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
