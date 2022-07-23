import 'dart:async';

import 'package:dvmane/PoJos/response/login_response_class.dart';
import 'package:dvmane/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controllerMobileNo = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  FocusNode mobileNumberNode = FocusNode();
  FocusNode pwdNode = FocusNode();

  bool? _validateFlag = true, _obscureTextConfirm = true;
  int _state = 0;
  var loginService;

  void _toggleConfirm() {
    setState(() {
      _obscureTextConfirm = !_obscureTextConfirm!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Hey there,",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            const Text(
              "Log In",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 40.0,
            ),
            TextFormField(
              controller: controllerMobileNo,
              focusNode: mobileNumberNode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                String newValue = value!.trim();
                if (value.trim().length != 10) {
                  _validateFlag = false;
                } else {
                  _validateFlag = true;
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Mobile Number",
                  labelStyle: const TextStyle(
                    fontSize: 16.0,
                  ),
                  errorText:
                      _validateFlag! ? null : "Mobile number must be 10 digits",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.phone_iphone_outlined,
                  ),
                  contentPadding: const EdgeInsets.all(0.0)),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                LengthLimitingTextInputFormatter(10),
              ],
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.blue,
              ),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(pwdNode);
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: controllerPassword,
              focusNode: pwdNode,
              decoration: InputDecoration(
                  labelText: "Passsword",
                  labelStyle: const TextStyle(
                    fontSize: 16.0,
                  ),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        _toggleConfirm();
                      },
                      child: _obscureTextConfirm!
                          ? const Icon(Icons.visibility_off, color: Colors.grey)
                          : const Icon(Icons.visibility, color: Colors.blue)),
                  contentPadding: const EdgeInsets.all(0.0)),
              obscureText: _obscureTextConfirm!,
              keyboardType: TextInputType.text,
              // inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),LengthLimitingTextInputFormatter(10),],
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith((states) =>
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                  backgroundColor: MaterialStateProperty.resolveWith((states) => loginService.state==2?Colors.green:Colors.blue[600])
                  ),
                  onPressed: () async {
                    setState(() {
                      if (loginService.state == 0) {
                        loginService.getPostData(
                            controllerMobileNo.text, controllerPassword.text,context);
                      }
                    });
                  },
                  child: setUpButtonChild(loginService.state)),
            )
          ],
        ),
      ),
    );
  }

  Widget setUpButtonChild(state) {
    if (state == 0) {
      return const Text(
        "Login",
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      );
    } else if (state == 1) {
      return const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return const Icon(Icons.check, color: Colors.white);
    }
  }

  void callLoginMethod() {
    setState(() {
      _state = 1;
    });

    Timer(const Duration(milliseconds: 3300), () {
      setState(() {
        _state = 2;
      });
    });
  }
}
