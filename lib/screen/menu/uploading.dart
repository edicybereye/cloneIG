import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_ig/model/tmpPostingModel.dart';
import 'package:training_ig/network/network.dart';
import 'package:path/path.dart' as path;

class Uploading extends StatefulWidget {
  @override
  _UploadingState createState() => _UploadingState();
}

class _UploadingState extends State<Uploading> {
  String id, photo;
  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
      photo = pref.getString("photo");
    });
    fetchImage();
  }

  File _image;
  pilihGallery() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    submit();
    print(_image);
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

    try {
      var stream = http.ByteStream(DelegatingStream.typed(_image.openRead()));
      var length = await _image.length();
      var url = Uri.parse(NetworkURL.upload());
      var request = http.MultipartRequest("POST", url);
      var multiPartFile = new http.MultipartFile("file", stream, length,
          filename: path.basename(_image.path));

      request.fields['idUsers'] = id;
      request.files.add(multiPartFile);
      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((a) {
        final data = jsonDecode(a);
        int value = data['value'];
        if (value == 1) {
          fetchImage();
        } else {
          print("Gagal");
        }
      });
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
    }
  }

  delete(TmpPostingModel model) async {
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
    final response = await http.post(NetworkURL.deletePost(), body: {
      "idUsers": id,
      "file": model.file,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    if (value == 1) {
      Navigator.pop(context);
      fetchImage();
    }
  }

  var cekData = false;
  List<TmpPostingModel> list = [];
  fetchImage() async {
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
    final response = await http.get(NetworkURL.getTmpUpload(id));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      if (response.contentLength == 2) {
        setState(() {
          cekData = false;
        });
      } else {
        final data = jsonDecode(response.body);
        print(data);
        setState(() {
          for (Map i in data) {
            list.add(TmpPostingModel.fromJson(i));
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

  TextEditingController captionController = TextEditingController();

  submitPosting() async {
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
    final response = await http.post(NetworkURL.submitPosting(),
        body: {"idUsers": id, "caption": captionController.text});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      Navigator.pop(context);
      captionController.clear();
      getPref();
    } else {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning"),
              content: Text("$message"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Ok"),
                )
              ],
            );
          });
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
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
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          "New Post",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        submitPosting();
                      }),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 100,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        InkWell(
                          onTap: pilihGallery,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                )),
                            child: Icon(
                              Icons.add,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        cekData
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: list.length,
                                itemBuilder: (context, i) {
                                  final a = list[i];
                                  return InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("Information"),
                                              content: Text(
                                                  "Are you sure want to delete this photo"),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text("No")),
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      delete(a);
                                                    },
                                                    child: Text("Yes")),
                                              ],
                                            );
                                          });
                                    },
                                    child: Container(
                                        width: 100,
                                        height: 100,
                                        margin: EdgeInsets.only(right: 16),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Image.network(
                                            "${NetworkURL.server}/image/${a.file}",
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                  );
                                },
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black),
                            shape: BoxShape.circle),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            "${NetworkURL.server}/profile/$photo",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          controller: captionController,
                          decoration:
                              InputDecoration(hintText: "Write a caption..."),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
