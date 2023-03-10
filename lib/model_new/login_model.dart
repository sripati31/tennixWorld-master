// class LoginModel {
//   bool? success;
//   String? message;
//   Newtoken? newtoken;
//   Data? data;

//   LoginModel({this.success, this.message, this.newtoken, this.data});

//   LoginModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     newtoken = json['Newtoken'] != null
//         ? new Newtoken.fromJson(json['Newtoken'])
//         : null;
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['message'] = this.message;
//     if (this.newtoken != null) {
//       data['Newtoken'] = this.newtoken!.toJson();
//     }
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Newtoken {
//   String? accessToken;
//   Token? token;

//   Newtoken({this.accessToken, this.token});

//   Newtoken.fromJson(Map<String, dynamic> json) {
//     accessToken = json['accessToken'];
//     token = json['token'] != null ? new Token.fromJson(json['token']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['accessToken'] = this.accessToken;
//     if (this.token != null) {
//       data['token'] = this.token!.toJson();
//     }
//     return data;
//   }
// }

// class Token {
//   String? id;
//   int? userId;
//   int? clientId;
//   String? name;
//   List<String>? scopes;
//   bool? revoked;
//   String? createdAt;
//   String? updatedAt;
//   String? expiresAt;

//   Token(
//       {this.id,
//       this.userId,
//       this.clientId,
//       this.name,
//       this.scopes,
//       this.revoked,
//       this.createdAt,
//       this.updatedAt,
//       this.expiresAt});

//   Token.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     clientId = json['client_id'];
//     name = json['name'];
//     if (json['scopes'] != null) {
//       scopes = <String>[];
//       json['scopes'].forEach((v) {
//         scopes!.add(new String.fromJson(v));
//       });
//     }
//     revoked = json['revoked'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     expiresAt = json['expires_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['client_id'] = this.clientId;
//     data['name'] = this.name;
//     if (this.scopes != null) {
//       data['scopes'] = this.scopes!.map((v) => v.toJson()).toList();
//     }
//     data['revoked'] = this.revoked;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['expires_at'] = this.expiresAt;
//     return data;
//   }
// }

// class Data {
//   int? id;
//   String? userName;
//   String? email;
//   Null? dob;
//   String? phone;
//   Null? gender;
//   Null? address;
//   String? userWalletCurrentAmount;
//   Null? creditPoint;
//   Null? bonusPoint;
//   Null? district;
//   String? dialCode;
//   Null? state;
//   Null? pincode;
//   String? referCode;
//   Null? country;
//   Null? provider;
//   Null? image;
//   Null? providerId;
//   Null? verificationId;
//   int? status;
//   Null? roleId;
//   Null? adminType;
//   Null? passwordToken;
//   int? isPhoneVerified;
//   Null? lastLogin;
//   Null? socialId;
//   Null? loginMedium;
//   String? createdAt;
//   String? updatedAt;

//   Data(
//       {this.id,
//       this.userName,
//       this.email,
//       this.dob,
//       this.phone,
//       this.gender,
//       this.address,
//       this.userWalletCurrentAmount,
//       this.creditPoint,
//       this.bonusPoint,
//       this.district,
//       this.dialCode,
//       this.state,
//       this.pincode,
//       this.referCode,
//       this.country,
//       this.provider,
//       this.image,
//       this.providerId,
//       this.verificationId,
//       this.status,
//       this.roleId,
//       this.adminType,
//       this.passwordToken,
//       this.isPhoneVerified,
//       this.lastLogin,
//       this.socialId,
//       this.loginMedium,
//       this.createdAt,
//       this.updatedAt});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userName = json['user_name'];
//     email = json['email'];
//     dob = json['dob'];
//     phone = json['phone'];
//     gender = json['gender'];
//     address = json['address'];
//     userWalletCurrentAmount = json['user_wallet_current_amount'];
//     creditPoint = json['credit_point'];
//     bonusPoint = json['bonus_point'];
//     district = json['district'];
//     dialCode = json['dial_code'];
//     state = json['state'];
//     pincode = json['pincode'];
//     referCode = json['refer_code'];
//     country = json['country'];
//     provider = json['provider'];
//     image = json['image'];
//     providerId = json['provider_id'];
//     verificationId = json['verification_id'];
//     status = json['status'];
//     roleId = json['role_id'];
//     adminType = json['admin_type'];
//     passwordToken = json['password_token'];
//     isPhoneVerified = json['is_phone_verified'];
//     lastLogin = json['last_login'];
//     socialId = json['social_id'];
//     loginMedium = json['login_medium'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_name'] = this.userName;
//     data['email'] = this.email;
//     data['dob'] = this.dob;
//     data['phone'] = this.phone;
//     data['gender'] = this.gender;
//     data['address'] = this.address;
//     data['user_wallet_current_amount'] = this.userWalletCurrentAmount;
//     data['credit_point'] = this.creditPoint;
//     data['bonus_point'] = this.bonusPoint;
//     data['district'] = this.district;
//     data['dial_code'] = this.dialCode;
//     data['state'] = this.state;
//     data['pincode'] = this.pincode;
//     data['refer_code'] = this.referCode;
//     data['country'] = this.country;
//     data['provider'] = this.provider;
//     data['image'] = this.image;
//     data['provider_id'] = this.providerId;
//     data['verification_id'] = this.verificationId;
//     data['status'] = this.status;
//     data['role_id'] = this.roleId;
//     data['admin_type'] = this.adminType;
//     data['password_token'] = this.passwordToken;
//     data['is_phone_verified'] = this.isPhoneVerified;
//     data['last_login'] = this.lastLogin;
//     data['social_id'] = this.socialId;
//     data['login_medium'] = this.loginMedium;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
