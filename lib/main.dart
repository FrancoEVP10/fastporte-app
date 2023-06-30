import 'package:fastporte_app/comments/services/comments_service.dart';
import 'package:fastporte_app/contracts/screens/screens.dart';
import 'package:fastporte_app/auth/screens/edit_profile_screen.dart';
import 'package:fastporte_app/auth/screens/screens.dart';
import 'package:fastporte_app/auth/services/services.dart';
import 'package:fastporte_app/auth/services/user_service.dart';
import 'package:fastporte_app/contracts/services/contract_service.dart';
import 'package:fastporte_app/home/navigationbottom_bar.dart';
import 'package:fastporte_app/comments/screens/driver_info.dart';
import 'package:fastporte_app/static/support_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => UserService()),
        ChangeNotifierProvider(create: (_) => ContractService()),
        ChangeNotifierProvider(create: (_) => CommentsService()),
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

        'home': (_) => MainPage(),
        'select': (_) => SelectRoleScreen(),
        'start': (_) => StartScreen(),
        'login': (_) => LoginScreen(),
        'register': (_) => RegisterScreen(),
        'support': (_) => SupportScreen(),
        'profile': (_) => UserProfileScreen(),
        'editprofile': (_) => EditProfileScreen(),
        'history': (_) => HistoryScreen(),
        'usercontracts': (_) => UserContractsScreen(),
        'driverinfo': (_) => DriverInfoScreen(),
        
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme:
              AppBarTheme(elevation: 0, color: Color.fromRGBO(15, 21, 163, 1)),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Color.fromRGBO(15, 21, 163, 1), elevation: 0)),
    );
  }
}
