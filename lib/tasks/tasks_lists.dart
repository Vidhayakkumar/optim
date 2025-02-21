import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';
import 'package:myfirstproject/auth/task/get_task.dart';
import 'package:myfirstproject/config/colors.dart';
import 'package:myfirstproject/model/task_model.dart';
import 'package:myfirstproject/tasks/add_tasks.dart';
import 'package:myfirstproject/tasks/update_task.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            gradient: const LinearGradient(colors: [blueBgColor, blueBgColor1]),
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
              gradient: LinearGradient(colors: [blueBgColor, blueBgColor])),
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search contact name',
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.0)),
                  ),
                ),
                const SizedBox(height: 10),
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
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                                          const SizedBox(width: 10),
                                          const Text(
                                            "Task Owner Name",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Container(
                                              width: 110,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: changeBgColor(status!),
                                                border: Border.all(
                                                    color: changeBorderColor(status)),
                                                borderRadius: BorderRadius.circular(5.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(6.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    changeImage(status),
                                                    const SizedBox(width: 3),
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
                                            width: 120,
                                            child: Text('${apiList[index].customerName}',
                                              style: const TextStyle(
                                                  color: textColor, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Text(apiList[index].taskOwner ?? "N/A",
                                            style: const TextStyle(
                                                color: textColor, fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
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
                                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                                height: 33,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.blue,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.calendar_today_outlined,
                                                      color: Colors.blue,
                                                      size: 16,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      '${apiList[index].duedate}',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.blue,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                top: -10,
                                                left: 12,
                                                child: Container(
                                                  color: Colors.white,
                                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                                  child: Text(
                                                    "Due Date",
                                                    style: TextStyle(
                                                      fontSize: 12,
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
          backgroundColor: floatButtonColor,
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
