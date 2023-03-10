class SocialModel {
  bool? success;
  String? message;
  String? token;
  User? user;

  SocialModel({this.success, this.message, this.token, this.user});

  SocialModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? userName;
  String? email;
  String? socialId;
  String? loginMedium;
  Null? image;
  String? phone;
  String? updatedAt;
  String? createdAt;
  int? id;

  User(
      {this.userName,
      this.email,
      this.socialId,
      this.loginMedium,
      this.image,
      this.phone,
      this.updatedAt,
      this.createdAt,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    email = json['email'];
    socialId = json['social_id'];
    loginMedium = json['login_medium'];
    image = json['image'];
    phone = json['phone'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['social_id'] = this.socialId;
    data['login_medium'] = this.loginMedium;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
