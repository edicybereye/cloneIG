class NetworkURL {
  static String server = "http://192.168.65.2/ig";

  static String registrasi() {
    return "$server/api/registrasi.php";
  }

  static String login() {
    return "$server/api/login.php";
  }

  static String upload() {
    return "$server/api/tmpPosting.php";
  }

  static String deletePost() {
    return "$server/api/deletePost.php";
  }

  static String submitPosting() {
    return "$server/api/submitPosting.php";
  }

  static String getTmpUpload(String idUsers) {
    return "$server/api/getTmpPosting.php?idUsers=$idUsers";
  }

  static String getPostingUsers(String idUsers) {
    return "$server/api/getPostingUsers.php?idUsers=$idUsers";
  }
}
