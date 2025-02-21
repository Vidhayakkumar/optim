class GroupModel {
  final int groupId;
  final String groupName;
  final String memberList;
  final String groupOwnerName;
  final int groupOwnerId;

  GroupModel({
    required this.groupId,
    required this.groupName,
    required this.memberList,
    required this.groupOwnerName,
    required this.groupOwnerId,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      groupId: json['groupId'],
      groupName: json['groupName'],
      memberList: json['memberList'],
      groupOwnerName: json['groupOwnerName'],
      groupOwnerId: json['groupOwnerId'],
    );
  }
}

class User {
  final int senderId;
  final String senderName;
  final List<GroupModel> groupChats;

  User({
    required this.senderId,
    required this.senderName,
    required this.groupChats,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var groupChatsList = json['groupChats'] as List;
    List<GroupModel> groupChats = groupChatsList
        .map((groupChat) => GroupModel.fromJson(groupChat))
        .toList();

    return User(
      senderId: json['senderId'],
      senderName: json['senderName'],
      groupChats: groupChats,
    );
  }
}
