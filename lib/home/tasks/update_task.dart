import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';
import 'package:myfirstproject/auth/task/api_add_task.dart';
import 'package:myfirstproject/auth/task/get_task.dart';
import 'package:myfirstproject/config/colors.dart';
import 'package:myfirstproject/model/lead_link_model.dart';
import 'package:myfirstproject/model/note_lead_model.dart';
import 'package:myfirstproject/widget/custom_elevated_button.dart';
import 'package:myfirstproject/widget/custom_outline_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/dimensions.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({super.key, required this.product, required this.onUpdate});

  final Map<String, dynamic> product;
  final Future<void> Function() onUpdate;

  @override
  State<StatefulWidget> createState() => UpdateTaskState();
}

class UpdateTaskState extends State<UpdateTask> {
  final ApiAddTask _addAddTask = ApiAddTask(DioClient());
  final ApiTask _apiTask = ApiTask(DioClient());

  late Future<List<NoteLeadModel>> futureApiList;
  late Future<List<LeadLinkModel>> futureApiListLink;
  String? jwtToken;

  TextEditingController taskOwnerController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController leadTypeController = TextEditingController();
  TextEditingController descriptionAddNotesController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController linkDescriptionController = TextEditingController();
  TextEditingController linkLabelController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  String? selectedFileName;
  String? selectedStatus;
  String? selectedPriority;
  String? selectedDueDateTime;
  String? selectedReminderTime;
  var id;

  final List<String> statusList = [
    "Select Status",
    "Not Started",
    "Deferred",
    "In Process",
    "Complete",
    "Waiting for Input",
  ];
  final List<String> priorityList = [
    "Select Priority",
    "Highest",
    "Lowest",
    "High",
    "Low",
    "Normal",
  ];

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        selectedFileName = result.files.single.name;
      });
    } else {
      // user cancel the selected
    }
  }

  @override
  void initState() {
    super.initState();

    taskOwnerController =
        TextEditingController(text: widget.product['taskOwner'].toString());
    subjectController =
        TextEditingController(text: widget.product['subject'].toString());
    leadTypeController =
        TextEditingController(text: widget.product['customerName'].toString());
    selectedStatus = widget.product['status'].toString();
    selectedPriority = widget.product['priority'].toString();
    selectedDueDateTime = widget.product['duedate'].toString();
    selectedReminderTime = widget.product['reminderDate'].toString();
    descriptionAddNotesController =
        TextEditingController(text: widget.product['description'].toString());
    id = widget.product['id'];

    _loadJwtToken().then((_) {
      setState(() {
        futureApiList = getNoteData();
        futureApiListLink = getLinkData();
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.height100),
          child: Column(
            children: [
              Container(
                height: Dimensions.height80,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.blueBgColor, AppColors.mainColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: AppBar(
                  title: Text(
                    'Update Task',
                    style: TextStyle(
                        color: Colors.white, fontSize: Dimensions.font18),
                  ),
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                height: Dimensions.height50,
                color: Colors.white, // White background for TabBar
                child: const TabBar(
                  labelColor: Color(0xff3B4EFA),
                  unselectedLabelColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Color(0xff3B4EFA),
                  dividerHeight: 0,
                  indicatorWeight: 3,
                  tabs: [
                    Tab(icon: Icon(Icons.person), text: 'Info'),
                    Tab(icon: Icon(Icons.note_add), text: 'Notes'),
                    Tab(icon: Icon(Icons.link), text: 'Links'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(
            children: [
              infoPage(),
              notesPage(), // Placeholder for Notes Tab
              linksPage() // Placeholder for Links Tab
            ],
          ),
        ),
      ),
    );
  }

  Widget infoPage() {
    return Padding(
      padding: EdgeInsets.all(Dimensions.height10),
      child: Container(
        margin: EdgeInsets.only(
            left: Dimensions.width10,
            top: Dimensions.height10,
            right: Dimensions.width10),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Task Information",
                style: TextStyle(
                    color: const Color(0xff3B4EFA),
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.font15),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              customText(
                'Task Owner',
                'abiha',
                taskOwnerController,
              ),
              const Divider(
                color: Color(0xffE3E1E1),
                thickness: 3,
              ),
              customText(
                'Subject',
                'computer',
                subjectController,
              ),
              const Divider(
                color: Color(0xffE3E1E1),
                thickness: 3,
              ),
              customText(
                'Account',
                'Account4',
                leadTypeController,
              ),
              const Divider(
                color: Color(0xffE3E1E1),
                thickness: 3,
              ),
              SizedBox(
                height: Dimensions.height25,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: Dimensions.width125,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Dimensions.width10,
                              top: Dimensions.height5),
                          child: Text(
                            'Status',
                            style: TextStyle(
                                color: const Color(0xff7B7979),
                                fontSize: Dimensions.font13),
                          ),
                        )),
                    Text(
                      " :  ",
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          color: const Color(0xff000000)),
                    ),
                    SizedBox(
                      width: Dimensions.width200,
                      child: Padding(
                        padding: EdgeInsets.only(top: Dimensions.height5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: Dimensions.width10),
                                  child: DropdownButton<String>(
                                    value: selectedStatus,
                                    hint: const Text("Select "),
                                    isExpanded: true,
                                    items: statusList
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              fontSize: Dimensions.font13),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedStatus = newValue;
                                      });
                                    },
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
              const Divider(
                color: Color(0xffE3E1E1),
                thickness: 3,
              ),
              SizedBox(
                height: Dimensions.height25,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: Dimensions.width125 + Dimensions.width2,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Dimensions.width10,
                              top: Dimensions.height5),
                          child: Text(
                            'Priority',
                            style: TextStyle(
                                color: const Color(0xff7B7979),
                                fontSize: Dimensions.font13),
                          ),
                        )),
                    Text(
                      " :  ",
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          color: const Color(0xff000000)),
                    ),
                    SizedBox(
                      width: Dimensions.width200,
                      child: Padding(
                        padding: EdgeInsets.only(top: Dimensions.height5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: Dimensions.width10),
                                  child: DropdownButton<String>(
                                    value: selectedPriority,
                                    hint: const Text("Select "),
                                    isExpanded: true,
                                    items: priorityList
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              fontSize: Dimensions.font13),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedPriority = newValue;
                                      });
                                    },
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
              const Divider(
                color: Color(0xffE3E1E1),
                thickness: 3,
              ),
              SizedBox(
                height: Dimensions.height25,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: Dimensions.width125,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Dimensions.width10,
                              top: Dimensions.height5),
                          child: Text(
                            'Due Date',
                            style: TextStyle(
                                color: const Color(0xff7B7979),
                                fontSize: Dimensions.font13),
                          ),
                        )),
                    Text(
                      " :  ",
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          color: const Color(0xff000000)),
                    ),
                    SizedBox(
                      width: Dimensions.width200 + Dimensions.width10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: Dimensions.width5,
                                top: Dimensions.height5),
                            child: Text(
                              selectedDueDateTime ?? 'dd/mm/yy',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.font13),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              String? result = await selectDateTime(context);
                              if (result != null) {
                                setState(() {
                                  selectedDueDateTime = result;
                                });
                              }
                            },
                            icon: Icon(
                              Icons.calendar_today_outlined,
                              size: Dimensions.font18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Color(0xffE3E1E1),
                thickness: 3,
              ),
              SizedBox(
                height: Dimensions.height25,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: Dimensions.width125,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Dimensions.width5, top: Dimensions.height5),
                          child: Text(
                            ' Reminder',
                            style: TextStyle(
                                color: const Color(0xff7B7979),
                                fontSize: Dimensions.font13),
                          ),
                        )),
                    Text(
                      " :  ",
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          color: const Color(0xff000000)),
                    ),
                    SizedBox(
                      width: Dimensions.width200 + Dimensions.width10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: Dimensions.width5,
                                top: Dimensions.height5),
                            child: Text(
                              selectedReminderTime ?? 'dd/mm/yy',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.font13),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              String? result = await selectDateTime(context);
                              if (result != null) {
                                setState(() {
                                  selectedReminderTime = result;
                                });
                              }
                            },
                            icon: Icon(
                              Icons.calendar_today_outlined,
                              size: Dimensions.font18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Color(0xffE3E1E1),
                thickness: 3,
              ),
              Text(
                "Description Information",
                style: TextStyle(
                    color: const Color(0xff3B4EFA),
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.font15),
              ),
              const Divider(
                color: Color(0xff8C7C7C),
                thickness: 1.5,
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.width2),
                child: TextField(
                    controller: descriptionAddNotesController,
                    maxLines: 2,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius10),
                            borderSide:
                                const BorderSide(color: Color(0xffE3E1E1))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xffE3E1E1),
                        )))),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () async {
                        var taskOwner = taskOwnerController.text.toString();
                        var subject = subjectController.text;
                        var status = selectedStatus.toString();
                        var priority = selectedPriority.toString();
                        var dueDate = selectedDueDateTime;
                        var reminderDate = selectedReminderTime;
                        var description =
                            descriptionAddNotesController.text.toString();
                        var leadOrAccountType =
                            widget.product['leadOrAccountType'].toString();
                        var leadOrAccountId =
                            widget.product['leadIdOrAccountId'].toString();
                        var id = widget.product['id'].toString();
                        try {
                          await _addAddTask.updateTask(
                              jwtToken!,
                              taskOwner,
                              subject,
                              status,
                              reminderDate!,
                              priority,
                              leadOrAccountType,
                              leadOrAccountId,
                              id,
                              dueDate!,
                              description);
                        } catch (e) {
                          throw Exception('Error Occurred to update Task$e');
                        }

                        widget.onUpdate;

                        Navigator.pop(context);
                      },
                      child: CustomElevatedButton(
                          text: 'Update',
                          width: Dimensions.width80,
                          radius: Dimensions.radius5,
                          height: Dimensions.height30 + Dimensions.height5)),
                  SizedBox(
                    width: Dimensions.width15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CustomOutlineButton(
                        text: 'Close',
                        radius: 5,
                        textColor: Color(0xff1C51CB),
                        outlineColor: Color(0xff1C51CB),
                        width: Dimensions.width80,
                        height: Dimensions.height30 + Dimensions.height5),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget notesPage() {
    return Padding(
      padding: EdgeInsets.all(Dimensions.height10),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: Dimensions.width20,
                top: Dimensions.height25,
                right: Dimensions.width20,
                bottom: Dimensions.height5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notes",
                  style: TextStyle(
                      fontSize: Dimensions.font13,
                      color: const Color(0xff0c36a3),
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return addLeadNotes();
                          });
                    },
                    child: CustomOutlineButton(
                      text: 'Add',
                      width: Dimensions.width60,
                      height: Dimensions.height30,
                      radius: Dimensions.radius5,
                      textColor: Color(0xff1C51CB),
                      outlineColor: Color(0xff1C51CB),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          Padding(
            padding: EdgeInsets.all(Dimensions.height10),
            child: SizedBox(
              height: Dimensions.height50,
              child: Card(
                color: Colors.white,
                elevation: 1.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Create Date',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: Dimensions.font10),
                    ),
                    Text(
                      'Create By',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: Dimensions.font10),
                    ),
                    Text(
                      'Description',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: Dimensions.font10),
                    ),
                    Text(
                      'File',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: Dimensions.font10),
                    ),
                  ],
                ),
              ),
            ),
          ),
          FutureBuilder<List<NoteLeadModel>>(
            future: futureApiList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error ${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                var apiList = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                      itemCount: apiList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          child: SizedBox(
                            height: Dimensions.height50 + Dimensions.height5,
                            child: Card(
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                      width: Dimensions.width50 +
                                          Dimensions.width10,
                                      child: Text(
                                        '${apiList[index].createdDate}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: Dimensions.font10),
                                      )),
                                  SizedBox(
                                      width: Dimensions.width50 +
                                          Dimensions.width10,
                                      child: Text(
                                        '${apiList[index].createdBy}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: Dimensions.font10),
                                      )),
                                  SizedBox(
                                      width: Dimensions.width45 -
                                          Dimensions.width5,
                                      child: Text(
                                        '${apiList[index].description}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: Dimensions.font10),
                                      )),
                                  // Text('${apiList[index].file}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 10),),
                                  SizedBox(
                                      width: Dimensions.width30 +
                                          Dimensions.width5,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Image.asset(
                                            'assets/images/download.png',
                                            color: Colors.blue,
                                          )))
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return const Center(child: Text("No Data found"));
              }
            },
          )
        ],
      ),
    );
  }

  Widget addLeadNotes() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius10),
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radius15)),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.radius15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dialog Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Notes',
                    style: TextStyle(
                        fontSize: Dimensions.font18,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10),

              Text(
                " Note Description",
                style: TextStyle(fontSize: Dimensions.font13),
              ),
              // Note Description Input
              TextField(
                controller: descriptionController,
                maxLines: 2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: Dimensions.height20),

              Text(
                " Attach File",
                style: TextStyle(
                    fontSize: Dimensions.font13, fontWeight: FontWeight.bold),
              ),
              // Attach File Button
              Row(
                children: [
                  Container(
                    height: Dimensions.height30 + Dimensions.height5,
                    width: Dimensions.width80 + Dimensions.width10,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius5)),
                    child: GestureDetector(
                        onTap: () {
                          _pickFile();
                        },
                        child: Center(
                            child: Text(
                          "Choose File",
                          style: TextStyle(fontSize: Dimensions.font13),
                        ))),
                  ),
                  SizedBox(width: Dimensions.width10),
                  Text(
                    selectedFileName != null
                        ? 'Selected File: $selectedFileName'
                        : 'No file chosen',
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height15),

              const Divider(
                color: Color(0xff938787),
              ),

              SizedBox(
                height: Dimensions.height10,
              ),

              // Add Button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () async {
                        var description = descriptionController.text.toString();
                        Map<String, dynamic> dto = {
                          'taskId': id,
                          'noteDescription': description
                        };

                        try {
                          Map<String, dynamic> response = await _addAddTask
                              .addLeadNotes(jwtToken: jwtToken!, dto: dto);
                          print('Note added successfully $response');

                          widget.onUpdate;
                          setState(() {
                            futureApiList = getNoteData();
                          });
                          //Navigator.pop(context);
                        } catch (e) {
                          print('Error occurred $e');
                        }
                      },
                      child: CustomOutlineButton(
                        text: 'Add',
                        width: Dimensions.width60 + Dimensions.width5,
                        height: Dimensions.height30,
                        radius: Dimensions.radius5,
                        textColor: Color(0xff1C51CB),
                        outlineColor: Color(0xff1C51CB),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget linksPage() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: Dimensions.width20,
              top: Dimensions.height25,
              right: Dimensions.width20,
              bottom: Dimensions.height5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Links",
                style: TextStyle(
                    fontSize: Dimensions.font13,
                    color: const Color(0xff0c36a3),
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return addLinkUrl();
                        });
                  },
                  child: CustomOutlineButton(
                    text: 'Add',
                    width: Dimensions.width60,
                    height: Dimensions.height30,
                    radius: 5,
                    textColor: Color(0xff1C51CB),
                    outlineColor: Color(0xff1C51CB),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Padding(
          padding: EdgeInsets.all(Dimensions.width10),
          child: SizedBox(
            height: Dimensions.height50,
            child: Card(
              color: Colors.white,
              elevation: 1.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Create Date',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: Dimensions.font10),
                  ),
                  Text(
                    'Create By',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: Dimensions.font10),
                  ),
                  Text(
                    'Label',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: Dimensions.font10),
                  ),
                  Text(
                    'Description',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: Dimensions.font10),
                  ),
                  Text(
                    'Url',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: Dimensions.font10),
                  ),
                ],
              ),
            ),
          ),
        ),
        FutureBuilder<List<LeadLinkModel>>(
          future: futureApiListLink,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              var apiList = snapshot.data!;
              return Expanded(
                child: ListView.builder(
                    itemCount: apiList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.width10,
                            right: Dimensions.width10),
                        child: SizedBox(
                          height: Dimensions.height50 + Dimensions.height5,
                          child: Card(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: Dimensions.width60,
                                  child: Text(
                                    "${apiList[index].createdDate}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: Dimensions.font10),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.width60,
                                  child: Text(
                                    '${apiList[index].createdBy}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: Dimensions.font10),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.width45 - Dimensions.width5,
                                  child: Text(
                                    '${apiList[index].label}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: Dimensions.font10),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.width45 - Dimensions.width5,
                                  child: Text(
                                    '${apiList[index].description}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: Dimensions.font10),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.width20,
                                  child: Text(
                                    '${apiList[index].file}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: Dimensions.font10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return const Center(child: Text("No Data found"));
            }
          },
        )
      ],
    );
  }

  Widget addLinkUrl() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.height10),
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radius15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dialog Title
            Padding(
              padding: EdgeInsets.only(left: Dimensions.width15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Links',
                    style: TextStyle(
                        fontSize: Dimensions.radius15,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color(0xff938787),
            ),

            Padding(
              padding: EdgeInsets.all(Dimensions.height10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(" label"),
                  SizedBox(
                    height: Dimensions.height40,
                    child: TextField(
                      controller: linkLabelController,
                      decoration: const InputDecoration(
                          hintText: "label", border: OutlineInputBorder()),
                    ),
                  ),
                  Text(
                    " Note Description",
                    style: TextStyle(fontSize: Dimensions.font13),
                  ),
                  // Note Description Input
                  TextField(
                    controller: linkDescriptionController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),

                  // Attach File Button
                  const Text('URL'),
                  SizedBox(
                    height: Dimensions.height40,
                    child: TextField(
                      controller: urlController,
                      decoration: const InputDecoration(
                          hintText: 'youtube.com',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(height: Dimensions.height15),

                  const Divider(
                    color: Color(0xff938787),
                  ),

                  SizedBox(
                    height: Dimensions.height10,
                  ),

                  // Add Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            var label = linkLabelController.text.toString();
                            var linkDescription = linkDescriptionController.text.toString();
                            var url = urlController.text.toString();

                            await _addAddTask.addLeadLink(jwtToken!, id, label, linkDescription, url);

                            widget.onUpdate;
                            setState(() {
                              futureApiListLink = getLinkData();
                            });
                          },
                          child: CustomOutlineButton(
                            text: 'Add',
                            width: Dimensions.width60 + Dimensions.width5,
                            height: Dimensions.height30,
                            radius: 5,
                            textColor: Color(0xff1C51CB),
                            outlineColor: Color(0xff1C51CB),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<NoteLeadModel>> getNoteData() async {
    if (jwtToken != null) {
      var result = await _apiTask.getNoteLead(jwtToken!, id);
      return result.map((json) => NoteLeadModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<List<LeadLinkModel>> getLinkData() async {
    if (jwtToken != null) {
      var result = await _apiTask.getLinkLead(jwtToken!, id);
      return result.map((json) => LeadLinkModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}

Widget customText(
    String title, String subtitle, TextEditingController controller) {
  return SizedBox(
    height: Dimensions.height25,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: Dimensions.width125 + Dimensions.width5,
            child: Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.width10, top: Dimensions.height5),
              child: Text(
                title,
                style: TextStyle(
                    color: Color(0xff7B7979), fontSize: Dimensions.font13),
              ),
            )),
        Text(
          ":  ",
          style: TextStyle(
              fontSize: Dimensions.font20, color: const Color(0xff000000)),
        ),
        SizedBox(
          width: Dimensions.width200,
          child: Padding(
            padding: EdgeInsets.only(top: Dimensions.height5),
            child: TextField(
              style: TextStyle(
                  fontSize: Dimensions.font13, color: const Color(0xff363636)),
              controller: controller,
              decoration:
                  InputDecoration(hintText: subtitle, border: InputBorder.none),
            ),
          ),
        ),
      ],
    ),
  );
}

Future<String?> selectDateTime(BuildContext context) async {
  // Select date
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (pickedDate == null) {
    return null; // User canceled
  }

  // Select time
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (pickedTime == null) {
    return null; // User canceled
  }

  // Combine date and time
  final DateTime combinedDateTime = DateTime(
    pickedDate.year,
    pickedDate.month,
    pickedDate.day,
    pickedTime.hour,
    pickedTime.minute,
  );

  return DateFormat('dd/MM/yyyy hh:mm a').format(combinedDateTime);
}
