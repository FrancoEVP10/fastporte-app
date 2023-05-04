import 'package:fastporte_app/auth/providers/login_form_provider.dart';
import 'package:fastporte_app/auth/services/services.dart';
import 'package:fastporte_app/ui/input_decorations.dart';
import 'package:fastporte_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox( height: 250 ),

              CardContainer(
                child: Column(
                  children: [

                    SizedBox( height: 10 ),
                    Text('Crea una nueva cuenta', style: Theme.of(context).textTheme.headlineSmall ),
                    SizedBox( height: 30 ),
                    
                    ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(),
                      child: _RegisterForm()
                    )
                    

                  ],
                )
              ),

              SizedBox( height: 50 ),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'login'), 
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all( Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all( StadiumBorder() )
                ),
                child: Text('Ya tienes una cuenta? Inicia sesión', style: TextStyle( fontSize: 18, color: Colors.black87 ),)
              ),
              SizedBox( height: 50 ),
            ],
          ),
        )
      )
   );
  }
}


class _RegisterForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final registerForm = Provider.of<LoginFormProvider>(context);

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
              prefixIcon: Icons.alternate_email_rounded
            ),
            onChanged: ( value ) => registerForm.email = value,
            validator: ( value ) {

                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);
                
                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no luce como un correo';

            },
          ),

          SizedBox( height: 30 ),

          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: '*****',
              labelText: 'Password',
              prefixIcon: Icons.lock_outline
            ),
            onChanged: ( value ) => registerForm.password = value,
            validator: ( value ) {
                return ( value != null && value.length >= 6 ) 
                  ? null
                  : 'La contraseña debe de ser de 6 caracteres';                                     
            },
          ),

          SizedBox( height: 30 ),

          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Color.fromRGBO(15, 21, 163, 1),
            onPressed: registerForm.isLoading ? null : () async {
              
              FocusScope.of(context).unfocus();
              final authService = Provider.of<AuthService>(context, listen: false);
              
              if( !registerForm.isValidForm() ) return;

              registerForm.isLoading = true;

              final String? errorMessage = await authService.createUser(registerForm.email, registerForm.password);

              if ( errorMessage == null ) {
                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, 'home');
              } else {
                //print( errorMessage );
                registerForm.isLoading = false;
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric( horizontal: 50, vertical: 15),
              child: Text(
                registerForm.isLoading 
                  ? 'Esperando....'
                  : 'Comenzar',
                style: TextStyle( color: Colors.white ),
              )
            )
          )

        ],
      ),
    );
  }
}