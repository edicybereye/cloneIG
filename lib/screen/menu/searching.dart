import 'package:flutter/material.dart';

class Searching extends StatefulWidget {
  @override
  _SearchingState createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
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
            ))),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  "././assets/img/search.png",
                  height: 26,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Search",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Spacer(),
                Image.asset(
                  "././assets/img/scan.png",
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
            child: Text("Searching"),
          ),
        ],
      ),
    );
  }
}
