import 'package:fastporte_app/auth/providers/user_form_provider.dart';
import 'package:fastporte_app/auth/services/user_service.dart';
import 'package:flutter/material.dart';
//import 'package:fastporte_app/globals.dart' as globals;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    return ChangeNotifierProvider(
      create: (_) => UserFormProvider(userService.selectedUser),
      child: _UserScreenBody(userService: userService),
    );
  }
}

class _UserScreenBody extends StatelessWidget {
  final UserService userService;
  const _UserScreenBody({Key? key, required this.userService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userForm = Provider.of<UserFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FastPorte'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                'Editar Información Personal',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 20),
            _UserForm(),
            SizedBox(height: 20),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Color.fromRGBO(15, 21, 163, 1),
              onPressed: userService.isSaving
                  ? null
                  : () async {
                      if (userForm.isValidForm()) return;

                      userForm.isLoading = true;

                      await userService.updateUser(userForm.user);

                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacementNamed(context, 'profile');

                      userForm.isLoading = false;
                    },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                child: Text(
                  userService.isSaving ? 'Guardando...' : 'Guardar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              color: Color.fromRGBO(15, 21, 163, 1),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'profile');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserForm extends StatelessWidget {
  const _UserForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userForm = Provider.of<UserFormProvider>(context);
    final user = userForm.user;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            inputFormatters: [LengthLimitingTextInputFormatter(100)],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              labelText: 'Nomnbre',
            ),
            initialValue: user.name,
            onChanged: (value) => user.name = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El nombre es obligatorio';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            inputFormatters: [LengthLimitingTextInputFormatter(100)],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              labelText: 'Apellido',
            ),
            initialValue: user.lastname,
            onChanged: (value) => user.lastname = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El apellido es obligatorio';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            inputFormatters: [LengthLimitingTextInputFormatter(9)],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              labelText: 'Teléfono',
            ),
            initialValue: user.phone,
            onChanged: (value) => user.phone = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El teléfono es obligatorio';
              }
              return null;
            },
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
            initialValue: user.region,
            onChanged: (value) => user.region = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'La región es obligatorio';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
            inputFormatters: [LengthLimitingTextInputFormatter(255)],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              labelText: 'Descripción',
            ),
            initialValue: user.description,
            onChanged: (value) => user.description = value,
            maxLines: 7,
            minLines: 1,
          ),
        ),
      ],
    );
  }
}
