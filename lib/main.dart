import 'package:fastporte_app/auth/screens/screens.dart';
import 'package:fastporte_app/auth/services/services.dart';
import 'package:fastporte_app/home/navigationbottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService() ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FastPorte',
      initialRoute: 'start',
      routes: {
        
        //'checking': ( _ ) => CheckAuthScreen(),

        'home'    : ( _ ) => MainPage(),
        'start'   : ( _ ) => StartScreen(),
        'login'   : ( _ ) => LoginScreen(),
        'register': ( _ ) => RegisterScreen(),
        //'userprofile': ( _ ) => UserProfileScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Color.fromRGBO(15, 21, 163, 1)
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(15, 21, 163, 1),
          elevation: 0
        )
      ),
    );
  }
}