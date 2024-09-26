import 'package:flutter/material.dart';

import 'login.dart';
import 'register.dart';
import 'gen-ai.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: RegisterPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/lista': (context) => GenAiPage(),
      },
      initialRoute: '/login',
    );
  }
}
