import 'package:dvmane/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'UI/splash_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LoginService>(create: (_) => LoginService()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color(0xff0061a6),
          primaryColorLight: const Color(0xffb3e5fc),
          primaryColorDark: const Color(0xff0288d1),
          fontFamily: GoogleFonts.notoSans().fontFamily),
      home: const SplashScreen(),
    );
  }
}
