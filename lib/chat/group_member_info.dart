
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main.dart';

class GroupMemberInfo extends StatelessWidget {
   GroupMemberInfo({super.key});

  final List<String> contents=[
    'Group Info',
    'Mute Notification',
    'Disappear Massages',
    "Exit Group"
  ];

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(151),
            child:Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(bottom: mq.height *.05),
                            child: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back,color: Color(0xff2354C5),)),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: mq.height*.05),
                            child: Column(
                              children: [
                                Image.asset('assets/images/bright.png'),
                                const Text('BrightLink',style: TextStyle(color: Colors.black,fontSize: 18),),
                                const Text('IT Solution',style: TextStyle(color: Color(0xff8D8D8D)),)
                              ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(bottom: mq.height*.05),
                            child: PopupMenuButton(
                                itemBuilder:(context){
                                  return contents
                                      .map((e)=>PopupMenuItem<String>(value: e, child:Text(e))).toList();
                                } ),
                          ),
                        ],
                      ),
                  const Divider(color: Color(0xffE3E1E1),)
                ],
              ),
            ),
            ),
        body: Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("6 members",style: TextStyle(color: Color(0xff8D8D8D)),),
                            IconButton(onPressed: (){}, icon: const Icon(Icons.search))
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset('assets/images/invite_link.svg'),
                            const SizedBox(width: 10,),
                            const Text('Add Members',style: TextStyle(color: Colors.black),)
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            SvgPicture.asset('assets/images/invite_link.svg'),
                            const SizedBox(width: 10,),
                            const Text('Invite Via Link',style: TextStyle(color: Colors.black),)
                          ],
                        ),

                      ],
                    ),
                  ),
                  const Divider(color: Color(0xffE3E1E1),),
                  Expanded(
                    child: ListView(
                      children: [
                        const MemberTile(name: "Kartik Nikhade", isAdmin: true),
                        const Padding(
                          padding: EdgeInsets.only(left: 55,right: 20),
                          child: Divider(color: Color(0xffE3E1E1),),
                        ),
                        const MemberTile(name: "Kavita"),
                        const Padding(
                          padding: EdgeInsets.only(left: 55,right: 20),
                          child: Divider(color: Color(0xffE3E1E1),),
                        ),
                        const MemberTile(name: "Sakshi"),
                        const Padding(
                          padding: EdgeInsets.only(left: 55,right: 20),
                          child: Divider(color: Color(0xffE3E1E1),),
                        ),
                        const MemberTile(name: "Yadnyaseni"),
                        const Padding(
                          padding: EdgeInsets.only(left: 55,right: 20),
                          child: Divider(color: Color(0xffE3E1E1),),
                        ),
                        const MemberTile(name: "Prajwal"),
                        const Padding(
                          padding: EdgeInsets.only(left: 55,right: 20),
                          child: Divider(color: Color(0xffE3E1E1),),
                        ),
                        const MemberTile(name: "Shalini"),
                        SizedBox(height: 5,),
                        const Divider(color: Color(0xffE3E1E1),),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                         Padding(
                           padding: EdgeInsets.only(left: mq.width *.1),
                           child: SvgPicture.asset('assets/images/exit.svg'),
                           
                         ),
                            const SizedBox(width: 10,),
                            const Text("Exit Group",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 17),)
                          ],
                        ),
                        SizedBox(height: 10,),
                        const Divider(color: Color(0xffE3E1E1),),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}

class MemberTile extends StatelessWidget {
  final String name;
  final bool isAdmin;

  const MemberTile({Key? key, required this.name, this.isAdmin = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      height: 40,
      child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Image.asset('assets/images/man.png'),
            ),
            title: Text(name),
            trailing: isAdmin
                ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Group Admin",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            )
                : null,
          ),
    );

  }
}