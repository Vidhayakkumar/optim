

import 'dart:convert';

// TaskModel dataModelFromJson(String str)=>TaskModel.fromJson(json.decode(str));
// String dataModelToJson(TaskModel data)=> json.encode(data.toJson());


class TaskModel {
  int? id;
  String? taskOwner;
  String? subject;
  String? duedate;
  String? status;
  String? priority;
  String? createdBy;
  String? modifyBy;
  String? customerName;
  String? description;
  String? reminderDate;
  String? createdDate;
  String? modifyDate;
  String? leadOrAccountType;
  int? leadIdOrAccountId;
  int? employeeId;
  String? employeeIds;
  String? assginTo;

  TaskModel(
      {this.id,
        this.taskOwner,
        this.subject,
        this.duedate,
        this.status,
        this.priority,
        this.createdBy,
        this.modifyBy,
        this.customerName,
        this.description,
        this.reminderDate,
        this.createdDate,
        this.modifyDate,
        this.leadOrAccountType,
        this.leadIdOrAccountId,
        this.employeeId,
        this.employeeIds,
        this.assginTo});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskOwner = json['taskOwner'];
    subject = json['subject'];
    duedate = json['duedate'];
    status = json['status'];
    priority = json['priority'];
    createdBy = json['createdBy'];
    modifyBy = json['modifyBy'];
    customerName = json['customerName'];
    description = json['description'];
    reminderDate = json['reminderDate'];
    createdDate = json['createdDate'];
    modifyDate = json['modifyDate'];
    leadOrAccountType = json['leadOrAccountType'];
    leadIdOrAccountId = json['leadIdOrAccountId'];
    employeeId = json['employeeId'];
    employeeIds = json['employeeIds'];
    assginTo = json['assginTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['taskOwner'] = this.taskOwner;
    data['subject'] = this.subject;
    data['duedate'] = this.duedate;
    data['status'] = this.status;
    data['priority'] = this.priority;
    data['createdBy'] = this.createdBy;
    data['modifyBy'] = this.modifyBy;
    data['customerName'] = this.customerName;
    data['description'] = this.description;
    data['reminderDate'] = this.reminderDate;
    data['createdDate'] = this.createdDate;
    data['modifyDate'] = this.modifyDate;
    data['leadOrAccountType'] = this.leadOrAccountType;
    data['leadIdOrAccountId'] = this.leadIdOrAccountId;
    data['employeeId'] = this.employeeId;
    data['employeeIds'] = this.employeeIds;
    data['assginTo'] = this.assginTo;
    return data;
  }
}
