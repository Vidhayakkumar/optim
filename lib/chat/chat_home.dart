import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfirstproject/auth/chat/get_employee_list.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';
import 'package:myfirstproject/chat/chat_section.dart';
import 'package:myfirstproject/chat/groups_name.dart';
import 'package:myfirstproject/config/colors.dart';
import 'package:myfirstproject/model/chat_model.dart';
import 'package:myfirstproject/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<StatefulWidget> createState() => ChatHomeState();
}

class ChatHomeState extends State<ChatHome> {
  late Future<List<ChatModel>> futureApiList;
  late int receiverId;

  final ApiChat _apiChat = ApiChat(DioClient());
  TextEditingController searchController = TextEditingController();
  var _currentIndex = 0;
  String selectedTab = "All";
  String? jwtToken;

  @override
  void initState() {
    super.initState();
    _loadUserData().then((_) {
      setState(() {
        futureApiList = getData(); // API call to fetch chat list
      });
    });
  }

  Future<void> _loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      jwtToken = prefs.getString('jwtToken'); // Fetch JWT token from storage
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<List<ChatModel>> getData() async {
    if (jwtToken != null) {
      var result = await _apiChat.getChatEmployeeList(jwtToken!);
      return result.map((json) => ChatModel.fromJson(json)).toList();
    } else {
      return []; // Return an empty list if JWT token is not available
    }
  }

  void onTabSelected(String tab) {
    setState(() {
      selectedTab = tab;
    });
    if (tab == "Groups") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const GroupsName()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: GradientAppBar(
          gradient: const LinearGradient(colors: [blueBgColor, blueBgColor1]),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context); // Add functionality if needed
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("Chat"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                height: 30,
                width: 30,
                child: SvgPicture.asset(
                  'assets/images/add-circle.svg',
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [blueBgColor, blueBgColor1]),
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
                icon: Icon(Icons.notifications_active), label: 'Notification'),
            BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Reminder'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Search bar
              Container(
                height: 50,
                color: const Color(0xffEBEBEB),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xffA6A6A6)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xffA6A6A6)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Tab buttons (All, Groups)
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      onTabSelected("All");
                    },
                    child: Container(
                      width: 40,
                      height: 30,
                      decoration: BoxDecoration(
                        color: selectedTab == "All"
                            ? const Color(0xffECF1FF)
                            : const Color(0xffEBEBEB),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text(
                          'All',
                          style: TextStyle(
                            color: selectedTab == "All"
                                ? const Color(0xff2354C5)
                                : const Color(0xff8D8D8D),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      onTabSelected("Groups");
                    },
                    child: Container(
                      width: 70,
                      height: 30,
                      decoration: BoxDecoration(
                        color: selectedTab == "Groups"
                            ? const Color(0xffECF1FF)
                            : const Color(0xffEBEBEB),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text(
                          'Groups',
                          style: TextStyle(
                            color: selectedTab == "Groups"
                                ? const Color(0xff2354C5)
                                : const Color(0xff8D8D8D),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Chat list display
              customChatView(),
            ],
          ),
        ),
      ),
    );
  }

  // Display chat list
  Widget customChatView() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            futureApiList = getData();
          });
        },
        child: FutureBuilder(
          future: futureApiList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              var apiList = snapshot.data!;

              return ListView.builder(
                itemCount: apiList.length,
                itemBuilder: (BuildContext context, int index) {
                  // Base64 string ko decode karna
                  String? base64Image = apiList[index].images;

                  // Decode base64 image string
                  Uint8List bytes;
                  if (base64Image != null && base64Image.isNotEmpty) {
                    try {
                      bytes = base64Decode(
                          base64Image.replaceAll(RegExp(r'\s+'), ''));
                    } catch (e) {
                      bytes = Uint8List(
                          0); // Provide a default image or handle the error
                    }
                  } else {
                    bytes = Uint8List(
                        0); // Provide a default image if no image is available
                  }

                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          receiverId = apiList[index].cId ??
                              0; // Provide a default value if cId is null
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatSection(
                                  receiverId: receiverId, image: bytes),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 50,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundImage:
                                  bytes.isNotEmpty ? MemoryImage(bytes) : null,
                              child: bytes.isEmpty
                                  ? const Icon(Icons.person)
                                  : null, // Placeholder if no image
                            ),
                            title: Text(
                              apiList[index].name ?? "Unknown",
                              style: const TextStyle(color: Color(0xff000001)),
                            ),
                            subtitle: const Text(
                              '2 messages, 18 ago',
                              style: TextStyle(color: Color(0xff2354C5)),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset('assets/images/person.svg',
                                    height: 20),
                                const SizedBox(width: 10),
                                SvgPicture.asset('assets/images/Date_range.svg',
                                    height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Divider(color: Color(0xffC0C0C0)),
                    ],
                  );
                },
              );
            } else {
              return const Center(child: Text('No Data Found'));
            }
          },
        ),
      ),
    );
  }
}
