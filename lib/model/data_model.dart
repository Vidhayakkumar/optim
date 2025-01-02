
import 'dart:convert';

DataModel dataModelFromJson(String str)=>DataModel.fromJson(json.decode(str));
String dataModelToJson(DataModel data)=> json.encode(data.toJson());

class DataModel {
  int? productId;
  String? productName;
  int? quantity;
  double? unitPrice;
  int? employeeId;
  String? productCode;
  String? productDescription;
  String? hsn;

  DataModel({
    this.productId,
    this.productName,
    this.quantity,
    this.unitPrice,
    this.employeeId,
    this.productCode,
    this.productDescription,
    this.hsn,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      productId: json['productId'] as int?,
      productName: json['productName'] as String?,
      quantity: json['quantity'] as int?,
      unitPrice: (json['unitPrice'] as num?)?.toDouble(),
      employeeId: json['employeeId'] as int?,
      productCode: json['productCode'] as String?,
      productDescription: json['productDescription'] as String?,
      hsn: json['hsn'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'employeeId': employeeId,
      'productCode': productCode,
      'productDescription': productDescription,
      'hsn': hsn,
    };
  }


}