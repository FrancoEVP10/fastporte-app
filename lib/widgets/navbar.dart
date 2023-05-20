import 'package:fastporte_app/auth/services/user_service.dart';
import 'package:fastporte_app/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:fastporte_app/auth/services/auth_service.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  final userService = UserService();

  NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final userFuture = userService.getUserById(globals.localId);
    final authService = Provider.of<AuthService>(context, listen: false);
    return FutureBuilder(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final user = snapshot.data!;
              final name = user.name;
              final lastname = user.lastname;
              final email = user.email;
              final photo = user.photo;

              return Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text('$name $lastname'),
                      accountEmail: Text(email),
                      currentAccountPicture: CircleAvatar(
                        child: _buildChild(photo),
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(15, 21, 163, 1),
                      ),
                    ),
                    ListTile(
                        leading: Icon(Icons.person_outline_outlined, size: 30),
                        title: Text(
                          'Perfil de usuario',
                          style: TextStyle(fontSize: 20),
                        ),
                        onTap: () {
                          Navigator.pushReplacementNamed(context, 'profile');
                        }),
                    ListTile(
                      leading: Icon(Icons.logout, size: 30),
                      title: Text(
                        'Cerrar Sesión',
                        style: TextStyle(fontSize: 20),
                      ),
                      onTap: () async {
                        await authService.logout();
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, 'login');
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Text('No se pudo obtener la información');
            }
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

Widget _buildChild(String photo) {
  if (photo == '') {
    return ClipOval(child: Image.asset('assets/imgs/user-vector.png'));
  } else {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
          color: Colors.white,
          image:
              DecorationImage(image: NetworkImage(photo), fit: BoxFit.contain),
          shape: BoxShape.circle,
          border: Border.all(
            color: Color.fromRGBO(26, 204, 141, 1),
            width: 4,
          )),
    );
  }
}
