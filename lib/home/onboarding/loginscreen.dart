import 'package:flutter/material.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/api_service/api_service.dart';
import '../../config/dimensions.dart';
import '../../home/page/admin_page.dart';
import '../../home/page/employee_page.dart';
import '../../main.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool tracker = false;
  final bool _validate = false;
  bool obsecureText = true;

  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ApiService _apiService = ApiService(DioClient());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [Image.asset("assets/images/Vector.png")],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(Dimensions.height20),
                child: Column(
                  children: [
                    Image.asset("assets/images/_icon.png"),
                    SizedBox(height: Dimensions.height100),
                    Column(
                      children: [
                        TextFormField(
                          controller: userIdController,
                          decoration: InputDecoration(
                            errorText: _validate ? 'please enter email' : null,
                            label: const Text("Email Address"),
                            suffixIcon: const Icon(Icons.email),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(12, 80, 175, 1.0)),
                              borderRadius: BorderRadius.circular(Dimensions.radius10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(112, 100, 175, 1.0)),
                              borderRadius: BorderRadius.circular(Dimensions.radius10),
                            ),
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "please enter text ";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: Dimensions.height15),
                        TextFormField(
                          obscureText: obsecureText,
                          controller: passwordController,
                          decoration: InputDecoration(
                              label: const Text("Password"),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obsecureText = !obsecureText;
                                    });
                                  },
                                  icon: Icon(obsecureText
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(12, 80, 175, 1.0)),
                                borderRadius: BorderRadius.circular(Dimensions.radius10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color:
                                      Color.fromRGBO(112, 100, 175, 1.0)),
                                  borderRadius: BorderRadius.circular(Dimensions.radius10))),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "please enter text ";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: tracker,
                            checkColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                tracker = !tracker;
                              });
                            }),
                        const Text("Remember password ")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text("Forget Password?"))
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                            width: Dimensions.width340,
                            height: Dimensions.height50,
                            child: ElevatedButton(
                              onPressed: () async {
                                var userAddress =
                                userIdController.text.toString();
                                var passwordId =
                                passwordController.text.toString();

                                if (_formKey.currentState!.validate()) {
                                  if (userAddress.isNotEmpty &&
                                      passwordId.isNotEmpty) {
                                    try {
                                      // API call for login
                                      final response = await _apiService.loginUser(
                                          userAddress, passwordId);

                                      print("API Response: $response"); // Debugging

                                      if (response.containsKey('jwtToken')) {
                                        saveData(response);

                                        final token = response['role'];

                                        if (token == "ROLE_EMP") {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                  const EmployeeScreen()));
                                        } else if (token == "ROLE_ADMIN") {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => const AdminPage()));
                                        }
                                      } else {
                                        // Show SnackBar for invalid credentials
                                        print("Invalid credentials, showing SnackBar"); // Debugging
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Invalid username or password'),

                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      // Handle API errors
                                      print("Login failed: ${e.toString()}"); // Debugging
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Login failed: ${e.toString()}'),
                                          action: SnackBarAction(
                                            label: 'Undo',
                                            onPressed: () {},
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromRGBO(13, 80, 175, 1.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(11))),
                              child: const Text(
                                "LOGIN",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                        SizedBox(height: Dimensions.height15),
                        dividerRow(),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Image.asset("assets/images/_google.png")],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Image.asset("assets/images/terms.png")
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveData(Map<String, dynamic> responseData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwtToken', responseData['jwtToken']);
    await prefs.setInt('id', responseData['id']);
    await prefs.setString('name', responseData['name']);
    await prefs.setString('email', responseData['email']);
    await prefs.setString('role', responseData['role']);
    await prefs.setBool('enabled', responseData['enabled']);
    await prefs.setInt('empID', responseData['empID']);
    await prefs.setInt('adminId', responseData['adminId']);
    await prefs.setString('companyName', responseData['companyName']);
    await prefs.setString('companyPhone', responseData['companyPhone']);
    await prefs.setString('work', responseData['work']);
    await prefs.setString('phone', responseData['phone']);
    await prefs.setString('companyAddress', responseData['companyAddress']);
    await prefs.setString('companyEmail', responseData['companyEmail']);
    await prefs.setString('logoImage', responseData['logoImage']);
    await prefs.setString('shiftTime', responseData['shiftTime']);
    await prefs.setString('gstin', responseData['gstin']);
  }
}

Widget dividerRow() {
  return Row(
    children: [
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
          child: const Divider(thickness: 1.3, color: Color.fromRGBO(11, 54, 143, 1.0)),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
        child: Text(
          'or',
          style: TextStyle(
            fontSize: Dimensions.font17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
          child: const Divider(
            thickness: 1.3,
            color: Color.fromRGBO(11, 54, 143, 1.0),
          ),
        ),
      ),
    ],
  );
}