class LoginModel {
  final int value;
  final String message;

  LoginModel({this.value, this.message});

  factory LoginModel.api(Map<String, dynamic> json) {
    return LoginModel(
      value: json['value'],
      message: json['message'],
    );
  }
}
