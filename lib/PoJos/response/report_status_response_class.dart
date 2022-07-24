class ReportsStatusResponseClass {
  String? sId;
  String? client;
  String? bank;
  String? visitor;
  String? uploader;
  String? location;
  String? status;
  String? reportFile;
  String? noteFile;
  String? checklistFile;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ReportsStatusResponseClass(
      {this.sId,
        this.client,
        this.bank,
        this.visitor,
        this.uploader,
        this.location,
        this.status,
        this.reportFile,
        this.noteFile,
        this.checklistFile,
        this.createdAt,
        this.updatedAt,
        this.iV});

  ReportsStatusResponseClass.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    client = json['client'];
    bank = json['bank'];
    visitor = json['visitor'];
    uploader = json['uploader'];
    location = json['location'];
    status = json['status'];
    reportFile = json['report_file'];
    noteFile = json['note_file'];
    checklistFile = json['checklist_file'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['client'] = this.client;
    data['bank'] = this.bank;
    data['visitor'] = this.visitor;
    data['uploader'] = this.uploader;
    data['location'] = this.location;
    data['status'] = this.status;
    data['report_file'] = this.reportFile;
    data['note_file'] = this.noteFile;
    data['checklist_file'] = this.checklistFile;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
