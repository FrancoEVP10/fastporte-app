import 'package:flutter/material.dart';
import 'package:fastporte_app/auth/services/auth_service.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Franco Vasquez'), 
            accountEmail: Text('francovp10@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(child: Image.asset('assets/imgs/splash.png')),
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(15, 21, 163, 1),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_outline_outlined, size: 30),
            title: Text('Account', style: TextStyle(fontSize: 20),),
            onTap: () {}
          ),

          ListTile(
            leading: Icon(Icons.logout, size: 30),
            title: Text('Cerrar Sesión', style: TextStyle(fontSize: 20),),
            onTap: () async {
              await authService.logout();
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
      ),
    );
  }
}