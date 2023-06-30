import 'package:fastporte_app/auth/services/user_service.dart';
import 'package:fastporte_app/static/loading_screen.dart';
import 'package:fastporte_app/widgets/button_widget.dart';
import 'package:fastporte_app/globals.dart' as globals;
import 'package:fastporte_app/widgets/profile_widget.dart';
import 'package:fastporte_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final isDialOpen = ValueNotifier(false);
  final userService = UserService();
  final activeRole = globals.role == 'transportista' ? true : false;

  @override
  Widget build(BuildContext context) {
    final userFuture = userService.getUserById(globals.localId);
    return FutureBuilder(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final user = snapshot.data!;
              final name = user.name;
              final lastname = user.lastname;
              final email = user.email;
              final description = user.description;
              final phone = user.phone;
              final region = user.region;
              final birthdate = user.birthdate;
              final image = user.photo;
              final age = DateTime.now().year - birthdate.year;

              return WillPopScope(
                onWillPop: () async {
                  if (isDialOpen.value) {
                    isDialOpen.value = false;

                    return false;
                  } else {
                    return true;
                  }
                },
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text('Mi Perfil'),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'home');
                      },
                    ),
                  ),
                  body: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(height: 15),
                      if (image != '')
                        ProfileWidget(
                          imagePath: image,
                        ),
                      if (image == '')
                        ClipOval(
                          child: Image.asset(
                            'assets/imgs/user-vector.png',
                            height: 120,
                          ),
                        ),
                      const SizedBox(height: 24),
                      buildName('$name $lastname', email),
                      const SizedBox(height: 30),
                      buildDescription(description),
                      const SizedBox(height: 24),
                      Container(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: builEditButton(),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          'Información Personal',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'Edad',
                          ),
                          initialValue: age.toString(),
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'Teléfono',
                          ),
                          initialValue: phone,
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'Región',
                          ),
                          initialValue: region,
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (globals.role == 'transportista')
                        Column(
                          children: [
                            Center(
                              child: Text(
                                'Experiencia',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  labelText: 'Trabajo',
                                ),
                                initialValue:
                                    'Conductor de Turismo en "Turismo Perú"',
                                readOnly: true,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  labelText: 'Tiempo',
                                ),
                                initialValue: '10 años',
                                readOnly: true,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: Text(
                                'Acerca del vehículo',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            buildCardsVehicle(),
                            const SizedBox(height: 20),
                          ],
                        ),
                    ],
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.endFloat,
                  floatingActionButton: SpeedDial(
                    visible: activeRole,
                    animatedIcon: AnimatedIcons.menu_close,
                    overlayColor: Colors.black,
                    overlayOpacity: 0.4,
                    spaceBetweenChildren: 12,
                    children: [
                      SpeedDialChild(
                          child: Icon(Icons.fire_truck_sharp),
                          backgroundColor: Color.fromRGBO(26, 204, 141, 1),
                          label: 'Editar Vehículo'),
                      SpeedDialChild(
                          child: Icon(Icons.star),
                          backgroundColor: Color.fromRGBO(26, 204, 141, 1),
                          label: 'Experiencia')
                    ],
                  ),
                ),
              );
            } else {
              return Text('No se pudo obtener la información');
            }
          } else {
            return LoadingScreen();
          }
        });
  }

  Widget buildName(String user, String email) => Column(
        children: [
          Text(
            user,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );

  Widget buildDescription(String descripcion) => CardContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Descripción',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              descripcion,
              style: TextStyle(fontSize: 16, height: 1.4),
              textAlign: TextAlign.justify,
            )
          ],
        ),
      );

  Widget builEditButton() => ButtonWidget(
        text: 'Editar Perfil',
        onClicked: () {
          Navigator.pushReplacementNamed(context, 'editprofile');
        },
      );

  Widget buildCardsVehicle() => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Marca',
              ),
              initialValue: 'Marca',
              readOnly: true,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Categoría',
              ),
              initialValue: 'Categoría',
              readOnly: true,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Tipo de carro',
              ),
              initialValue: 'Tipo de carro',
              readOnly: true,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                labelText: 'Capacidad de personas',
              ),
              initialValue: '15',
              readOnly: true,
            ),
          ),
          const SizedBox(height: 20),
          CardContainer(
              child: Column(
            children: [
              Center(
                child: Text(
                  'Foto',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                height: 100,
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaGTkangAvWyBxzH5edVlfI4UH9KSaUude7Q&usqp=CAU',
                  height: 200,
                  width: 230,
                ),
              ),
            ],
          )),
        ],
      );
}
