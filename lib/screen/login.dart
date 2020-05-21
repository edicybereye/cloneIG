import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_ig/custom/billaBongText.dart';
import 'package:training_ig/custom/customButton.dart';
import 'package:training_ig/model/loginModel.dart';
import 'package:training_ig/network/network.dart';
import 'package:training_ig/screen/menu.dart';
import 'package:training_ig/screen/registrasi.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginModel model;
  String username;

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString("username");

      username != null
          ? Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Menu()))
          : null;
    });
  }

  var obSecure = true;
  final _key = GlobalKey<FormState>();

  cek() {
    if (_key.currentState.validate()) {
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
    final response = await http.post(NetworkURL.login(), body: {
      "username": usernameController.text.trim(),
      "password": passwordController.text.trim(),
    });
    model = LoginModel.api(jsonDecode(response.body));
    if (model.value == 1) {
      Navigator.pop(context);
      savePref(
        model.id,
        model.email,
        model.username,
        model.name,
        model.createdDate,
        model.photo,
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Menu()));
    } else {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("${model.message}"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Ok"),
                ),
              ],
            );
          });
    }
  }

  savePref(
    String id,
    String email,
    String username,
    String name,
    String createdDate,
    String photo,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setString("id", id);
      pref.setString("email", email);
      pref.setString("username", username);
      pref.setString("name", name);
      pref.setString("createdDate", createdDate);
      pref.setString("photo", photo);
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
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
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          hintText: "Email or Username",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1))),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: obSecure,
                      decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obSecure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                obSecure = !obSecure;
                              });
                            },
                          )),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        cek();
                      },
                      child: CustomButton(
                        "Login",
                        color: Colors.purple,
                      ),
                    ),
                  ],
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
                      "Don't have an account?",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registrasi()));
                      },
                      child: Text(
                        " Sign Up",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
