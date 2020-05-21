class PostDetailModel {
  final String id;
  final String tipe;
  final String detail;

  PostDetailModel({this.id, this.tipe, this.detail});

  factory PostDetailModel.fromJson(Map<String, dynamic> json) {
    return PostDetailModel(
      id: json['id'],
      tipe: json['tipe'],
      detail: json['detail'],
    );
  }
}
