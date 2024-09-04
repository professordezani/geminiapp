import 'package:flutter/material.dart';

import 'login.dart';
import 'register.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: RegisterPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
      initialRoute: '/login',
    );
  }
}
