import 'package:flutter/material.dart';
import 'package:training_ig/custom/billaBongText.dart';
import 'package:training_ig/custom/customButton.dart';

class Registrasi extends StatefulWidget {
  @override
  _RegistrasiState createState() => _RegistrasiState();
}

class _RegistrasiState extends State<Registrasi> {
  var obSecure = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                    decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Full name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Username",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                   TextFormField(
                    obscureText: obSecure,
                    decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obSecure ? Icons.visibility_off : Icons.visibility,
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
                    onTap: () {},
                    child: CustomButton(
                      "Sign up",
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
