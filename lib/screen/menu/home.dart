import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_ig/custom/billaBongText.dart';
import 'package:http/http.dart' as http;
import 'package:training_ig/custom/carouselCustom.dart';
import 'package:training_ig/model/postModel.dart';
import 'package:training_ig/network/network.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const carouselDuration = const Duration(microseconds: 300);
  static const carouselCurve = Curves.ease;
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  PageController carouselController = PageController();
  PageController dotController = PageController();
  ValueChanged<int> carouselPageChanged;

  List<Widget> carouselList;
  Color indicatorColor;

  String idUsers;
  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      idUsers = pref.getString("id");
    });
    _fetchPosting();
  }

  var cekData = false;
  List<PostModel> list = [];
  _fetchPosting() async {
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
    list.clear();
    final response = await http.get(NetworkURL.getPostingUsers(idUsers));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      if (response.contentLength == 2) {
        setState(() {
          cekData = false;
        });
      } else {
        final data = jsonDecode(response.body);
        setState(() {
          for (Map i in data) {
            list.add(PostModel.fromJson(i));
          }
          cekData = true;
        });
      }
    } else {
      Navigator.pop(context);
      setState(() {
        cekData = false;
      });
    }
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
          cekData
              ? Expanded(
                  child: RefreshIndicator(
                    onRefresh: onRefresh,
                    child: ListView(
                      children: <Widget>[
                        ListView.builder(
                            itemCount: list.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, i) {
                              final a = list[i];
                              return Container(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.black),
                                                shape: BoxShape.circle),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                "${NetworkURL.server}/profile/${a.photo}",
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            "${a.username}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Spacer(),
                                          IconButton(
                                              icon: Icon(Icons.menu),
                                              onPressed: () {})
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 280,
                                      child: Stack(
                                        children: <Widget>[
                                          PageView.builder(
                                              physics: ClampingScrollPhysics(),
                                              controller: carouselController,
                                              onPageChanged:
                                                  carouselPageChanged,
                                              itemCount: a.data.length,
                                              itemBuilder: (context, i) {
                                                final b = a.data[i];
                                                return Container(
                                                  child: Image.network(
                                                    "${NetworkURL.server}/image/${b.detail}",
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Row(
                                          children: <Widget>[
                                            Image.asset(
                                              "././assets/img/love.png",
                                              height: 30,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Image.asset(
                                              "././assets/img/comment.png",
                                              height: 30,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Image.asset(
                                              "././assets/img/send.png",
                                              height: 30,
                                            ),
                                            Spacer(),
                                            Image.asset(
                                              "././assets/img/withlist.png",
                                              height: 30,
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Wrap(
                                            children: <Widget>[
                                              Text("${a.username}"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("${a.description}")
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("${a.createdDate}"),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
