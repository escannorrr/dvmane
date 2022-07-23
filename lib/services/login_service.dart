import 'dart:convert';
import 'dart:developer';

import 'package:dvmane/UI/home_screen.dart';

import '../PoJos/response/login_response_class.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginService extends ChangeNotifier{

  LoginResponseClass loginResponseClass = LoginResponseClass();
  int state = 0;

  getPostData(mobileNo,password,context) async {
    state = 1;
    loginResponseClass = await login(mobileNo,password);
    if(loginResponseClass.state=="success"){
      state = 2;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Logged in Successfully.")));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const HomePage()));
    }else{
      state = 0;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "${loginResponseClass.msg}")));
    }

    notifyListeners();
  }

  Future<LoginResponseClass> login(mobileNo,password) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST', Uri.parse('http://65.1.104.178/api/users/checkLogin'));
      request.body = json.encode(
          {"contact": "$mobileNo", "password": "$password", "flag": "mobile"});
      request.headers.addAll(headers);

      var response = await request.send();

      if (response.statusCode == 200) {
        String response1 = await response.stream.bytesToString();
        LoginResponseClass loginResponseClass = LoginResponseClass.fromJson(
            json.decode(response1));
        return loginResponseClass;
      } else {
        String response1 = await response.stream.bytesToString();
        LoginResponseClass loginResponseClass = LoginResponseClass.fromJson(
            json.decode(response1));
        return loginResponseClass;
      }
    } catch (e) {
      log("LOGIN_EXCEPTION:- $e");
      return Future.error("fail");
    }
  }
}
