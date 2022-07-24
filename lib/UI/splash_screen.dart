import 'package:dvmane/UI/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }

  navigate()async{
    var storage = FlutterSecureStorage();
    if(await storage.read(key: 'TOKEN')!=null || await storage.read(key: 'TOKEN')!=""){
      Future.delayed(const Duration(seconds: 3),(){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomePage()));
      });
    }else{
      Future.delayed(const Duration(seconds: 3),(){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "D. V. Mane\nAssociates",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40.0,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
