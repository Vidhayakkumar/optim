import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfirstproject/auth/chat/send_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myfirstproject/model/group_message_model.dart';
import '../../auth/api_service/dio_client.dart';
import '../../auth/chat/api_add_update_work.dart';
import '../../auth/chat/get_employee_list.dart';
import '../../config/colors.dart';
import '../../config/dimensions.dart';
import '../../model/chat_model.dart';
import '../../model/group_model.dart';
import '../profile/profile_screen.dart';
import 'group_member_info.dart';
import 'groups_name.dart'; // Ensure this import is correct

class GroupChatSection extends StatefulWidget {
  final int groupId;
  final String groupName;
  final String memberList;

  const GroupChatSection(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.memberList});

  @override
  State<StatefulWidget> createState() => GroupChatSectionState();
}

class GroupChatSectionState extends State<GroupChatSection> {
  final ApiChat _apiChat = ApiChat(DioClient());
  final ApiSendMessage _apiSendMessage = ApiSendMessage(DioClient());
  String? jwtToken;
  String? senderId;
  String? senderName;
  String? senderImage;
  late Future<List<GroupMessageModel>> futureApiList;
  late Future<List<GroupModel>> futureApiGroupList;
  List<GroupMessageModel> messages = [];
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _controller = TextEditingController();
  int _currentIndex = 0;

  final List<String> contents = [
    'Group Info',
    'Mute Notification',
    'Disappear Messages',
    "Exit Group"
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData().then((_) {
      setState(() {
        futureApiList = getData();
        refreshGroupList();
      });
    });

    // Use WidgetsBinding to ensure scrolling occurs after the widget has fully loaded
    Future.delayed(Duration(milliseconds: 300), () {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<List<GroupMessageModel>> getData() async {
    if (jwtToken != null) {
      final results =
          await _apiChat.getGroupMessage(jwtToken!, widget.groupId.toString());
      return results.map((json) => GroupMessageModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> _loadUserData() async {
    Map<String, dynamic> userData = await getUserData();
    setState(() {
      jwtToken = userData['jwtToken'];
      senderId = userData['empID'].toString();
      senderName = userData['name'].toString();
      senderImage = userData['logoImage'].toString();
    });
  }

  void refreshGroupList() {
    setState(() {
      if (jwtToken != null) {
        futureApiGroupList =
            _apiChat.getGroupNameList(jwtToken!); // Re-fetch the group list
      }
    });
  }

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        messages.add(GroupMessageModel(
          id: messages.length + 1,
          groupId: widget.groupId,
          content: _controller.text.trim(),
          senderId: int.parse(senderId!),
          senderName: "Me",
          // Replace with actual sender name
          timestamp: DateTime.now(),
        ));
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        _scrollToBottom();
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          elevation: 2,
          title: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return MyDialog(
                      refreshGroupListCallback: refreshGroupList,
                      groupName: widget.groupName,
                      memberList: widget.memberList,
                      groupId: widget.groupId,
                    );
                  });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("BrightLink",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                Text('Abiha, Umme, Kartik, Kavita, +2',
                    style: TextStyle(
                        color: const Color(0xff2354C5),
                        fontSize: Dimensions.font13)),
              ],
            ),
          ),
          leadingWidth: Dimensions.width45 * 2,
          leading: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const GroupsName()));
                },
                icon: const Icon(Icons.arrow_back, color: Colors.blue),
              ),
              SizedBox(
                  width: Dimensions.width40,
                  child: Image.asset('assets/images/bright.png')),
            ],
          ),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return contents
                    .map((e) => PopupMenuItem<String>(value: e, child: Text(e)))
                    .toList();
              },
              onSelected: (value) {
                switch (value) {
                  case 'Group Info':
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((_) => GroupMemberInfo())));
                    break;
                  case 'Mute Notification':
                    print('Mute Notification');
                    break;
                  case 'Disappear Messages':
                    print("Disappear Messages");
                    break;
                  case 'Exit Group':
                    print("Exit Group");
                    break;
                }
              },
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppColors.blueBgColor, AppColors.mainColor])),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            unselectedItemColor: Colors.white38,
            selectedItemColor: Colors.white,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              if (index == 3) {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((_) => const ProfileScreen())));
              }
              setState(() {
                _currentIndex = 0;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_active),
                  label: 'Notification'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.alarm), label: 'Reminder'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              // Chat messages
              Expanded(
                child: FutureBuilder(
                  future: futureApiList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Error Occurred: ${snapshot.error}'));
                    } else if (snapshot.hasData && snapshot.data != null) {
                      messages = snapshot.data!;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollToBottom();
                      });
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          bool isMe = message.senderId == int.parse(senderId!);

                          Uint8List bytes;
                          if (senderImage != null && senderImage!.isNotEmpty) {
                            try {
                              bytes = base64Decode(
                                  senderImage!.replaceAll(RegExp(r'\s+'), ''));
                            } catch (e) {
                              bytes = Uint8List(0);
                            }
                          } else {
                            bytes = Uint8List(0);
                          }

                          return Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.height5,
                                  horizontal: Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  isMe
                                      ? CircleAvatar(
                                          backgroundImage: MemoryImage(bytes),
                                          radius: Dimensions.radius15,
                                        )
                                      : Image.asset('assets/images/man.png'),
                                  Padding(
                                    padding: isMe
                                        ? EdgeInsets.only(
                                            right: Dimensions.width25)
                                        : EdgeInsets.only(
                                            left: Dimensions.width25),
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(Dimensions.height10),
                                      decoration: BoxDecoration(
                                        color: isMe
                                            ? const Color(0xff2354C5)
                                            : const Color(0xffF5F8FF),
                                        border: Border.all(
                                            color: isMe
                                                ? const Color(0xff2354C5)
                                                : const Color(0xff2354C5)),
                                        borderRadius: isMe
                                            ? BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    Dimensions.radius20),
                                                bottomRight: Radius.circular(
                                                    Dimensions.radius20),
                                                bottomLeft: Radius.circular(
                                                    Dimensions.radius20),
                                              )
                                            : BorderRadius.only(
                                                topRight: Radius.circular(
                                                    Dimensions.radius20),
                                                bottomRight: Radius.circular(
                                                    Dimensions.radius20),
                                                bottomLeft: Radius.circular(
                                                    Dimensions.radius20),
                                              ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            message.content ?? "No content",
                                            style: TextStyle(
                                                fontSize: Dimensions.font15,
                                                color: isMe
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No Data found'));
                    }
                  },
                ),
              ),
              // Input field
              Padding(
                padding: EdgeInsets.all(Dimensions.height10),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        var content = _controller.text.trim();
                        var groupId = widget.groupId;
                        String timeStamp = DateTime.now().toString();
                        if (jwtToken != null) {
                          await _apiSendMessage.sendGroupMessage(
                              jwtToken!,
                              content,
                              senderName!,
                              senderId!,
                              groupId,
                              timeStamp);
                        }

                        _sendMessage();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.height5),
                        child: SvgPicture.asset('assets/images/send.svg'),
                      ),
                    ),
                    hintText: 'Type a message...',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                      borderSide: const BorderSide(color: Color(0xffE0E0E0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                      borderSide: const BorderSide(color: Color(0xffE0E0E0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'jwtToken': prefs.getString('jwtToken'),
      'empID': prefs.getInt('empID')?.toString(),
      'name': prefs.getString('name'),
      'logoImage': prefs.getString('logoImage')
    };
  }
}

//group update dialog box

class MyDialog extends StatefulWidget {
  final int groupId;
  final String groupName;
  final String memberList;
  final Function refreshGroupListCallback;

  const MyDialog({
    super.key,
    required this.refreshGroupListCallback,
    required this.groupName,
    required this.memberList,
    required this.groupId,
  });

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  List<bool> tracker = []; // List to track checkbox states
  final ApiChat _apiChat = ApiChat(DioClient());
  late Future<List<ChatModel>> futureApiList;
  final ApiAddUpdateWork _addUpdateWork = ApiAddUpdateWork(DioClient());
  TextEditingController groupNameController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  Set<String> groupMember =
      {}; // Ensure this is a Set<String> to handle member IDs
  String? jwtToken;

  bool isDialogDisabled =
      false; // Flag to disable the dialog once the group is created

  @override
  void initState() {
    super.initState();
    _loadJwtToken().then((_) {
      setState(() {
        futureApiList = getData(); // Fetch data on init
        groupNameController = TextEditingController(text: widget.groupName);
        groupMember = widget.memberList
            .split(',')
            .toSet(); // Initialize with existing members
      });
    });
  }

  Future<void> _loadJwtToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      jwtToken = prefs.getString('jwtToken');
    } catch (e) {
      throw Exception('Error occurred $e');
    }
  }

  Future<List<ChatModel>> getData() async {
    if (jwtToken != null) {
      final result = await _apiChat.getChatEmployeeList(jwtToken!);
      return result.map((json) => ChatModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius15)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          color: Colors.white,
        ),
        height: Dimensions.height210 * 2.53,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Dimensions.height210 * 2.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius15),
              ),
              child: Padding(
                padding: EdgeInsets.all(Dimensions.height10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Update Group",
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: isDialogDisabled
                              ? null // Disable closing the dialog when it's disabled
                              : () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color(0xffE3E1E1),
                    ),
                    const Text(
                      "Group Name",
                      style: TextStyle(color: Color(0xff000000)),
                    ),
                    SizedBox(
                      height: Dimensions.height50,
                      child: TextField(
                        controller: groupNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter Group Name',
                          hintStyle: TextStyle(
                              color: const Color(0xff8D8D8D),
                              fontSize: Dimensions.font13),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius10),
                            borderSide:
                                const BorderSide(color: Color(0xffA6A6A6)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius10),
                            borderSide:
                                const BorderSide(color: Color(0xffA6A6A6)),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "Group Members",
                      style: TextStyle(color: Color(0xff000000)),
                    ),
                    SizedBox(
                      height: Dimensions.height50,
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(
                              () {}); // Refresh the list based on search query
                        },
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Color(0xff8C8C8C),
                          ),
                          hintText: 'Search here',
                          hintStyle: TextStyle(
                              color: const Color(0xff8D8D8D),
                              fontSize: Dimensions.font13),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius10),
                            borderSide:
                                const BorderSide(color: Color(0xffA6A6A6)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius10),
                            borderSide:
                                const BorderSide(color: Color(0xffA6A6A6)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: futureApiList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child:
                                    Text('Error Occurred ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            var userList = snapshot.data!;

                            // Filter the list based on the search query
                            var filteredList = userList
                                .where((user) => user.name!
                                    .toLowerCase()
                                    .contains(
                                        searchController.text.toLowerCase()))
                                .toList();

                            // Ensure tracker is synchronized with filteredList
                            if (tracker.isEmpty ||
                                tracker.length != userList.length) {
                              tracker = List.generate(
                                  userList.length,
                                  (index) => groupMember.contains(
                                      userList[index].cId.toString()));
                            }

                            return ListView.builder(
                              itemCount: filteredList.length,
                              itemBuilder: (BuildContext context, int index) {
                                String base64Image =
                                    '${filteredList[index].images}';
                                base64Image =
                                    base64Image.replaceAll(RegExp(r'\s+'), '');
                                Uint8List bytes = base64Decode(base64Image);

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: Dimensions.height40,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          radius: Dimensions.radius17,
                                          backgroundImage: MemoryImage(bytes),
                                        ),
                                        title: Text(
                                          '${filteredList[index].name}',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        trailing: Checkbox(
                                          value: tracker[userList
                                              .indexOf(filteredList[index])],
                                          onChanged: isDialogDisabled
                                              ? null
                                              : (bool? value) {
                                                  setState(() {
                                                    tracker[userList.indexOf(
                                                            filteredList[
                                                                index])] =
                                                        value ?? false;
                                                    if (value ?? false) {
                                                      groupMember.add(
                                                          filteredList[index]
                                                              .cId
                                                              .toString());
                                                    } else {
                                                      groupMember.remove(
                                                          filteredList[index]
                                                              .cId
                                                              .toString());
                                                    }
                                                  });
                                                },
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      color: Color(0xffE3E1E1),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return const Center(child: Text('Data Not Found'));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height60 + Dimensions.height5,
              child: Card(
                color: Colors.white,
                elevation: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: Dimensions.height40,
                      width: Dimensions.width50 * 2 + Dimensions.width10,
                      decoration: BoxDecoration(
                        color: const Color(0xff1242D2),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: isDialogDisabled
                              ? null // Disable interaction if the dialog is disabled
                              : () async {
                                  setState(() {
                                    isDialogDisabled =
                                        true; // Disable the dialog while creating the group
                                  });

                                  var groupName = groupNameController.text
                                      .trim(); // Get the trimmed group name
                                  if (groupName.isNotEmpty) {
                                    try {
                                      // Ensure groupMember is not null before joining
                                      String memberListString = groupMember
                                          .where((member) => member != null)
                                          .join(',');

                                      await _addUpdateWork.updateGroupName(
                                        jwtToken!,
                                        groupName, // Pass the group name
                                        memberListString, // Join members as a string
                                        widget.groupId, // Pass the group ID
                                      );

                                      // Refresh the group list after the update
                                      widget.refreshGroupListCallback();

                                      // Close the dialog after updating the group
                                      Navigator.of(context).pop();
                                    } catch (e) {
                                      // Handle any errors that occur during the update
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Failed to update group: $e")),
                                      );
                                    } finally {
                                      setState(() {
                                        isDialogDisabled =
                                            false; // Re-enable the dialog
                                      });
                                    }
                                  } else {
                                    // Handle the case where the group name is empty
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Group name cannot be empty",
                                              style: TextStyle(
                                                  color: Colors.white))),
                                    );
                                    setState(() {
                                      isDialogDisabled =
                                          false; // Re-enable the dialog
                                    });
                                  }
                                },
                          child: isDialogDisabled
                              ? const CircularProgressIndicator(
                                  color: Colors
                                      .white) // Show loading when disabled
                              : Text(
                                  "Update Group",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimensions.font15),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
