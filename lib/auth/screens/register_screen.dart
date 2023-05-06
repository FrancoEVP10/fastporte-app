import 'package:fastporte_app/auth/model/user.dart';
import 'package:fastporte_app/auth/providers/register_form_provider.dart';
import 'package:fastporte_app/auth/services/services.dart';
import 'package:fastporte_app/ui/input_decorations.dart';
import 'package:fastporte_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:fastporte_app/globals.dart' as globals;

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 250),
          CardContainer(
              child: Column(
            children: [
              SizedBox(height: 10),
              Text('Crea una nueva cuenta',
                  style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 30),
              ChangeNotifierProvider(
                  create: (_) => RegisterFormProvider(), child: _RegisterForm())
            ],
          )),
          SizedBox(height: 50),
          TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())),
              child: Text(
                'Ya tienes una cuenta? Inicia sesión',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              )),
          SizedBox(height: 50),
        ],
      ),
    )));
  }
}

class _RegisterForm extends StatefulWidget {
  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  TextEditingController dateController = TextEditingController();
  List<String> regiones = [
    'Amazonas',
    'Anchas',
    'Apurimac',
    'Arequipa',
    'Ayacucho',
    'Cajamarca',
    'Callao',
    'Cusco',
    'Huancavelica',
    'Huanuco',
    'Ica',
    'Junin',
    'La Libertad',
    'Lambayeque',
    'Lima',
    'Loreto',
    'Madre de Dios',
    'Moquegua',
    'Pasco',
    'Piura',
    'Puno',
    'San Martín',
    ' Tacna',
    'Tumbes',
    'Ucayali'
  ];
  String? selectedItem = 'Amazonas';

  @override
  void initState() {
    dateController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    DateFormat inputFormat = DateFormat('dd-MM-yyyy');
    final registerForm = Provider.of<RegisterFormProvider>(context);

    return Form(
      key: registerForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'john.doe@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_rounded),
            onChanged: (value) => registerForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no luce como un correo';
            },
          ),
          SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Password',
                prefixIcon: Icons.lock_outline),
            onChanged: (value) => registerForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe de ser de 6 caracteres';
            },
          ),
          SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'John',
                labelText: 'Nombre',
                prefixIcon: Icons.person),
            onChanged: (value) => registerForm.name = value,
            validator: (value) {
              return (value != null) ? null : 'Este campo es requerido';
            },
          ),
          SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'Doe',
                labelText: 'Apellido',
                prefixIcon: Icons.person),
            onChanged: (value) => registerForm.lastname = value,
            validator: (value) {
              return (value != null) ? null : 'Este campo es requerido';
            },
          ),
          SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'johndoe10',
                labelText: 'Nombre de Usuario',
                prefixIcon: Icons.person),
            onChanged: (value) => registerForm.username = value,
            validator: (value) {
              return (value != null) ? null : 'Este campo es requerido';
            },
          ),
          SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
                hintText: '987654321',
                labelText: 'Número de celular',
                prefixIcon: Icons.phone),
            onChanged: (value) => registerForm.phone = value,
            validator: (value) {
              if (value == null) {
                return 'Este campo es obligatorio';
              } else if (value.length != 9) {
                return 'Ingrese un número válido';
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 30),
          TextFormField(
            controller: dateController,
            decoration: InputDecorations.authInputDecoration(
              hintText: '10/01/2000',
              labelText: "Fecha de nacimiento",
              prefixIcon: Icons.calendar_month,
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now());

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('dd-MM-yyyy').format(pickedDate);

                setState(() {
                  dateController.text = formattedDate;
                });
              }

              registerForm.birthdate = inputFormat.parse(dateController.text);
            },
          ),
          SizedBox(height: 30),
          DropdownButtonFormField<String>(
            decoration: InputDecorations.authInputDecoration(
              hintText: 'Selecciona tu región',
              labelText: 'Región',
              prefixIcon: Icons.location_on,
            ),
            value: selectedItem,
            items: regiones
                .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 20),
                    )))
                .toList(),
            onChanged: (item) {
              setState(() => selectedItem = item);
              registerForm.region = selectedItem!;
            },
          ),
          SizedBox(height: 30),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Color.fromRGBO(15, 21, 163, 1),
              onPressed: registerForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!registerForm.isValidForm()) return;

                      registerForm.isLoading = true;

                      final String? errorMessage =
                          await authService.createUserFirebase(
                              registerForm.email, registerForm.password);
                      final String id = globals.localId;
                      if (errorMessage == null) {
                        if (globals.role == 'cliente') {
                          await authService.createUserBackend(User(
                              birthdate: registerForm.birthdate,
                              description: '',
                              email: registerForm.email,
                              id: id,
                              lastname: registerForm.lastname,
                              name: registerForm.name,
                              phone: registerForm.phone,
                              photo: '',
                              region: registerForm.region,
                              username: registerForm.username));
                        } else if (globals.role == 'transportista') {
                          await authService.createUserDriverBackend(User(
                              birthdate: registerForm.birthdate,
                              description: '',
                              email: registerForm.email,
                              id: id,
                              lastname: registerForm.lastname,
                              name: registerForm.name,
                              phone: registerForm.phone,
                              photo: '',
                              region: registerForm.region,
                              username: registerForm.username));
                        }
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        //print( errorMessage );
                        registerForm.isLoading = false;
                      }
                    },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  child: Text(
                    registerForm.isLoading ? 'Esperando....' : 'Comenzar',
                    style: TextStyle(color: Colors.white),
                  )))
        ],
      ),
    );
  }
}
