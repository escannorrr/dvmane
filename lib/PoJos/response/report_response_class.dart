class ReportsResponseClass {
  String? state;
  List<Data>? data;

  ReportsResponseClass({this.state, this.data});

  ReportsResponseClass.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  Client? client;
  Client? bank;
  Client? visitor;
  Client? uploader;
  Client? location;
  String? status;
  String? reportFile;
  String? noteFile;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? checklistFile;

  Data(
      {this.sId,
        this.client,
        this.bank,
        this.visitor,
        this.uploader,
        this.location,
        this.status,
        this.reportFile,
        this.noteFile,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.checklistFile});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    client = json['client'] != null ? new Client.fromJson(json['client']) : Client(sId: "",name: "");
    bank = json['bank'] != null ? new Client.fromJson(json['bank']) : Client(sId: "",name: "");
    visitor =
    json['visitor'] != null ? new Client.fromJson(json['visitor']) : Client(sId: "",name: "");
    uploader =
    json['uploader'] != null ? new Client.fromJson(json['uploader']) : Client(sId: "",name: "");
    location =
    json['location'] != null ? new Client.fromJson(json['location']) : Client(sId: "",name: "");
    status = json['status'];
    reportFile = json['report_file'];
    noteFile = json['note_file'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    checklistFile = json['checklist_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    if (this.bank != null) {
      data['bank'] = this.bank!.toJson();
    }
    if (this.visitor != null) {
      data['visitor'] = this.visitor!.toJson();
    }
    if (this.uploader != null) {
      data['uploader'] = this.uploader!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['status'] = this.status;
    data['report_file'] = this.reportFile;
    data['note_file'] = this.noteFile;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['checklist_file'] = this.checklistFile;
    return data;
  }
}

class Client {
  String? sId;
  String? name;

  Client({this.sId, this.name});

  Client.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}
