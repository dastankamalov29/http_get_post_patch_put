class Company {
  int? id;
  String? companyLogo;
  String? companyName;
  String? companyNumber;
  String? companyAdress;

  Company({
    this.id,
    this.companyLogo,
    this.companyName,
    this.companyNumber,
    this.companyAdress,
  });

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyLogo = json['logo'];
    companyName = json['name'];
    companyNumber = json['phone'];
    companyAdress = json['adress'];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    // data['id'] = id;
    data['logo'] = companyLogo;
    data['name'] = companyName;
    data['phone'] = companyNumber;
    data['adress'] = companyAdress;

    return data;
  }
}
