
class DataModel {
  int? productId;
  String? productName;
  int? quantity;
  int? unitPrice;
  int? employeeId;
  String? productCode;
  String? productDescription;
  String? hsn;

  DataModel(
      {this.productId,
        this.productName,
        this.quantity,
        this.unitPrice,
        this.employeeId,
        this.productCode,
        this.productDescription,
        this.hsn});

  DataModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    employeeId = json['employeeId'];
    productCode = json['productCode'];
    productDescription = json['productDescription'];
    hsn = json['hsn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['quantity'] = this.quantity;
    data['unitPrice'] = this.unitPrice;
    data['employeeId'] = this.employeeId;
    data['productCode'] = this.productCode;
    data['productDescription'] = this.productDescription;
    data['hsn'] = this.hsn;
    return data;
  }
}