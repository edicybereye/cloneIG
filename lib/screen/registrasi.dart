import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:training_ig/custom/RegistrasiForm.dart';
import 'package:training_ig/custom/billaBongText.dart';
import 'package:training_ig/custom/customButton.dart';
import 'package:http/http.dart' as http;
import 'package:training_ig/network/network.dart';

class Registrasi extends StatefulWidget {
  @override
  _RegistrasiState createState() => _RegistrasiState();
}

class _RegistrasiState extends State<Registrasi> {
  var obSecure = true;
  final _key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  cek() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      submit();
    }
  }

  submit() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Processing.."),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 16,
                ),
                Text("Please wait...")
              ],
            ),
          );
        });
    final response = await http.post(NetworkURL.registrasi(), body: {
      "email": emailController.text.trim(),
      "username": usernameController.text.trim(),
      "password": passwordController.text.trim(),
      "name": nameController.text.trim(),
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("$message"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.pop(context), child: Text("Ok")),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Form(
                key: _key,
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: <Widget>[
                    BillaBongText(
                      "Instagram",
                      fontSize: 50,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RegistrasiForm(
                      emailController: emailController,
                      nameController: nameController,
                      passwordController: passwordController,
                      usernameController: usernameController,
                      obSecure: obSecure,
                      showHiddenPassword: () {
                        setState(() {
                          obSecure = !obSecure;
                        });
                      },
                    ),
                    InkWell(
                      onTap: () {
                        cek();
                      },
                      child: CustomButton(
                        "Sign up",
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                width: 1,
                color: Colors.grey,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "By signing up, you agree to our",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      " Terms &",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      " Policy",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
