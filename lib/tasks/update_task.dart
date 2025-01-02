import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:myfirstproject/config/colors.dart';
import 'package:myfirstproject/model/task_model.dart';

class UpdateTask extends StatefulWidget {
  final Map<String ,dynamic> product;
  final Future<void> Function() onUpdate;
  const UpdateTask({  super.key, required this.product, required this.onUpdate});

  @override
  State<StatefulWidget> createState() => UpdateTaskState();
}

class UpdateTaskState extends State<UpdateTask> {

  String jwtToken ="eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhbGVuQGdtYWlsLmNvbSIsImlhdCI6MTczNTEzNDkxNSwiZXhwIjoxNzM1MzE0OTE1fQ.Y0BhggRkwEyR205-cKYPWDzT1u44t12WYQs38OjAXVEpgdh7XSjf1tkqouYwrpPMkQJMQC4CquWsdVzirDE4Lw";


  TextEditingController taskOwnerController = TextEditingController();
  TextEditingController subjectController=TextEditingController();
  TextEditingController taskTitleController=TextEditingController();
  TextEditingController leadTypeController=TextEditingController();
  TextEditingController statusController=TextEditingController();
  TextEditingController priorityController=TextEditingController();
  TextEditingController reminderDateController=TextEditingController();
  TextEditingController dueDateController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    taskOwnerController=TextEditingController(text: widget.product['taskOwner'].toString());
    subjectController=TextEditingController(text: widget.product['subject'].toString());
  //  taskTitleController=TextEditingController(text: widget.product[''])
    leadTypeController=TextEditingController(text: widget.product['leadOrAccountType'].toString());
    statusController=TextEditingController(text: widget.product['status'].toString());
    priorityController=TextEditingController(text: widget.product['priority'].toString());
    reminderDateController=TextEditingController(text: widget.product['reminderDate'].toString());
    dueDateController=TextEditingController(text: widget.product['duedate'].toString());
    descriptionController=TextEditingController(text: widget.product['description'].toString());

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: GradientAppBar(
              gradient:
                  const LinearGradient(colors: [blueBgColor, blueBgColor1]),
              leading: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_back)),
              title: const Text("Update Task"),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Task Information", style: TextStyle(
                          color: Color(0xff3B4EFA),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      ),
                      const Divider(color: Color(0xff8C7C7C), thickness: 2,),
                      customText('Task Owner', 'abiha', taskOwnerController),
                      const Divider(color: Color(0xffE3E1E1),thickness: 3,),
                      customText('Subject', 'computer', subjectController),
                      const Divider(color: Color(0xffE3E1E1),thickness: 3,),
                      customText('Task Title', 'abiha', taskTitleController),
                      const Divider(color: Color(0xffE3E1E1),thickness: 3,),
                      customText('Type', 'Account, Contact, Lead', leadTypeController),
                      const Divider(color: Color(0xffE3E1E1),thickness: 3,),
                      customText('Status', 'Complete', subjectController),
                      const Divider(color: Color(0xffE3E1E1),thickness: 3,),
                      customText('Priority', 'Height', priorityController),
                      const Divider(color: Color(0xffE3E1E1),thickness: 3,),
                      customText('Reminder','dd/mm/yy', reminderDateController),
                      const Divider(color: Color(0xffE3E1E1),thickness: 3,),
                      customText('Due Date', 'dd/mm/yy', dueDateController),
                      const Divider(color: Color(0xffE3E1E1),thickness: 3,),
                      const Text("Description",style: TextStyle(
                          color: Color(0xff3B4EFA),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      ),
                      const Divider(color: Color(0xff8C7C7C), thickness: 2,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            controller: descriptionController,
                            maxLines: 3,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                    borderSide: const BorderSide(
                                        color: Color(0xffE3E1E1))
                                ),
                              focusedBorder:  const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffE3E1E1),
                                )
                              )
                            )
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customElevatedBottom(const Color(0xff1C51CB), 'Update', 70, 30),
                          const SizedBox(width: 15,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 70,
                              height: 30,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xff1C51CB)
                                  ),
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: const Center(child: Text("Close",style: TextStyle(color: Color(0xff1C51CB)),)),
                            ),
                          )
                        ],
                      )
                    ],

                  ),
                ],
              )
            ),
          )),
    );
  }
}

Widget customText(String title, String subtitle, TextEditingController controller) {
  return SizedBox(
    height: 40,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 125,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: const TextStyle(color: Color(0xff7B7979), fontSize: 20),
              ),
            )),
        const Text(":  ",style: TextStyle(fontSize: 25,color: Color(0xff000000)),),
        SizedBox(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(),
            child: TextField(
              style:  const TextStyle(
                fontSize: 19,
                color: Color(0xff363636)
              ),
               controller: controller,
              decoration: InputDecoration(
                hintText: subtitle,
                border: InputBorder.none
              ),
                 ),
            ),
          ),

      ],
    ),
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