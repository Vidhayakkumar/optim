

class NoteLeadModel {
  String? createdDate;
  String? createdBy;
  String? description;
  String? file;

  NoteLeadModel({
    this.createdDate,
    this.createdBy,
    this.description,
    this.file
});

  NoteLeadModel.fromJson(Map<String,dynamic> json){
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    description = json['noteDescription'];
    file=json['fileSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic>data = new Map<String,dynamic>();
    data['createdDate']=this.createdDate;
    data['createdBy']=this.createdBy;
    data['noteDescription']=this.description;
    data['fileSize']=this.file;
    return data;
  }
}