
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminPage extends StatefulWidget{
  const AdminPage({super.key});

  @override
  State<StatefulWidget> createState() => _AdminState();
}

class _AdminState extends State<AdminPage>{

  var _currentIndex=0;


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

  var text=[
    'Business\nDashboard',
    'Call_Dialer',
  ];



  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text("SALESOPTIM"),
       actions: [
         IconButton(onPressed: (){}, icon: const Icon(Icons.message))
       ],
       backgroundColor: Colors.blueGrey,
     ),

     bottomNavigationBar: BottomNavigationBar(
         backgroundColor: Colors.blueGrey,
         currentIndex: _currentIndex,
         type: BottomNavigationBarType.fixed,
         onTap: (index){
           setState(() {
             _currentIndex=index;
           });
         },
         items:  const [
           BottomNavigationBarItem(icon: Icon(Icons.home),label:'Home'),
           BottomNavigationBarItem(icon: Icon(Icons.alarm),label: 'Reminder'),
           BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile')
         ]
     ),
     body: GridView.builder(
       itemCount: image.length,
         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
         itemBuilder: (BuildContext context, int index){
           return Card(
             child: Column(
               children: [
                 const SizedBox(height: 20,),
                Image.asset(image[index]),

               ],
             )
           );
         }
     )
   );
  }

}