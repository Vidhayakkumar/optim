import 'package:flutter/material.dart';
import 'package:myfirstproject/config/colors.dart';
import 'package:myfirstproject/page/product_page.dart';
import 'package:myfirstproject/tasks/tasks_lists.dart';

class EmployeeScreen extends StatefulWidget{
  const EmployeeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
     return _EmployeeScreenState();
  }

}

class _EmployeeScreenState extends State<EmployeeScreen>{

  var _currentIndex = 0;
  var image=[
    'assets/images/Dashboard.png',
    'assets/images/Pipeline.png',
    'assets/images/Call_log.png',
    'assets/images/Lead.png',
    'assets/images/Company_Account.png',
    'assets/images/Quotation.png',
    'assets/images/Chat.png',
    'assets/images/Marketing.png',
    'assets/images/Template.png',
    'assets/images/Revenue.png',
    'assets/images/Sales_Invoice.png',
    'assets/images/Product.png',
    'assets/images/Contact.png',
    'assets/images/Tasks.png',
    'assets/images/Meeting.png',
    'assets/images/Calender.png',
    'assets/images/Vendor.png',
    'assets/images/Pipeline_Report.png',
  ];


  @override
  Widget build(BuildContext context) {
   return Scaffold(
       appBar: AppBar(

           title: const Text("SALESOPTIM"),
          // leading: Image.asset("assets/images/sales.png",width: 160,height: 30,),
         actions: [
           IconButton(onPressed: (){}, icon: Image.asset("assets/images/switch.png"))
         ],
         backgroundColor: Colors.blueGrey,

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
             onTap: (index){
             setState(() {
               _currentIndex=index;
             });
             },
             items:  const [
               BottomNavigationBarItem(icon: Icon(Icons.home),label:'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.notifications_active),label: "Notifications"),
                BottomNavigationBarItem(icon: Icon(Icons.alarm),label: 'Reminder'),
                BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile')
             ]
         ),
       ),
       body:GridView.builder(
         itemCount: image.length,
           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),

           itemBuilder: (BuildContext context,int index){
             return GestureDetector(
               onTap: (){
                 switch(index){
                   case 11: Navigator.push(context,
                       MaterialPageRoute(builder: (_)=>const ProductScreen()));
                   case 13: Navigator.push(context, MaterialPageRoute(builder: (_)=>TaskList()));

                 }
               },
               child: Card(
                 child: Column(
                   children: [
                     const SizedBox(
                       height: 20,
                     ),
                      Image.asset(image[index])
                   ],
                 ),
               ),
             );

           }
       )

   );
  }

}