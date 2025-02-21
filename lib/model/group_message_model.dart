class GroupMessageModel {
  final int id;
  final int groupId;
  final String? content;
  final int senderId;
  final String senderName;
  final DateTime? timestamp;

  GroupMessageModel({
    required this.id,
    required this.groupId,
    this.content,
    required this.senderId,
    required this.senderName,
    this.timestamp,
  });

  factory GroupMessageModel.fromJson(Map<String, dynamic> json) {
    return GroupMessageModel(
      id: json['id'],
      groupId: json['groupId'],
      content: json['content'],
      senderId: json['senderId'],
      senderName: json['senderName'],
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
    );
  }
}