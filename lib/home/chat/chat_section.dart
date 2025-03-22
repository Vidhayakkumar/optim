import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myfirstproject/auth/chat/get_employee_list.dart';
import 'package:myfirstproject/auth/chat/send_message.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';
import 'package:myfirstproject/config/colors.dart';
import 'package:myfirstproject/model/chat_message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/dimensions.dart';
import '../profile/profile_screen.dart';
import 'chat_home.dart';

class ChatSection extends StatefulWidget {
  final int receiverId;
  final Uint8List image;
  const ChatSection({super.key, required this.receiverId, required this.image});

  @override
  State<StatefulWidget> createState() => ChatSectionState();
}

class ChatSectionState extends State<ChatSection> {
  final ApiChat _apiChat = ApiChat(DioClient());
  final ApiSendMessage _apiSendMessage = ApiSendMessage(DioClient());
  TextEditingController txtController = TextEditingController();

  String? jwtToken;
  int? empID;
  String? logoImage;
  late Future<List<ChatMessageModel>> futureApiList;
  final ScrollController _scrollController = ScrollController();
  List<ChatMessageModel> messages = [];
  int _currentIndex=0;

  @override
  void initState() {
    super.initState();
    _loadUserData().then((_) {
      setState(() {
        futureApiList = getData();
      });
    });
    Future.delayed(const Duration(milliseconds: 500), (){
      _scrollToBottom();
    });
  }

  Future<void> _loadUserData() async {
    Map<String, dynamic> userData = await getUserData();
    setState(() {
      jwtToken = userData['jwtToken'];
      logoImage = userData['logoImage'];
      empID = userData['empID'];
    });
  }

  Future<List<ChatMessageModel>> getData() async {
    if (jwtToken != null && empID != null) {
      var results = await _apiChat.getMessage(jwtToken!, empID.toString(), widget.receiverId.toString());
      return results.map((json) => ChatMessageModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  void _sendMessage(String sender) {
    if (txtController.text.trim().isNotEmpty) {
      setState(() {
        messages.add(ChatMessageModel(
          messageId: DateTime.now().microsecondsSinceEpoch,
          sender: sender == "Me" ? empID! : widget.receiverId,
          recipient: sender == "Me" ? widget.receiverId : empID!,
          content: txtController.text.trim(),
        ));
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        _scrollToBottom();
      });

      txtController.clear();
    }
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 5,
          shadowColor: Colors.white,
          title: Column(
            children: [
              Text('BrightLink',
                  style: TextStyle(color: Colors.black,
                  fontSize:  Dimensions.font20)),
              Text('Kavita',
                  style: TextStyle(color: const Color(0xff2354C5),
                      fontSize: Dimensions.font13)),
            ],
          ),
          leadingWidth: Dimensions.width45*2,
          leading: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatHome()));
                },
                icon: const Icon(Icons.arrow_back, color: Colors.blue),
              ),
              SizedBox(width: Dimensions.width40, child: Image.asset('assets/images/bright.png')),
            ],
          ),
        ), bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [AppColors.blueBgColor, AppColors.mainColor]),
        ),
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
            if(index == 3){
              Navigator.push(context, MaterialPageRoute(builder: ((_)=>const ProfileScreen())));
            }
            setState(() {
              _currentIndex =0;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_active), label: 'Notification'),
            BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Reminder'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: futureApiList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error Occurred: ${snapshot.error}'));
                    } else if (snapshot.hasData && snapshot.data != null) {
                      messages = snapshot.data!;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollToBottom();
                      });

                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: messages.length,
                       // reverse: true, // NEW: Messages bottom se start honge
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          bool isMe = message.sender == empID;
                          Uint8List bytes = Uint8List(0);
                          if (logoImage != null) {
                            try {
                              String base64Image = logoImage!.replaceAll(RegExp(r'\s+'), '');
                              bytes = base64Decode(base64Image);
                            } catch (e) {
                              print('Error decoding base64 image: $e');
                            }
                          }
                          return Align(
                            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.height5,
                                  horizontal:Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: isMe ?
                                CrossAxisAlignment.end :
                                CrossAxisAlignment.start,
                                children: [
                                  isMe
                                      ? CircleAvatar(backgroundImage: MemoryImage(bytes),
                                      radius: Dimensions.radius17)
                                      : CircleAvatar(backgroundImage: MemoryImage(widget.image),
                                      radius: Dimensions.radius17),
                                  Padding(
                                    padding: isMe ? EdgeInsets.only(right: Dimensions.width25) :
                                    EdgeInsets.only(left: Dimensions.width25),
                                    child: Container(
                                      padding:  EdgeInsets.all(Dimensions.height10-Dimensions.height2),
                                      decoration: BoxDecoration(
                                        color: isMe ? const Color(0xff2354C5) :
                                        const Color(0xffF5F8FF),
                                        border: Border.all(color: const Color(0xff2354C5)),
                                        borderRadius: isMe?
                                        BorderRadius.only(
                                            topLeft: Radius.circular(Dimensions.radius20),
                                          bottomRight: Radius.circular(Dimensions.radius20),
                                          bottomLeft: Radius.circular(Dimensions.radius20)
                                        )
                                        :BorderRadius.only(
                                          topRight: Radius.circular(Dimensions.radius20),
                                          bottomRight: Radius.circular(Dimensions.radius20),
                                          bottomLeft: Radius.circular(Dimensions.radius20)
                                        ),
                                      ),
                                      child: Text(
                                        message.content.toString(),
                                        style: TextStyle(fontSize: Dimensions.font15,
                                            color: isMe ? Colors.white : Colors.black),
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
                      return const Center(child: Text("No Data Found"));
                    }
                  },
                ),
              ),
              Padding(
                padding:EdgeInsets.all(Dimensions.radius10),
                child: TextField(
                  controller: txtController,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        var message = txtController.text.toString();
                        if (jwtToken != null) {
                          await _apiSendMessage.sendMessage(jwtToken!, message, widget.receiverId, empID!);
                          _sendMessage("Me");
                        }
                      },
                      child: Padding(
                        padding:  EdgeInsets.all(Dimensions.height5),
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
      'logoImage': prefs.getString('logoImage'),
      'empID': prefs.getInt('empID'),
    };
  }
}