class SignupModel {
  bool? success;
  String? message;
  String? token;
  Data? data;

  SignupModel({this.success, this.message, this.token, this.data});

  SignupModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userName;
  String? email;
  String? phone;
  String? dialCode;
  int? status;
  String? referCode;
  int? userWalletCurrentAmount;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.userName,
      this.email,
      this.phone,
      this.dialCode,
      this.status,
      this.referCode,
      this.userWalletCurrentAmount,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    email = json['email'];
    phone = json['phone'];
    dialCode = json['dial_code'];
    status = json['status'];
    referCode = json['refer_code'];
    userWalletCurrentAmount = json['user_wallet_current_amount'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['dial_code'] = this.dialCode;
    data['status'] = this.status;
    data['refer_code'] = this.referCode;
    data['user_wallet_current_amount'] = this.userWalletCurrentAmount;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
