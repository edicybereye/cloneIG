import 'package:training_ig/model/postDetailModel.dart';

class PostModel {
  final String id;
  final String createdDate;
  final String idUsers;
  final String description;
  final int love;
  final String username;
  final String name;
  final String photo;
  final List<PostDetailModel> data;

  PostModel(
      {this.id,
      this.createdDate,
      this.idUsers,
      this.description,
      this.love,
      this.username,
      this.name,
      this.photo,
      this.data});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<PostDetailModel> dataList =
        list.map((i) => PostDetailModel.fromJson(i)).toList();
    return PostModel(
      id: json['id'],
      createdDate: json['createdDate'],
      idUsers: json['idUsers'],
      description: json['description'],
      love: json['love'],
      username: json['username'],
      name: json['name'],
      photo: json['photo'],
      data: dataList,
    );
  }
}
