import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';
import 'package:myfirstproject/auth/task/get_task.dart';
import 'package:myfirstproject/config/colors.dart';
import 'package:myfirstproject/config/dimensions.dart';
import 'package:myfirstproject/home/tasks/update_task.dart';
import 'package:myfirstproject/model/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_tasks.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<StatefulWidget> createState() => TaskListState();
}

class TaskListState extends State<TaskList> {
  final ApiTask _apiTask = ApiTask(DioClient());

  late Future<List<TaskModel>> futureApiList;
  String? jwtToken;
  var _currentIndex = 0;



  @override
  void initState() {
    super.initState();
    _loadJwtToken().then((_){
      setState(() {
        futureApiList = getData();
      });
    });

  }

  Future<void> _loadJwtToken()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    jwtToken = prefs.getString('jwtToken');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: GradientAppBar(
            gradient: const LinearGradient(colors: [AppColors.blueBgColor, AppColors.mainColor]),
            leading: const Icon(Icons.arrow_back),
            title: const Text("Task List"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Image.asset('assets/images/filter.png'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.blueBgColor, AppColors.mainColor])),
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
          child: Padding(
            padding:  EdgeInsets.all(Dimensions.height10),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search contact name',
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius10)),
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                Expanded(
                  child: FutureBuilder<List<TaskModel>>(
                    future: futureApiList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        var apiList = snapshot.data!;
                        return ListView.builder(
                          itemCount: apiList.length,
                          itemBuilder: (BuildContext context, int index) {
                           final product=apiList[index];
                            var status = apiList[index].status;
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>UpdateTask(
                                 product:product.toJson(),onUpdate:getData
                                ))).then((_){
                                  setState(() {
                                    futureApiList=getData();
                                  });
                                });
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(Dimensions.height10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "Customer Name",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: Dimensions.width10),
                                          const Text(
                                            "Task Owner Name",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: Dimensions.width10),
                                          Expanded(
                                            child: Container(
                                              width: Dimensions.width125-Dimensions.width15,
                                              height: Dimensions.height30,
                                              decoration: BoxDecoration(
                                                color: changeBgColor(status!),
                                                border: Border.all(
                                                    color: changeBorderColor(status)),
                                                borderRadius: BorderRadius.circular(Dimensions.radius5),
                                              ),
                                              child: Padding(
                                                padding:  EdgeInsets.all(Dimensions.height5),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    changeImage(status),
                                                    SizedBox(width: Dimensions.width5),
                                                    Expanded(
                                                        child: Text(
                                                          '${apiList[index].status}',
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: Dimensions.width125-Dimensions.width5,
                                            child: Text('${apiList[index].customerName}',
                                              style: const TextStyle(
                                                  color: AppColors.textColor, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Text(apiList[index].taskOwner ?? "N/A",
                                            style: const TextStyle(
                                                color: AppColors.textColor, fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Dimensions.height15),
                                      const Text("Subject"),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: Text('${apiList[index].subject}')),
                                          Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: Dimensions.height10),
                                                height: Dimensions.height30,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.blue,
                                                    width: 1,
                                                  ),
                                                  borderRadius: BorderRadius.circular(Dimensions.radius5),
                                                ),
                                                child: Row(
                                                  children: [
                                                     Icon(
                                                      Icons.calendar_today_outlined,
                                                      color: Colors.blue,
                                                      size: Dimensions.font15,
                                                    ),
                                                    SizedBox(width: Dimensions.width5),
                                                    Text(
                                                      '${apiList[index].duedate}',
                                                      style: TextStyle(
                                                        fontSize: Dimensions.font14,
                                                        color: Colors.blue,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                top: -Dimensions.height10,
                                                left: Dimensions.width10,
                                                child: Container(
                                                  color: Colors.white,
                                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width5),
                                                  child: Text(
                                                    "Due Date",
                                                    style: TextStyle(
                                                      fontSize: Dimensions.font13,
                                                      color: Colors.grey[700],
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text("No Data found"));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.floatButtonColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddTasks(
                  onUpdate: getData,
                  product: null,
                ),
              ),
            ).then((_) {
              setState(() {
                futureApiList = getData();
              });
            });
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<List<TaskModel>> getData() async {
    if(jwtToken != null){
      var result = await _apiTask.getTasks(jwtToken!);
      return result.map((json) => TaskModel.fromJson(json)).toList();
    }else{
      return [];
    }

  }

  Widget changeImage(String status) {
    switch (status) {
      case 'In Process':
        return Image.asset('assets/images/pie.png');
      case 'Deferred':
        return Image.asset('assets/images/deferred.png');
      case 'Complete':
        return Image.asset('assets/images/complete.png');
      case 'Waiting for Input':
        return Image.asset('assets/images/waiting.png');
      case 'Not Started':
        return Image.asset('assets/images/notStart.png');
      default:
        return const Icon(Icons.image);
    }
  }

  Color changeBorderColor(String status) {
    switch (status) {
      case 'In Process':
        return const Color(0xffFFAD4D);
      case 'Complete':
        return const Color(0xffD6E2FC);
      case 'Waiting for Input':
        return const Color(0xff87AB21);
      case 'Not Started':
        return const Color(0xffD19E07);
      case 'Deferred':
        return const Color(0xffF8530C);
      default:
        return const Color(0xffFFAD4D);
    }
  }

  Color changeBgColor(String status) {
    switch (status) {
      case 'In Process':
        return const Color(0xffFFEFDB);
      case 'Complete':
        return const Color(0xffF3F7E9);
      case 'Waiting for Input':
        return const Color(0xffF3F7E9);
      case 'Not Started':
        return const Color(0xffFCDC7B);
      case 'Deferred':
        return const Color(0xffFCE2D6);
      default:
        return const Color(0xffFFAD4D);
    }
  }
}
