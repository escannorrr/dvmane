class LoginResponseClass {
  String? state;
  String? msg;
  List<Data>? data;
  String? token;

  LoginResponseClass({this.state, this.msg, this.data, this.token});

  LoginResponseClass.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['token'] = this.token;
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? contact;
  String? password;
  String? role;
  Null? location;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.name,
        this.contact,
        this.password,
        this.role,
        this.location,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    contact = json['contact'];
    password = json['password'];
    role = json['role'];
    location = json['location'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['password'] = this.password;
    data['role'] = this.role;
    data['location'] = this.location;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
