class User {
  String? FirstName;
  String? LastName;
  String? PhoneNumber;
  String? EmailID;
  String? Password;
  String? StateName;
  String? CityName;
  String? ZipName;

  User(
      {this.FirstName,this.Password,this.LastName,this.PhoneNumber,this.EmailID,this.StateName,this.CityName,this.ZipName});

  User.fromJson(Map<String, dynamic> json) {
    FirstName = json['FName'];
    LastName = json['LName'];
    PhoneNumber = json['Phno'];
    EmailID = json['mail'];
    Password = json['Password'];
    StateName = json['state'];
    CityName = json['city'];
    ZipName = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = new Map<String, dynamic>();
    user['FName'] = this.FirstName;
    user['LName'] = this.LastName;
    user['Phno'] = this.PhoneNumber;
    user['mail'] = this.EmailID;
    user['Password'] = this.Password;
    user['state'] = this.StateName;
    user['city'] = this.CityName;
    user['zip'] = this.ZipName;
    return user;
  }
}
