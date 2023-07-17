class UserModel {
  int? id;
  bool? isActive;
  String? identityNo;
  String? userId;
  String? userName;
  String? firstName;
  String? lastName;
  Null? projectName;
  String? projectCode;
  Null? userRole;
  int? powerLevelSL;
  String? userType;
  Null? mobileNo;
  Null? dateOfBirth;
  Null? dOBDay;
  Null? dOBMonth;
  Null? dOBYear;
  Null? oTP;
  Null? oTPStatus;
  Null? image;
  Null? address;
  Null? password;
  Null? confirmPassword;
  Null? entryDate;
  Null? email;
  Null? nameOfUser;
  Null? title;
  Null? initial;
  bool? remember;
  String? lastLoginDate;
  String? iP;
  String? browserIdentity;

  UserModel(
      {this.id,
      this.isActive,
      this.identityNo,
      this.userId,
      this.userName,
      this.firstName,
      this.lastName,
      this.projectName,
      this.projectCode,
      this.userRole,
      this.powerLevelSL,
      this.userType,
      this.mobileNo,
      this.dateOfBirth,
      this.dOBDay,
      this.dOBMonth,
      this.dOBYear,
      this.oTP,
      this.oTPStatus,
      this.image,
      this.address,
      this.password,
      this.confirmPassword,
      this.entryDate,
      this.email,
      this.nameOfUser,
      this.title,
      this.initial,
      this.remember,
      this.lastLoginDate,
      this.iP,
      this.browserIdentity});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    isActive = json['IsActive'];
    identityNo = json['IdentityNo'];
    userId = json['UserId'];
    userName = json['UserName'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    projectName = json['ProjectName'];
    projectCode = json['ProjectCode'];
    userRole = json['UserRole'];
    powerLevelSL = json['PowerLevelSL'];
    userType = json['UserType'];
    mobileNo = json['MobileNo'];
    dateOfBirth = json['DateOfBirth'];
    dOBDay = json['DOBDay'];
    dOBMonth = json['DOBMonth'];
    dOBYear = json['DOBYear'];
    oTP = json['OTP'];
    oTPStatus = json['OTPStatus'];
    image = json['Image'];
    address = json['Address'];
    password = json['Password'];
    confirmPassword = json['ConfirmPassword'];
    entryDate = json['EntryDate'];
    email = json['Email'];
    nameOfUser = json['NameOfUser'];
    title = json['Title'];
    initial = json['Initial'];
    remember = json['Remember'];
    lastLoginDate = json['LastLoginDate'];
    iP = json['IP'];
    browserIdentity = json['BrowserIdentity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['IsActive'] = isActive;
    data['IdentityNo'] = identityNo;
    data['UserId'] = userId;
    data['UserName'] = userName;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['ProjectName'] = projectName;
    data['ProjectCode'] = projectCode;
    data['UserRole'] = userRole;
    data['PowerLevelSL'] = powerLevelSL;
    data['UserType'] = userType;
    data['MobileNo'] = mobileNo;
    data['DateOfBirth'] = dateOfBirth;
    data['DOBDay'] = dOBDay;
    data['DOBMonth'] = dOBMonth;
    data['DOBYear'] = dOBYear;
    data['OTP'] = oTP;
    data['OTPStatus'] = oTPStatus;
    data['Image'] = image;
    data['Address'] = address;
    data['Password'] = password;
    data['ConfirmPassword'] = confirmPassword;
    data['EntryDate'] = entryDate;
    data['Email'] = email;
    data['NameOfUser'] = nameOfUser;
    data['Title'] = title;
    data['Initial'] = initial;
    data['Remember'] = remember;
    data['LastLoginDate'] = lastLoginDate;
    data['IP'] = iP;
    data['BrowserIdentity'] = browserIdentity;
    return data;
  }
}
