class UserData {
  String? userId;
  String? email;
  String? mobileNumber;
  String? dialCode;
  String? cashBonus;
  String? balance;
  String? deposit;
  String? winingAmount;
  String? referral;
  String? name;
  String? dob;
  String? gender;
  String? favouriteTeams;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pinCode;
  String? panCardNumber;
  String? bankName;
  String? bankAccountNumber;
  String? bankAccountName;
  String? bankIfsc;
  String? isVerify;
  String? createdTime;
  String? updatedTime;
  String? isDelete;
  String? image;
  String? referralCode;
  String? totalLeague;
  String? totalMatches;
  String? totalSeries;
  String? totalWins;

  UserData({
    this.userId = '',
    this.email = '',
    this.mobileNumber = '123456789',
    this.dialCode = '',
    this.cashBonus = '0.0',
    this.balance = '0',
    this.winingAmount = '0',
    this.referral = '',
    this.name = '',
    this.dob = '',
    this.gender = '',
    this.favouriteTeams = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.country = 'India',
    this.pinCode = '',
    this.panCardNumber = '',
    this.bankName = '',
    this.bankAccountNumber = '',
    this.bankAccountName = '',
    this.bankIfsc = '',
    this.isVerify = '',
    this.createdTime = '',
    this.updatedTime = '',
    this.isDelete = '',
    this.image = '',
    this.referralCode = '',
    this.totalLeague = '0',
    this.totalMatches = '0',
    this.deposit = '0',
    this.totalSeries = '0',
    this.totalWins = '0',
  });

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'] ?? '';
    email = json['email'] ?? '';
    dialCode = json['dial_code'] ?? '+91';
    mobileNumber = json['mobile_number'] ?? ' 123456789';
    cashBonus = json['cash_bonus'] ?? '';
    balance = json['balance'] ?? '0';
    winingAmount = json['wining_amount'] ?? '';
    referral = json['referral'] ?? '';
    name = json['name'] ?? '';
    dob = json['dob'] ?? '';
    gender = json['gender'] ?? '';
    favouriteTeams = json['favourite_teams'] ?? '';
    address = json['address'] ?? '';
    city = json['city'] ?? '';
    state = json['state'] ?? '';
    country = json['country'] ?? 'India';
    pinCode = json['pincode'] ?? '';
    panCardNumber = json['pancard_number'] ?? '';
    bankName = json['bank_name'] ?? '';
    bankAccountNumber = json['bank_account_number'] ?? '';
    bankAccountName = json['bank_account_name'] ?? '';
    bankIfsc = json['bank_ifsc'] ?? '';
    isVerify = json['is_veryfy'] ?? '';
    createdTime = json['created_time'] ?? '';
    updatedTime = json['updated_time'] ?? '';
    isDelete = json['is_delete'] ?? '';
    image = json['image'] ?? '';
    referralCode = json['referral_code'] ?? '';
    totalLeague = json['total_league'] ?? '';
    totalMatches = json['total_matches'] ?? '';
    deposit = json['deposit'] ?? '';
    totalSeries = json['total_series']?? '';
    totalWins = json['total_wins']?? '';
  }
  UserData.fromServerJson(Map<String, dynamic> json) {
    userId = "${json['id']?? '0'}";
    email = json['email'] ?? '';
    mobileNumber = json['phone'] ?? ' 123456789';
    dialCode = json['dial_code'] ?? '+91';
    cashBonus = json['cash_bonus'] ?? '0.0';
    balance = json['balance'] ?? '0';
    winingAmount = json['wining_amount'] ?? '0';
    referral = json['refer_code'] ?? '';
    name = json['user_name'] ?? '';
    dob = json['date_of_birth'] ?? '';
    gender = json['gender'] ?? '';
    favouriteTeams = json['favourite_teams'] ?? '';
    address = json['address'] ?? '';
    city = json['city'] ?? '';
    state = json['state'] ?? '';
    country = json['country'] ?? 'India';
    pinCode = json['pincode'] ?? '';
    panCardNumber = json['pancard_number'] ?? '';
    bankName = json['bank_name'] ?? '';
    bankAccountNumber = json['bank_account_number'] ?? '';
    bankAccountName = json['bank_account_name'] ?? '';
    bankIfsc = json['bank_ifsc'] ?? '';
    isVerify = json['is_verify'] ?? '';
    createdTime = json['created_time'] ?? '';
    updatedTime = json['updated_time'] ?? '';
    isDelete = json['is_delete'] ?? '';
    image = json['image'] ?? '';
    referralCode = json['referral_code'] ?? '';
    totalLeague = json['total_league'] ?? '0';
    totalMatches = json['total_matches'] ?? '0';
    deposit = json['deposit'] ?? '0';
    totalSeries = json['total_series']?? '0';
    totalWins = json['total_wins']?? '0';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['dial_code'] = this.dialCode;
    data['mobile_number'] = this.mobileNumber;
    data['cash_bonus'] = this.cashBonus;
    data['balance'] = this.balance;
    data['wining_amount'] = this.winingAmount;
    data['referral'] = this.referral;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['favourite_teams'] = this.favouriteTeams;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pinCode;
    data['pancard_number'] = this.panCardNumber;
    data['bank_name'] = this.bankName;
    data['bank_account_number'] = this.bankAccountNumber;
    data['bank_account_name'] = this.bankAccountName;
    data['bank_ifsc'] = this.bankIfsc;
    data['is_veryfy'] = this.isVerify;
    data['created_time'] = this.createdTime;
    data['updated_time'] = this.updatedTime;
    data['is_delete'] = this.isDelete;
    data['image'] = this.image;
    data['referral_code'] = this.referralCode;
    data['total_league'] = this.totalLeague;
    data['total_matches'] = this.totalMatches;
    data['deposit'] = this.deposit;
    data['total_series'] = this.totalSeries;
    data['total_weries'] = this.totalWins;
    return data;
  }
}
