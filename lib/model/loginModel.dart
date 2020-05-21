class LoginModel {
  final int value;
  final String message;
  final String id;
  final String username;
  final String email;
  final String name;
  final String createdDate;
  final String photo;

  LoginModel({
    this.value,
    this.message,
    this.id,
    this.username,
    this.email,
    this.createdDate,
    this.name,
    this.photo,
  });

  factory LoginModel.api(Map<String, dynamic> json) {
    return LoginModel(
      value: json['value'],
      message: json['message'],
      id: json['id'],
      username: json['username'],
      email: json['email'],
      name: json['name'],
      createdDate: json['createdDate'],
      photo: json['photo'],
    );
  }
}
