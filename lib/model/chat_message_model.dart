class ChatMessageModel {
  final int messageId;
  final String? name;
  final String content;
  final int recipient;
  final int sender;

  ChatMessageModel({
    required this.messageId,
    this.name,
    required this.content,
    required this.recipient,
    required this.sender,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      messageId: json['messageId'],
      name: json['name'],
      content: json['content'],
      recipient: json['recipient'],
      sender: json['sender'],
    );
  }
}
