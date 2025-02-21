


class LeadLinkModel {
  String? createdDate;
  String? createdBy;
  String? label;
  String? description;
  String? file;

  LeadLinkModel({
    this.createdDate,
    this.createdBy,
    this.label,
    this.description,
    this.file
  });

  LeadLinkModel.fromJson(Map<String,dynamic> json){
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    label = json['label'];
    description = json['noteDescription'];
    file=json['fileSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic>data = new Map<String,dynamic>();
    data['createdDate']=this.createdDate;
    data['createdBy']=this.createdBy;
    data['label']=this.label;
    data['noteDescription']=this.description;
    data['fileSize']=this.file;
    return data;
  }
}