import 'package:flutter/material.dart';

import 'login.dart';
import 'register.dart';
import 'lista.dart';

// Color c1 = Color(0xFFf5f5f2);
// Color c2 = Color(0xFF503f1e);
// Color c3 = Color(0xFF6a936c);
// Color c4 = Color(0xFF144a25);
// Color c5 = Color(0xFF7e9672);
// Color c6 = Color(0xFF3e583b);
// Color c7 = Color(0xFF7fbfb0);
// Color c8 = Color(0xFF9b7335);
// Color c9 = Color(0xFF364b2b);
// Color ca = Color(0xFF4a7146);
// Color cb = Color(0xFF8ca18c);
// Color cc = Color(0xFF5d4c29);
// Color cd = Color(0xFFe3d8d3);
// Color ce = Color(0xFF9fbdac);
// Color cf = Color(0xFF6a7c61);
// Color cg = Color(0xFF6b8d76);
// Color ch = Color(0xFF9c8455);
// Color ci = Color(0xFF213326);
// Color cj = Color(0xFFc8a284);
// Color cl = Color(0xFF47644c);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFe4e0cf),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFFe4e0cf),
            foregroundColor: Color(0xFF144a25),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xFF144a25)),
              foregroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(Color(0xFF144a25)),
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF144a25),
            foregroundColor: Color(0xFFFFFFFF),
          )),
      debugShowCheckedModeBanner: false,
      // home: RegisterPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/lista': (context) => ListaPage(),
      },
      initialRoute: '/login',
    );
  }
}
