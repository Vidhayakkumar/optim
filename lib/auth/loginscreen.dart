
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myfirstproject/onboarding/screen1.dart';
import 'package:myfirstproject/page/Admin_Page.dart';
import 'package:myfirstproject/auth/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../main.dart';
import '../page/Employee_Page.dart';
import 'api_service.dart';


class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool tracker=false;
  final bool _validate = false;
  bool _obsecureText=true;

  late String _email, _password;

  TextEditingController userIdController=TextEditingController();
  TextEditingController passwordController= TextEditingController();
  final  _formKey = GlobalKey<FormState>();


final ApiService _apiService= ApiService(DioClient());




  @override
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;
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
                    children: [
                      Image.asset("assets/images/Vector.png")
                    ],
                  ),
                ],
              ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Image.asset("assets/images/_icon.png"),
                      SizedBox(
                        height:mq.height * 0.1 ,
                      ),
                      Column(
                        children: [

                            TextFormField(

                              controller: userIdController,
                              decoration: InputDecoration(
                                errorText: _validate ? 'please enter email':null,
                                  label: const Text("Email Address"),
                                  suffixIcon: const Icon(Icons.email),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Color.fromRGBO(12, 80, 175,1.0)),
                                      borderRadius: BorderRadius.circular(11),
                                  ),

                                  enabledBorder:OutlineInputBorder(
                                      borderSide: const BorderSide(color: Color.fromRGBO(112, 100, 175,1.0)),
                                      borderRadius: BorderRadius.circular(11),

                                  ),

                              ),


                              validator: (val){

                                if(val == null || val.isEmpty){
                                  return "please enter text ";
                                }else{
                                  return null;
                                }

                              },

                     ),

                           SizedBox(height: mq.height * 0.02),
                          TextFormField(

                            obscureText: _obsecureText,
                            controller: passwordController,
                            decoration: InputDecoration(
                                label: const Text("Password"),
                                suffixIcon: IconButton(onPressed: (){
                                  setState(() {
                                    _obsecureText =! _obsecureText;
                                  });
                                }, icon: Icon(_obsecureText? Icons.visibility: Icons.visibility_off)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color.fromRGBO(12, 80, 175,1.0)),
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromRGBO(112, 100, 175,1.0)),
                                    borderRadius: BorderRadius.circular(11)
                                )
                            ),
                            validator: (val){

                              if(val == null || val.isEmpty){
                                return "please enter text ";
                              }else{
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
                              onChanged:(value){
                                setState(() {
                                  tracker= !tracker;
                                });
                              }
                          ),

                          const Text("Remember password ")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: (){}, child: const Text("Forget Password?"))
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                              width: 340,
                              height: 50,
                              child: ElevatedButton(onPressed: ()async{

                                var userAddress= userIdController.text.toString();
                                var passwordId=passwordController.text.toString();

                                if(_formKey.currentState!.validate()) {

                                }
                                var sharePref= await SharedPreferences.getInstance();

                                if(userAddress.isNotEmpty && passwordId.isNotEmpty){

                                 final response= await  _apiService.loginUser(userAddress, passwordId);
                                //  sharePref.setString(Screen1State.KEYlOGIN, token );

                                 saveData(response);

                                 final token = response['role'];

                                  if(token == "ROLE_EMP" ){
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (_)=>EmployeeScreen()));
                                  }else if(token == "ROLE_ADMIN"){
                                    Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_)=>AdminPage()));
                                  }

                                }else{
                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('wewe'),
                                 action: SnackBarAction(label: 'Undo', onPressed: (){},
                                 ),
                                 ));
                                }

                              }, child: Text("LOGIN",
                              style: TextStyle(
                                color: Colors.white
                              ),),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(
                                        13, 80, 175, 1.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(11)
                                    )
                                ),
                              )),
                          const SizedBox(height: 15),
                          DividerRow(),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/_google.png")
                            ],
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





Widget DividerRow(){
  return
    const Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              thickness: 1.3,
              color: Color.fromRGBO(11, 54, 143, 1.0)
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Text(
            'or',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              thickness: 1.3,
              color: Color.fromRGBO(11, 54, 143, 1.0),
            ),
          ),
        ),
      ],
    );

}


