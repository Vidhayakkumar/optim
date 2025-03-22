import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';
import 'package:myfirstproject/auth/task/lead_of_account.dart';
import 'package:myfirstproject/auth/task/api_add_task.dart';
import 'package:myfirstproject/config/colors.dart';
import 'package:intl/intl.dart';
import 'package:myfirstproject/config/dimensions.dart';
import 'package:myfirstproject/widget/custom_elevated_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTasks extends StatefulWidget {
  final Future<void> Function() onUpdate;

  const AddTasks({super.key, required this.onUpdate, required product});

  @override
  State<StatefulWidget> createState() => AddTasksState();
}

class AddTasksState extends State<AddTasks> {
  TextEditingController taskOwnerNameController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();

  final LeadOfAccount _leadOfAccount = LeadOfAccount(DioClient());
  final ApiAddTask _addTask = ApiAddTask(DioClient());

  var apiList = [];
  String? jwtToken;
  String? selectedLead;
  String? selectedStatus;
  String? selectedPriority;
  String? selectedAccount;
  String? selectedDueDateTime;
  String? selectedTaskReminderDateTime;
  var lead;
  var leadId;
  bool _isLoading = false;

  List<Map<String, dynamic>> leadsList = [];
  List<String> accountList = [];

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

  final List<String> LAC_List = [
    "Select",
    "Lead",
    "Account",
    "Contact",
  ];

  @override
  void initState() {
    super.initState();
    _loadJwtToken().then((_) {
      setState(() {
        addDataAccountLis();
        fetchLeadData();
      });
    });
  }

  void addDataAccountLis() {
    switch (selectedLead) {
      case 'Lead':
        accountList =
            leadsList.map((lead) => lead['customerName'].toString()).toList();
        break;
      case 'Account':
        accountList =
            leadsList.map((lead) => lead['accountName'].toString()).toList();
        break;
      case 'Contact':
        accountList =
            leadsList.map((lead) => lead['fullName'].toString()).toList();
        break;
    }
  }

  void fetchLeadData() {
    switch (selectedLead) {
      case 'Lead':
        fetchLead('/employee/leadlist');
        break;
      case 'Account':
        fetchLead('/employee/accountlist');
        break;
      case 'Contact':
        fetchLead('/employee/contactlist');
        break;
    }
  }

  Future<void> fetchLead(String baseUrl) async {
    try {
      // Fetch the leads data and store it in leadsList
      List<Map<String, dynamic>> fetchedLeads =
          await _leadOfAccount.getLeadOfAccount(baseUrl, jwtToken!);
      setState(() {
        leadsList = fetchedLeads;
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _loadJwtToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      jwtToken = prefs.getString('jwtToken');
    } catch (e) {
      throw Exception('Error Occurred $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    addDataAccountLis();
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.height45),
          child: GradientAppBar(
            gradient: const LinearGradient(
                colors: [AppColors.blueBgColor, AppColors.mainColor]),
            leading: const Icon(Icons.arrow_back),
            title: const Text("Add Task"),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(
              left: Dimensions.width10,
              right: Dimensions.width10,
              top: Dimensions.height20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField("Task Owner Name", "Task Owner Name",
                    taskOwnerNameController, 1, Dimensions.height50),
                SizedBox(height: Dimensions.height5),
                customTextField("Subject", 'Subject', subjectController, 1,
                    Dimensions.height50),

                // Due Date box
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width10),
                      child: const Text(
                        'Due Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(Dimensions.radius5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: Dimensions.width10),
                            child: Text(
                              selectedDueDateTime ?? 'dd/mm/yy',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
                            icon: const Icon(Icons.calendar_today_outlined),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height5),

                // Task Status Dropdown
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width10),
                  child: const Text(
                    "Task Status",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(Dimensions.radius5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimensions.width10),
                            child: DropdownButton<String>(
                              value: selectedStatus,
                              hint: const Text("Select "),
                              isExpanded: true,
                              items: statusList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
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
                SizedBox(height: Dimensions.height5),

                // Task Priority Dropdown
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width10),
                  child: const Text(
                    "Task Priority",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(Dimensions.radius5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimensions.width10),
                            child: DropdownButton<String>(
                              value: selectedPriority,
                              hint: const Text("Select "),
                              isExpanded: true,
                              items: priorityList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
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
                SizedBox(height: Dimensions.height5),

                // Task Reminder Date Time
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width10),
                      child: const Text(
                        'Task Reminder',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(Dimensions.radius5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: Dimensions.width10),
                            child: Text(
                              selectedTaskReminderDateTime ?? 'dd/mm/yy',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              String? result = await selectDateTime(context);
                              if (result != null) {
                                setState(() {
                                  selectedTaskReminderDateTime = result;
                                });
                              }
                            },
                            icon: const Icon(Icons.calendar_today_outlined),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height5),

                // Leads of Accounts
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width5),
                  child: const Text(
                    "Leads of Accounts",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Row(
                          children: [
                            Container(
                              width: Dimensions.width125 - Dimensions.width5,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: Dimensions.width5),
                                        child: DropdownButton<String>(
                                          value: selectedLead,
                                          hint: const Text("Select "),
                                          isExpanded: true,
                                          items: LAC_List.map<
                                                  DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _isLoading = true;
                                              selectedAccount = null;
                                              selectedLead = newValue;

                                              fetchLeadData();

                                              // addDataAccountLis();
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: Dimensions.width30),
                            Container(
                              width: Dimensions.width220 - Dimensions.width10,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: Dimensions.width10),
                                        child: DropdownButton<String>(
                                          value: selectedAccount,
                                          hint: const Text("Select Option "),
                                          isExpanded: true,
                                          items: accountList
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedAccount = newValue;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),

                // Task Description Text Field
                customTextField("Task Description", "",
                    taskDescriptionController, 3, Dimensions.height100),
                SizedBox(height: Dimensions.height15),

                // Action buttons (Add Task, Reset)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        var taskOwnerName =
                            taskOwnerNameController.text.toString();
                        var subject = subjectController.text.toString();
                        var description =
                            taskDescriptionController.text.toString();
                        var deuDate = selectedDueDateTime.toString();
                        var taskStatus = selectedStatus.toString();
                        var taskPriority = selectedPriority.toString();
                        var taskRemainder = selectedDueDateTime.toString();
                        var accountType = selectedLead.toString();
                        var selectedAccountId = selectedAccount.toString();
                        if (selectedLead == "Lead") {
                          lead = leadsList.firstWhere(
                            (lead) => lead['customerName'] == selectedAccountId,
                          );
                          leadId = lead['leadId'];
                        } else if (selectedLead == "Account") {
                          lead = leadsList.firstWhere(
                            (account) =>
                                account['accountName'] == selectedAccountId,
                          );
                          leadId = lead['accountId'];
                        } else if (selectedLead == 'Contact') {
                          lead = leadsList.firstWhere(
                            (contact) =>
                                contact['fullName'] == selectedAccountId,
                          );
                          leadId = lead['contactid'];
                        }

                        String leadI = leadId.toString();

                        await _addTask.addTask(
                          jwtToken!,
                          taskOwnerName,
                          subject,
                          deuDate,
                          taskStatus,
                          taskPriority,
                          taskRemainder,
                          accountType,
                          leadI,
                          description,
                        );

                        widget.onUpdate;
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: CustomElevatedButton(
                        text: 'Add Task',
                        radius: 5,
                        width: Dimensions.width80 + Dimensions.width20,
                        height: Dimensions.height40,
                        color: AppColors.bgAddTaskColor,
                      ),
                    ),
                    SizedBox(width: Dimensions.width20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          taskOwnerNameController.clear();
                          subjectController.clear();
                          taskDescriptionController.clear();
                          selectedDueDateTime = "dd/mm/yy";
                          selectedTaskReminderDateTime = "dd/mm/yy";
                        });
                      },
                      child: CustomElevatedButton(
                        text: 'Reset',
                        radius: 5,
                        color: Color(0xff5BB85D),
                        width: Dimensions.width80 + Dimensions.width20,
                        height: Dimensions.height40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextField(String title, String hint,
      TextEditingController controller, int maxLines, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: Dimensions.width10),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: height,
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
                hintText: hint,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius5),
                )),
          ),
        )
      ],
    );
  }
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
