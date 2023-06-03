import 'package:fastporte_app/auth/services/user_service.dart';
import 'package:fastporte_app/widgets/user_card_information.dart';
import 'package:fastporte_app/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  //final userService = UserService();
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    final userFuture = userService.getUserById(globals.localId);
    return FutureBuilder(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final user = snapshot.data!;
              final name = user.name;
              final image = user.photo;
              userService.selectedUser = user.copy();

              return Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 30),
                          Text(
                            'Hola $name',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30),
                          if (image != '')
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: NetworkImage(image),
                                      fit: BoxFit.contain),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color.fromARGB(255, 42, 11, 165),
                                    width: 4,
                                  )),
                            ),
                          if (image == '')
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
