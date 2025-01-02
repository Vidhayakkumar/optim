import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:myfirstproject/auth/dio_client.dart';
import 'package:myfirstproject/auth/lead_of_account.dart';
import 'package:myfirstproject/auth/task/api_add_task.dart';
import 'package:myfirstproject/config/colors.dart';
import 'package:intl/intl.dart';

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
  String jwtToken = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJqaW1AZ21haWwuY29tIiwiaWF0IjoxNzM1NjYwMjkzLCJleHAiOjE3MzU4NDAyOTN9.UGOeL_xx5rINSNyfjK4ROKmKOfdtHb_KGMGxXLToYq1dHrlBgNYoR9BGayKCethVL9xl1Wbt2kkbYkIHpLllrw";

  String? selectedLead;
  String? selectedStatus;
  String? selectedPriority;
  String? selectedAccount;
  String? selectedDueDateTime;
  String? selectedTaskReminderDateTime;

  var lead;
  var leadId;

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
  Widget build(BuildContext context) {
    addDataAccountLis();

    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: GradientAppBar(
            gradient: const LinearGradient(colors: [blueBgColor, blueBgColor1]),
            leading: const Icon(Icons.arrow_back),
            title: const Text("Add Task"),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customTextField("Task Owner Name", "Task Owner Name", taskOwnerNameController, 1, 50),
                    const SizedBox(height: 5),
                    customTextField("Subject", 'Subject', subjectController, 1, 50),

                    // Due Date box
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Due Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  selectedDueDateTime ?? 'dd/mm/yy',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
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
                    const SizedBox(height: 5),

                    // Task Status Dropdown
                    const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        "Task Status",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: DropdownButton<String>(
                                  value: selectedStatus,
                                  hint: const Text("Select "),
                                  isExpanded: true,
                                  items: statusList.map<DropdownMenuItem<String>>((String value) {
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
                    const SizedBox(height: 5),

                    // Task Priority Dropdown
                    const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        "Task Priority",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: DropdownButton<String>(
                                  value: selectedPriority,
                                  hint: const Text("Select "),
                                  isExpanded: true,
                                  items: priorityList.map<DropdownMenuItem<String>>((String value) {
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
                    const SizedBox(height: 5),

                    // Task Reminder Date Time
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Task Reminder',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  selectedTaskReminderDateTime ?? 'dd/mm/yy',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
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
                    const SizedBox(height: 5),

                    // Leads of Accounts
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "Leads of Accounts",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: DropdownButton<String>(
                                      value: selectedLead,
                                      hint: const Text("Select "),
                                      isExpanded: true,
                                      items: LAC_List.map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedLead = newValue;
                                          fetchLeadData();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 30),
                        Container(
                          width: 210,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: DropdownButton<String>(
                                      value: selectedAccount,
                                      hint: const Text("Select Option "),
                                      isExpanded: true,
                                      items: accountList.map<DropdownMenuItem<String>>((String value) {
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

                    // Task Description Text Field
                    customTextField("Task Description", "", taskDescriptionController, 3, 100),
                    const SizedBox(height: 15),

                    // Action buttons (Add Task, Reset)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var taskOwnerName = taskOwnerNameController.text.toString();
                            var subject = subjectController.text.toString();
                            var description = taskDescriptionController.text.toString();
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
                                    (account) => account['accountName'] == selectedAccountId,
                              );
                              leadId = lead['accountId'];
                            } else if (selectedLead == 'Contact') {
                              lead = leadsList.firstWhere(
                                    (contact) => contact['fullName'] == selectedAccountId,
                              );
                              leadId = lead['contactid'];
                            }

                            String leadI = leadId.toString();

                            await _addTask.addTask(
                              jwtToken,
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
                          child: customElevatedBottom(bgAddTaskColor, "Add Task", 100, 40),
                        ),
                        const SizedBox(width: 20),
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
                          child: customElevatedBottom(bgResetColor, "Reset", 100, 40),
                        ),
                      ],
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

  void addDataAccountLis() {
    switch (selectedLead) {
      case 'Lead':
        accountList = leadsList.map((lead) => lead['customerName'] as String).toList();
        break;
      case 'Account':
        accountList = leadsList.map((lead) => lead['accountName'] as String).toList();
        break;
      case 'Contact':
        accountList = leadsList.map((lead) => lead['fullName'] as String).toList();
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



  Widget customTextField(String title, String hint,
      TextEditingController controller, int maxLines, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
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
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: const BorderSide(
                      // color: Color(0x00E3E1E1)
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: const BorderSide(
                      // color: Color(0x00FFFFFF)
                    ))),
          ),
        )
      ],
    );
  }

  Widget customElevatedBottom(
      Color color, String text, double cWidth, double cHeight) {
    return Container(
      width: cWidth,
      height: cHeight,
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
      child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }

  Future<void> fetchLead(String baseUrl) async {
    try {
      // Fetch the leads data and store it in leadsList
      List<Map<String, dynamic>> fetchedLeads =
      await _leadOfAccount.getLeadOfAccount(baseUrl, jwtToken);

      setState(() {
        leadsList = fetchedLeads;
      });
    } catch (e) {
      print('Error: $e');
    }
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