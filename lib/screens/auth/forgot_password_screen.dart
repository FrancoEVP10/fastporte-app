import 'package:fastporte_app/providers/login_form_provider.dart';
import 'package:fastporte_app/services/services.dart';
import 'package:fastporte_app/ui/input_decorations.dart';
import 'package:fastporte_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});


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
                    Text('Forgot your Password?', style: Theme.of(context).textTheme.headlineSmall),
                    SizedBox( height: 30 ),
                    
                    ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(),
                      child: _LoginForm()
                    )
                    

                  ],
                )
              ),
              SizedBox( height: 20 ),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'register'), 
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all( Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all( StadiumBorder() )
                ),
                child: Text('No Account yet? Create Account', style: TextStyle( fontSize: 18, color: Colors.black87 ),)
              ),
              SizedBox( height: 50 ),
            ],
          ),
        )
      )
   );
  }
}


class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      child: Column(
        children: [
          
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'john.doe@gmail.com',
              labelText: 'Email address',
              prefixIcon: Icons.alternate_email_rounded
            ),
            onChanged: ( value ) => loginForm.email = value,
            validator: ( value ) {

                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);
                
                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no luce como un correo';

            },
          ),

          SizedBox( height: 30 ),

          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Color.fromRGBO(15, 21, 163, 1),
            onPressed: loginForm.isLoading ? null : () async {
              
              FocusScope.of(context).unfocus();
              final authService = Provider.of<AuthService>(context, listen: false);
              
              if( !loginForm.isValidForm() ) return;

              loginForm.isLoading = true;


              
              final String? errorMessage = await authService.login(loginForm.email, loginForm.password);

              if ( errorMessage == null ) {
                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, 'home');
              } else {
                // print( errorMessage );
                NotificationsService.showSnackbar(errorMessage);
                loginForm.isLoading = false;
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric( horizontal: 70, vertical: 15),
              child: Text(
                loginForm.isLoading 
                  ? 'Waiting...'
                  : 'Continue',
                style: TextStyle( color: Colors.white ),
              )
            )
          )

        ],
      ),
    );
  }
}