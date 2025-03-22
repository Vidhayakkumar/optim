import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfirstproject/auth/chat/get_employee_list.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';
import 'package:myfirstproject/config/colors.dart';
import 'package:myfirstproject/config/dimensions.dart';
import 'package:myfirstproject/model/chat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../profile/profile_screen.dart';
import 'chat_section.dart';
import 'groups_name.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<StatefulWidget> createState() => ChatHomeState();
}

class ChatHomeState extends State<ChatHome> {
  late Future<List<ChatModel>> futureApiList;
  int receiverId = 0; // Initialize with a default value

  final ApiChat _apiChat = ApiChat(DioClient());
  final TextEditingController searchController = TextEditingController();
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
      try {
        var result = await _apiChat.getChatEmployeeList(jwtToken!);
        return result.map((json) => ChatModel.fromJson(json)).toList();
      } catch (e) {
        print('Error fetching chat list: $e');
        return []; // Return an empty list on error
      }
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
        preferredSize: Size.fromHeight(Dimensions.height45),
        child: GradientAppBar(
          gradient: const LinearGradient(
              colors: [AppColors.blueBgColor, AppColors.mainColor]),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context); // Add functionality if needed
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("Chat"),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: Dimensions.width20),
              child: SizedBox(
                height: Dimensions.height30,
                width: Dimensions.width30,
                child: SvgPicture.asset(
                  'assets/images/add-circle.svg',
                  width: Dimensions.width20,
                  height: Dimensions.width20,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.blueBgColor, AppColors.mainColor]),
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
        margin: EdgeInsets.all(Dimensions.width10),
        child: Column(
          children: [
            // Search bar
            Container(
              height: Dimensions.height50,
              color: const Color(0xffEBEBEB),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    borderSide: const BorderSide(color: Color(0xffA6A6A6)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    borderSide: const BorderSide(color: Color(0xffA6A6A6)),
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.radius10),

            // Tab buttons (All, Groups)
            Row(
              children: [
                GestureDetector(
                  onTap: () => onTabSelected("All"),
                  child: Container(
                    width: Dimensions.width45,
                    height: Dimensions.height30,
                    decoration: BoxDecoration(
                      color: selectedTab == "All"
                          ? const Color(0xffECF1FF)
                          : const Color(0xffEBEBEB),
                      borderRadius: BorderRadius.circular(Dimensions.radius10 + Dimensions.width2),
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
                SizedBox(width: Dimensions.width20),
                GestureDetector(
                  onTap: () => onTabSelected("Groups"),
                  child: Container(
                    width: Dimensions.width80 - Dimensions.width10,
                    height: Dimensions.height30,
                    decoration: BoxDecoration(
                      color: selectedTab == "Groups"
                          ? const Color(0xffECF1FF)
                          : const Color(0xffEBEBEB),
                      borderRadius: BorderRadius.circular(Dimensions.radius10),
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
            SizedBox(height: Dimensions.height10),
            // Chat list display
            customChatView(),
          ],
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
                  // Decode base64 image string
                  Uint8List bytes = Uint8List(0); // Default empty image
                  if (apiList[index].images != null && apiList[index].images!.isNotEmpty) {
                    try {
                      bytes = base64Decode(apiList[index].images!.replaceAll(RegExp(r'\s+'), ''));
                    } catch (e) {
                      print('Error decoding image: $e');
                    }
                  }

                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          receiverId = apiList[index].cId ?? 0; // Default value if null
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatSection(
                                  receiverId: receiverId, image: bytes),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: Dimensions.height50,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: Dimensions.radius20,
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
                                    height: Dimensions.height20),
                                SizedBox(width: Dimensions.width10),
                                SvgPicture.asset('assets/images/Date_range.svg',
                                    height: Dimensions.height20),
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