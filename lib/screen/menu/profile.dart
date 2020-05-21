import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_ig/network/network.dart';
import 'package:training_ig/screen/login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username, photo, name;
  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString("username");
      name = pref.getString("name");
      photo = pref.getString("photo");
    });
  }

  signOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("username");
    pref.remove("id");
    pref.remove("email");
    pref.remove("name");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  Future<void> onRefresh() async {
    getPref();
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

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
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          "$username",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.lock_open),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Warning"),
                              content: Text("Are you sure want sign out?"),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("No")),
                                FlatButton(
                                    onPressed: () {
                                      signOut();
                                    },
                                    child: Text("Yes")),
                              ],
                            );
                          });
                    }),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
              child: RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 90,
                        width: 90,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                  shape: BoxShape.circle),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  "${NetworkURL.server}/profile/$photo",
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                                child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white
                                ),
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: Icon(Icons.add, color: Colors.white),
                            ))
                          ],
                        ),
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "111",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Posts",
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "111",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Followers",
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "111",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Following",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "$name",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
