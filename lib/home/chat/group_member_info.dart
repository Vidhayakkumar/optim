import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfirstproject/config/dimensions.dart';
import 'package:myfirstproject/config/colors.dart';

class GroupMemberInfo extends StatelessWidget {
  GroupMemberInfo({super.key});

  final List<String> contents = [
    'Group Info',
    'Mute Notification',
    'Disappear Massages',
    "Exit Group"
  ];

  @override
  Widget build(BuildContext context) {
    // Define mq as Size
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensions.height160),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: Dimensions.height40),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryColor, // Use primaryColor
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Dimensions.height40),
                    child: Column(
                      children: [
                        Image.asset('assets/images/bright.png'),
                        Text(
                          'BrightLink',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.font18), // Use textBlack
                        ),
                        const Text(
                          'IT Solution',
                          style: TextStyle(
                              color: AppColors.textGrey), // Use textGrey
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: Dimensions.height40),
                    child: PopupMenuButton(itemBuilder: (context) {
                      return contents
                          .map((e) =>
                              PopupMenuItem<String>(value: e, child: Text(e)))
                          .toList();
                    }),
                  ),
                ],
              ),
              const Divider(
                color: AppColors.dividerColor, // Use dividerColor
              )
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "6 members",
                        style: TextStyle(
                            color: AppColors.textGrey), // Use textGrey
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.search))
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/invite_link.svg'),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      const Text(
                        'Add Members',
                        style: TextStyle(color: Colors.black), // Use textBlack
                      )
                    ],
                  ),
                  SizedBox(height: Dimensions.height10),
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/invite_link.svg'),
                      SizedBox(
                        width: Dimensions.height10,
                      ),
                      const Text(
                        'Invite Via Link',
                        style: TextStyle(color: Colors.black), // Use textBlack
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              color: AppColors.dividerColor, // Use dividerColor
            ),
            Expanded(
              child: ListView(
                children: [
                  const MemberTile(name: "Kartik Nikhade", isAdmin: true),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.width50 + Dimensions.width5,
                        right: Dimensions.width20),
                    child: const Divider(
                      color: AppColors.dividerColor, // Use dividerColor
                    ),
                  ),
                  const MemberTile(name: "Kavita"),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.width50 + Dimensions.width5,
                        right: Dimensions.width20),
                    child: const Divider(
                      color: AppColors.dividerColor, // Use dividerColor
                    ),
                  ),
                  const MemberTile(name: "Sakshi"),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.width50 + Dimensions.width5,
                        right: Dimensions.width20),
                    child: const Divider(
                      color: AppColors.dividerColor, // Use dividerColor
                    ),
                  ),
                  const MemberTile(name: "Yadnyaseni"),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.width50 + Dimensions.width5,
                        right: Dimensions.width20),
                    child: const Divider(
                      color: AppColors.dividerColor, // Use dividerColor
                    ),
                  ),
                  const MemberTile(name: "Prajwal"),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.width50 + Dimensions.width5,
                        right: Dimensions.width20),
                    child: const Divider(
                      color: AppColors.dividerColor, // Use dividerColor
                    ),
                  ),
                  const MemberTile(name: "Shalini"),
                  SizedBox(height: Dimensions.height5),
                  const Divider(
                    color: AppColors.dividerColor, // Use dividerColor
                  ),
                  SizedBox(height: Dimensions.height5),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width10),
                        child: SvgPicture.asset('assets/images/exit.svg'),
                      ),
                      SizedBox(width: Dimensions.width5),
                      Text(
                        "Exit Group",
                        style: TextStyle(
                            color: Colors.red, // Use red
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.font17),
                      )
                    ],
                  ),
                  SizedBox(height: Dimensions.height5),
                  const Divider(
                    color: AppColors.dividerColor, // Use dividerColor
                  ),
                ],
              ),
            ),
          ],
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
    return SizedBox(
      height: Dimensions.height40,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey, // Use grey
          child: Image.asset('assets/images/man.png'),
        ),
        title: Text(name),
        trailing: isAdmin
            ? Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width10,
                    vertical: Dimensions.height5),
                decoration: BoxDecoration(
                  color: Colors.blue, // Use blue
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                ),
                child: Text(
                  "Group Admin",
                  style: TextStyle(
                      color: Colors.white, fontSize: Dimensions.font13),
                ),
              )
            : null,
      ),
    );
  }
}
