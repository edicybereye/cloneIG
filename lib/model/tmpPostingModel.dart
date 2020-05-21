class TmpPostingModel {
  final String idUsers;
  final String file;

  TmpPostingModel({this.idUsers, this.file});

  factory TmpPostingModel.fromJson(Map<String, dynamic> json) {
    return TmpPostingModel(
      idUsers: json['idUsers'],
      file: json['file'],
    );
  }
}
