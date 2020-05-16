import 'package:flutter/material.dart';
import 'package:training_ig/custom/billaBongText.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.grey[300],
                )
              )
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  "././assets/img/camera.png",
                  height: 30,
                ),
                SizedBox(
                  width: 16,
                ),
                BillaBongText(
                  "Instagram",
                  fontSize: 30,
                ),
                Spacer(),
                Image.asset(
                  "././assets/img/send.png",
                  height: 30,
                ),
                 SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text("Home"),
          ),
        ],
      ),
    );
  }
}
