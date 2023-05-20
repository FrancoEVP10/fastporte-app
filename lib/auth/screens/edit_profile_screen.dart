import 'package:fastporte_app/widgets/edit_profile_widget.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FastPorte'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'profile');
          },
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          EditProfileWidget(
            imagePath:
                'https://raw.githubusercontent.com/FrancoEVP10/francovp.com/main/src/images/me.jpg',
            onClicked: (){},
          )
        ],
      ),
    );
  }
}
