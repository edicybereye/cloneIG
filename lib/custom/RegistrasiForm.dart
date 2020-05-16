import 'package:flutter/material.dart';

class RegistrasiForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool obSecure;
  final VoidCallback showHiddenPassword;
  RegistrasiForm(
      {this.emailController,
      this.passwordController,
      this.usernameController,
      this.nameController,
      this.obSecure = true,
      this.showHiddenPassword});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          validator: (e) {
            if (e.isEmpty)
              return "Please input your email address";
            else
              return null;
          },
          controller: emailController,
          decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey, width: 1))),
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          validator: (e) {
            if (e.isEmpty)
              return "Please input your email address";
            else
              return null;
          },
          controller: nameController,
          decoration: InputDecoration(
              hintText: "Full name",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey, width: 1))),
        ),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: usernameController,
          decoration: InputDecoration(
              hintText: "Username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey, width: 1))),
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
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obSecure ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: showHiddenPassword,
              )),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
