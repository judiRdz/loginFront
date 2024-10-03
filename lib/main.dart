import 'package:flutter/material.dart';
import 'package:login_test/screens/cheking_screen.dart';
import 'package:login_test/screens/login_screen.dart';
import 'package:login_test/screens/registro_screen.dart';
import 'package:login_test/services/auth_services.dart';
import 'package:login_test/services/notifications_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AuthServices()),
    ],
    child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Demon',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 247, 230, 196)),
        useMaterial3: true
      ),
      initialRoute: 'cheking',
      routes: {
        'login': (_) => LoginScreen(),
        'register': (_) => RegistroScreen(),
        'home': (_) => PrincipalScreen(),
        'checking': (_) => CheckAuthScreen()
      },
      scaffoldMessengerKey: NotificationServices.messengerKey);
  }
}

