import 'package:fastporte_app/widgets/button_widget.dart';
import 'package:fastporte_app/widgets/profile_widget.dart';
import 'package:fastporte_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FastPorte'),
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
          ProfileWidget(
            imagePath:
                'https://raw.githubusercontent.com/FrancoEVP10/francovp.com/main/src/images/me.jpg',
          ),
          const SizedBox(height: 24),
          buildName('Nombre Apellido', 'correo@gmail.com'),
          const SizedBox(height: 24),
          Center(child: builEditButton()),
          const SizedBox(height: 30),
          buildDescription(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque efficitur risus lorem, vulputate rhoncus lectus rhoncus vitae. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed.')
        ],
      ),
    );
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
}
