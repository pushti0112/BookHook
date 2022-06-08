class Data {
  int? ID;
  String? NAME;
  String? PASSWORD;

  Data({this.ID, this.NAME, this.PASSWORD});

  Data.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    NAME = json['Name'];
    PASSWORD = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.ID;
    data['Name'] = this.NAME;
    data['Password'] = this.PASSWORD;
    return data;
  }
}
