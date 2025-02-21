
class ChatModel{
  int? cId;
  String? name;
  String? images;

  ChatModel({
    this.cId,
    this.name,
    this.images
});

  ChatModel.fromJson(Map<String,dynamic> json){
    cId = json['cId'];
    name = json['name'];
    images =json['images'];
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data=new Map<String,dynamic>();
    data['cId'] = this.cId;
    data['name'] = this.name;
    data['images'] = this.images;
    return data;
  }

}