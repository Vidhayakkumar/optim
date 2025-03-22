import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:myfirstproject/auth/chat/profile/get_user_details.dart';
import 'package:myfirstproject/auth/chat/profile/update_user_details.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';
import 'package:myfirstproject/config/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GetUserDetails _getUserDetails = GetUserDetails(DioClient());
  final ApiUpdateUserDetailsProfile _apiUpdateUserDetailsProfile =
      ApiUpdateUserDetailsProfile(DioClient());

  String? gender;
  int _currentIndex = 3;
  String? jwtToken;
  int? id;
  String? logoImage;
  String? image;
  Map<String, dynamic>? userList;
  Uint8List? profileImage;
  Uint8List? backImage;
  String? userName;
  String? jobTitle;
  bool isEditing = false;
  File? selectedFileName;
  String? departmentName;
  int? empID;

  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyPhoneController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController gstInNumberController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  final List<String> contents = [
    'Group Info',
    'Mute Notification',
    'Disappear Messages',
    "Exit Group"
  ];

  final List<String> departmentList = [
    'Purchase',
    'Sales Team',
    'Marketing',
    'IT',
    'Production',
    'Other'
  ];

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      if (file.path.endsWith('.jpg') ||
          file.path.endsWith('.jpeg') ||
          file.path.endsWith('.png')) {
        setState(() {
          selectedFileName = file;
          profileImage = selectedFileName as Uint8List?;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Only JPG, JPEG, and PNG images are allowed')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file selected')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      jwtToken = prefs.getString('jwtToken');
      id = prefs.getInt('id');
      empID = prefs.getInt('empID');
      if (jwtToken != null && id != null) {
        userList = await _getUserDetails.getUserDetailsData(jwtToken!, id!);
        if (userList != null) {
          setState(() {
            nameController.text = userList?['name'] ?? '';
            dobController.text = userList?['dateOfBirh'] ?? '';
            phoneController.text = userList?['phone'] ?? '';
            emailController.text = userList?['email'] ?? '';
            roleController.text = userList?['role'] ?? '';
            designationController.text = userList?['jobTitle'] ?? '';
            departmentController.text = userList?['dept'] ?? '';
            addressController.text = userList?['permanantAddr'] ?? '';
            gender = userList?['gender'] ?? '';
            companyNameController.text = userList?['companyName'] ?? '';
            companyPhoneController.text = userList?['companyPhone'] ?? '';
            companyAddressController.text = userList?['companyAddress'] ?? '';
            companyEmailController.text = userList?['companyEmail'] ?? '';
            gstInNumberController.text = userList?['gstin'] ?? '';
            logoImage = userList?['logoImage'] ?? '';
            image = userList?['images'] ?? '';
            userName = userList?['name'] ?? '';
            jobTitle = userList?['jobTitle'] ?? '';
            departmentName = userList?['dept'] ?? '';

            if (image != null && image!.isNotEmpty) {
              profileImage =
                  base64Decode(image!.replaceAll(RegExp(r'\s+'), ''));
            } else {
              profileImage = null;
            }
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to load user data')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('JWT Token or ID is null')),
        );
      }
    } catch (e) {
      print('Error loading user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading user data: $e')),
      );
    }
  }

  Future<void> updateUserProfile() async {
    if (jwtToken == null || jwtToken!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('JWT Token is missing')),
      );
      return;
    }

    if (empID == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Employee ID is missing')),
      );
      return;
    }

    Map<String, dynamic> dto = {
      'dateOfBirth': dobController.text.toString(),
      'dept': departmentName ?? '',
      'gender': gender ?? '',
      'id': empID,
      'jobTitle': designationController.text.toString(),
      'name': nameController.text.toString(),
      'permanantAddr': addressController.text.toString(),
      'phone': phoneController.text.toString(),
    };

    try {
      var results = await _apiUpdateUserDetailsProfile.updateUserProfile(
        jwtToken: jwtToken!,
        imageFile: selectedFileName,
        dto: dto,
      );

      if (results != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
        setState(() {
          isEditing = false;
          loadUserData();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.keyboard_arrow_left_outlined)),
        title: const Center(child: Text('Profile')),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return contents
                .map((e) => PopupMenuItem<String>(value: e, child: Text(e)))
                .toList();
          })
        ],
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
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active), label: 'Notification'),
            BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Reminder'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Profile Image and Details
                Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: SizedBox(
                              height: mq.height * .18,
                              child: Stack(
                                children: [
                                  Image.asset('assets/images/Bk_Image.png')
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: mq.width * .37,
                            bottom: 5,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: profileImage != null
                                  ? MemoryImage(profileImage!)
                                  : null,
                              child: profileImage == null
                                  ? Image.asset('assets/images/profile.png')
                                  : null,
                            ),
                          ),
                          Positioned(
                            top: mq.height * .11,
                            right: 5,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  pickFile();
                                });
                              },
                              icon: const Icon(Icons.edit,
                                  color: Color(0xff6F7376)),
                            ),
                          )
                        ],
                      ),
                      Text(
                        '$userName',
                        style: const TextStyle(
                            color: Color(0xff32325D), fontSize: 16),
                      ),
                      Text(
                        '$jobTitle',
                        style: const TextStyle(
                            color: Color(0xff6F7376), fontSize: 10),
                      )
                    ],
                  ),
                ),
                // Personal Information
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Personal Information',
                              style: TextStyle(
                                  color: Color(0xff244DC7),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isEditing = !isEditing;
                                });
                              },
                              icon: const Icon(Icons.edit,
                                  color: Color(0xff6F7376)),
                            ),
                          ],
                        ),
                        const Divider(color: Color(0xffCDD4DB)),
                        customTextField(nameController, 'Name', ' ', isEditing),
                        const Divider(color: Color(0xffCDD4DB)),
                        customTextField(
                            dobController, 'DOB', 'null', isEditing),
                        const Divider(color: Color(0xffCDD4DB)),
                        customTextField(
                            emailController, 'Email', ' ', isEditing),
                        const Divider(color: Color(0xffCDD4DB)),
                        customTextField(
                            phoneController, 'Phone', ' ', isEditing),
                        const Divider(color: Color(0xffCDD4DB)),
                        customTextField(roleController, 'Role', ' ', false),
                        const Divider(color: Color(0xffCDD4DB)),
                        customTextField(designationController, 'Designation',
                            ' ', isEditing),
                        const Divider(color: Color(0xffCDD4DB)),
                        const Text(
                          'Department',
                          style:
                              TextStyle(fontSize: 13, color: Color(0xff1E1E1E)),
                        ),
                        SizedBox(
                          height: 30,
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  value: departmentName,
                                  items: departmentList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff8C8C8C)),
                                        ));
                                  }).toList(),
                                  onChanged: isEditing
                                      ? (String? newValue) {
                                          setState(() {
                                            departmentName = newValue;
                                          });
                                        }
                                      : null)),
                        ),
                        const Divider(color: Color(0xffCDD4DB)),
                        customTextField(
                            addressController, 'Address', ' ', isEditing),
                        const Divider(color: Color(0xffCDD4DB)),
                        const Text('Gender',
                            style: TextStyle(
                                color: Color(0xff1E1E1E), fontSize: 12)),
                        Row(
                          children: [
                            Radio(
                                value: 'Male',
                                groupValue: gender,
                                onChanged: isEditing
                                    ? (value) {
                                        setState(() {
                                          gender = value.toString();
                                        });
                                      }
                                    : null),
                            const Text('Male'),
                            const SizedBox(width: 10),
                            Radio(
                                value: 'Female',
                                groupValue: gender,
                                onChanged: isEditing
                                    ? (value) {
                                        setState(() {
                                          gender = value.toString();
                                        });
                                      }
                                    : null),
                            const Text('Female')
                          ],
                        ),
                        const Divider(color: Color(0xffCDD4DB)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            customButton('Reset', 40, 100, 20),
                            GestureDetector(
                                onTap: updateUserProfile,
                                child: customElevatedBottom(AppColors.mainColor, 'Save', 100, 40, 20))
                          ],
                        ),
                        const Divider(color: Color(0xffCDD4DB)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Company detail',
                                style: TextStyle(
                                    color: Color(0xff244DC7),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            Image.asset('assets/images/company.png'),
                          ],
                        ),
                        const Divider(color: Color(0xffCDD4DB)),
                        customTextField(
                            companyNameController,
                            'Name',
                            'BrightLink infotechnologies private limited',
                            isEditing),
                        const Divider(color: Color(0xffCDD4DB)),
                        customTextField(companyPhoneController, 'Phone',
                            '+91 8149055001', isEditing),
                        const Divider(color: Color(0xffCDD4DB)),
                        customTextField(companyEmailController, 'Email',
                            'info@BrightLinkinfotechnologies.com', isEditing),
                        const Divider(color: Color(0xffCDD4DB)),
                        customTextField(
                            companyAddressController,
                            'Address',
                            'First floor shalini corner building office no - 11 karve nagar,Pune , Maharashtra',
                            isEditing),
                        const Divider(color: Color(0xffCDD4DB)),
                        customTextField(gstInNumberController, 'GSTIN Number',
                            '27AAMCB0558', isEditing),
                        const Divider(color: Color(0xffCDD4DB)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            customButton('Reset', 40, 100, 20),
                            customElevatedBottom(AppColors.mainColor, 'Save', 100, 40, 20)
                          ],
                        ),
                        const Divider(color: Color(0xffCDD4DB)),
                        const Row(
                          children: [
                            Text('Change Password',
                                style: TextStyle(
                                    color: Color(0xff244DC7),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Divider(color: Color(0xffCDD4DB)),
                        customTextField(oldPasswordController, 'Old',
                            '23dsf23r43', isEditing),
                        const Divider(color: Color(0xffCDD4DB)),
                        customTextField(newPasswordController, 'New',
                            'we345345sd', isEditing),
                        const Divider(color: Color(0xffCDD4DB)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            customElevatedBottom(AppColors.mainColor, 'Save Change', 150, 40, 20),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextField(TextEditingController controller, String title,
      String subtitle, bool isEnable) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(color: Color(0xff1E1E1E), fontSize: 12)),
        const SizedBox(height: 1),
        SizedBox(
          height: 15,
          child: TextField(
            style: const TextStyle(fontSize: 10, color: Color(0xff8C8C8C)),
            controller: controller,
            enabled: isEnable,
            decoration: InputDecoration(
                hintStyle: const TextStyle(color: Color(0xff8C8C8C)),
                hintText: subtitle,
                border: InputBorder.none),
          ),
        ),
      ],
    );
  }

  Widget customButton(
      String text, double height, double width, double fontSize) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.mainColor),
      ),
      child: Center(
        child: Text(text,
            style: TextStyle(color: AppColors.mainColor, fontSize: fontSize)),
      ),
    );
  }

  Widget customElevatedBottom(
      Color color, String text, double width, double height, double fontSize) {
    return Container(
      height: height,
      width: width,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ),
      ),
    );
  }
}
