import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfirstproject/auth/chat/api_add_update_work.dart';
import 'package:myfirstproject/auth/chat/get_employee_list.dart';
import 'package:myfirstproject/chat/chat_home.dart';
import 'package:myfirstproject/chat/groups_chat_section.dart';
import 'package:myfirstproject/config/colors.dart';
import 'package:myfirstproject/model/chat_model.dart';
import 'package:myfirstproject/model/group_model.dart';
import 'package:myfirstproject/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/api_service/dio_client.dart';

class GroupsName extends StatefulWidget{
  const GroupsName({super.key});

  @override
  State<StatefulWidget> createState()=>GroupsNameState();

}

class GroupsNameState extends State<GroupsName>{

  TextEditingController searchController=TextEditingController();
  var _currentIndex=0;

  final ApiChat _apiChat = ApiChat(DioClient());

  String? jwtToken;
  late Future<List<GroupModel>> futureApiList;

  String selectedTab="Groups";

  void onTabSelected(String tab){
    if(tab == "All"){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (_)=>const ChatHome()));
    }else if(tab == "Groups"){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (_)=> const GroupsName()));
    }
    setState(() {
      selectedTab=tab;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserData().then((_){
      setState(() {
        refreshGroupList();
      });
    });

  }

  void refreshGroupList() {
    setState(() {

      if(jwtToken != null){
        futureApiList = _apiChat.getGroupNameList(jwtToken!); // Re-fetch the group list
      }

    });
  }


  Future<void> _loadUserData()async{
    try{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      jwtToken=prefs.getString('jwtToken');
    }catch(e){
      throw Exception('Error Occurred $e');
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(45),
                child: GradientAppBar(
                  gradient: const LinearGradient(colors: [blueBgColor,blueBgColor1]),
                  leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back)),
                  title: const Text("Chat"),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SizedBox(
                          height: 80,
                          width: 30,
                          child: GestureDetector(
                              onTap: (){
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return MyDialog(
                                        refreshGroupListCallback: refreshGroupList,
                                      );
                                    }) ;
                              },
                              child: SvgPicture.asset('assets/images/persons.svg',width: 20,height: 80,))),
                    )
                  ],
                )
            ),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [blueBgColor,blueBgColor1])
              ),
              child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  unselectedItemColor: Colors.white38,
                  selectedItemColor: Colors.white,
                  currentIndex: _currentIndex,
                  type: BottomNavigationBarType.fixed,
                  onTap:(index){
                    setState(() {
                      _currentIndex=index;
                    });
                    if(index == 3) {
                      Navigator.push(context, MaterialPageRoute(builder: ((_) => const ProfileScreen())));
                    }
                    setState(() {
                      _currentIndex =0;
                    });
                  } ,
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
                    BottomNavigationBarItem(icon: Icon(Icons.notifications_active), label: 'Notification'),
                    BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Reminder'),
                    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
                  ]
              ),
            ),
            body:Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      color: const Color(0xffEBEBEB),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: const Icon(Icons.search),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(
                                  color:Color(0xffA6A6A6)
                              )
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                  color: Color(0xffA6A6A6)
                              )
                          ),
                        ),
                      ),
                    ),


                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            onTabSelected("All");
                          },
                          child: Container(
                            width: 40,
                            height: 30,
                            decoration: BoxDecoration(
                                color: selectedTab == "All" ?const Color(0xffECF1FF):const Color(0xffEBEBEB),
                                borderRadius: BorderRadius.circular(12.0)
                            ),child: Center(
                            child: Text('All',style: TextStyle(
                                color: selectedTab == "All"?const Color(0xff2354C5):const Color(0xff8D8D8D)
                            ),),),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        GestureDetector(
                          onTap: (){
                            onTabSelected("Groups");
                          },
                          child: Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                                color: selectedTab == "Groups" ?const Color(0xffECF1FF):const Color(0xffEBEBEB),
                                borderRadius: BorderRadius.circular(12.0)
                            ),child: Center(
                            child: Text('Groups',style: TextStyle(
                                color: selectedTab == "Groups"?const Color(0xff2354C5):const Color(0xff8D8D8D)
                            ),),),
                          ),
                        ),
                      ],
                    ),
                    customGroupsView()
                  ],
                ),
              ),
            )
        )
    );


  }

  Widget customGroupsView(){
    return Expanded(
      child: RefreshIndicator(
        onRefresh: ()async{
          futureApiList = _apiChat.getGroupNameList(jwtToken!);
        },
        child: FutureBuilder(
            future: _apiChat.getGroupNameList(jwtToken!),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              }else if(snapshot.hasError){
                return Center(child: Text('Error Occurred ${snapshot.hasError}'),);
              }else if(snapshot.hasData){
                final user = snapshot.data!;
                return  ListView.builder(
                    itemCount: user.length,
                    itemBuilder:(BuildContext context,int index){
                      final groupName = user[index].groupName;
                      final String memberList = user[index].memberList;
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              final groupId= user[index].groupId;
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_)=> GroupChatSection(groupId: groupId, groupName: groupName, memberList: memberList)));
                            },
                            child: SizedBox(
                              height:50,
                              child: ListTile(
                                  leading: CircleAvatar(child: Image.asset('assets/images/man.png'),),
                                  title:  Text(user[index].groupName,style: const TextStyle(color: Color(0xff000001)),),
                                  subtitle: const Text('Umme abiha: Good morning',style: TextStyle(color: Color(0xff2354C5)),),
                                  trailing: const Text('Yesterday',style: TextStyle(color: Color(0xff8D8D8D)),)
                              ),
                            ),
                          ),
                          const Divider(color: Color(0xffC0C0C0),)
                        ],
                      );
                    }
                );
              }else{
                return const Center(child: Text("Data no found"),);
              }

            }),
      ),
    );
  }


  Widget customButton(double cWidth, double cHeight,Color color, String text,Color txtColor){
    return Container(
      width: cWidth,
      height: cHeight,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0)
      ),child: Center(
      child: Text(text,style: TextStyle(
        color: txtColor,
      ),),
    ),
    );
  }

}



/// Dialog box
class MyDialog extends StatefulWidget {

  final Function refreshGroupListCallback;
  const MyDialog({super.key, required this.refreshGroupListCallback});
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

  List<bool> tracker = []; // List to track checkbox states
  final ApiChat _apiChat = ApiChat(DioClient());
  late Future<List<ChatModel>> futureApiList;
  final ApiAddUpdateWork _addUpdateWork = ApiAddUpdateWork(DioClient());
  TextEditingController groupNameController = TextEditingController();

  Set<String> groupMember = {};
  String? jwtToken;

  bool isDialogDisabled = false; // Flag to disable the dialog once the group is created

  @override
  void initState() {
    super.initState();
    _loadJwtToken().then((_) {
      setState(() {
        futureApiList = getData(); // Fetch data on init
      });
    });

  }

  Future<void> _loadJwtToken()async{
    try{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      jwtToken =prefs.getString('jwtToken');
    }catch(e){
      throw Exception('Error occurred $e');
    }

  }

  Future<List<ChatModel>> getData() async {
    if(jwtToken != null){
      final result = await _apiChat.getChatEmployeeList(jwtToken!);
      return result.map((json) => ChatModel.fromJson(json)).toList();
    }else{
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: SizedBox(
        height: 513,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 450,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "New Group",
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: isDialogDisabled
                                  ? null // Disable closing the dialog when it's disabled
                                  : () {
                                Navigator.of(context).pop(); // Close the dialog
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
                          height: 50,
                          child: TextField(
                            controller: groupNameController,
                            decoration: InputDecoration(
                              hintText: 'Enter Group Name',
                              hintStyle: const TextStyle(
                                  color: Color(0xff8D8D8D), fontSize: 13),
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
                        const Text(
                          "Group Members",
                          style: TextStyle(color: Color(0xff000000)),
                        ),
                        SizedBox(
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.search,
                                color: Color(0xff8C8C8C),
                              ),
                              hintText: 'search here',
                              hintStyle: const TextStyle(
                                  color: Color(0xff8D8D8D), fontSize: 13),
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
                        Expanded(
                          child: FutureBuilder(
                            future: futureApiList,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(child: Text('Error Occurred ${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                var userName = snapshot.data!;

                                // Initialize the tracker list with the same length as the user list
                                if (tracker.isEmpty) {
                                  tracker = List.generate(userName.length, (index) => false);
                                }

                                return ListView.builder(
                                  itemCount: userName.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    String base64Image = '${userName[index].images}';
                                    base64Image = base64Image.replaceAll(RegExp(r'\s+'), '');
                                    Uint8List bytes = base64Decode(base64Image);

                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              radius: 18,
                                              backgroundImage: MemoryImage(bytes),
                                            ),
                                            title: Text(
                                              '${userName[index].name}',
                                              style: const TextStyle(color: Colors.black),
                                            ),
                                            trailing: Checkbox(
                                              value: tracker[index], // Use tracker[index] for checkbox state
                                              onChanged: isDialogDisabled ? null : (bool? value) {
                                                setState(() {
                                                  tracker[index] = value ?? false;
                                                  groupMember.add(userName[index].cId.toString());
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
                  height: 65,
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 40,
                          width: 110,
                          decoration: BoxDecoration(
                            color: const Color(0xff1242D2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: isDialogDisabled
                                  ? null // Disable interaction if the dialog is disabled
                                  : () async {
                                setState(() {
                                  isDialogDisabled = true; // Disable the dialog
                                });

                                var groupName = groupNameController.text.trim();
                                if (groupName.isNotEmpty) {
                                  // Call the function to create the group
                                  await _addUpdateWork.makeGroup(jwtToken!, groupName, groupMember);

                                  // Refresh the group list in the parent widget
                                  widget.refreshGroupListCallback();  // Trigger the refresh

                                  // Close the dialog after the group is created
                                  Navigator.of(context).pop();
                                } else {
                                  // Handle empty group name
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Group name cannot be empty",style: TextStyle(color: Colors.white),)),
                                  );
                                }
                              },
                              child: isDialogDisabled
                                  ? const CircularProgressIndicator(color: Colors.white) // Show loading when disabled
                                  : const
                              Text(
                                "Create Group",
                                style: TextStyle(color: Colors.white, fontSize: 15),
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
          ],
        ),
      ),
    );
  }


}