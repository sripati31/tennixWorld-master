class UserModel {
  String? token;
  String? id;
  String? userId;
  // String? userType;
  String? userName;
  String? userEmail;
  String? userPhone;

  UserModel({
    this.token,
    this.id,
    this.userId,
    // this.userType,
    this.userEmail,
    this.userPhone,
    this.userName,
  });

  // UserModel.fromJson(Map<String, dynamic> json) {
  //   token = json['token'];
  //   // userName = json['userName'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['token'] = token;
  //   // data['userName'] = userName;
  //   return data;
  // }
}
